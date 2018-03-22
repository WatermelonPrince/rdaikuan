//
//  PickerView.swift
//  Mhome
//
//  Created by mHome on 2017/6/9.
//  Copyright © 2017年 mHome. All rights reserved.
//

import UIKit

class MarketPickerView: PickerView{
    var removeAction : (()->())?
    override init(frame: CGRect) {
        super.init(frame: frame);
        picker.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 200 - frame.origin.y, width: SCREEN_WIDTH, height: 200)
        self.bottomView.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 240 - frame.origin.y, width: SCREEN_WIDTH, height: 40);

    }
    
    override func btnClick(sender: UIButton) {
        if sender.tag == 1 {
            let value = picker.selectedRow(inComponent: 0)
            if nameArr.count > 0 {
                print(nameArr[value])
                changeTitleAndClosure?(String(describing: nameArr[value]),value)
            }
            
        }
        
        self.superview?.removeFromSuperview()
        if (self.removeAction != nil){
            self.removeAction!();
        }
    }
    
    override func  touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.removeAction != nil){
            self.removeAction!();
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class PickerView: UIView ,UIPickerViewDelegate,UIPickerViewDataSource{

    //定义一个闭包
    var changeTitleAndClosure:((_ title:String,_ num:Int) -> Void)?
    var picker : UIPickerView!
    var nameArr : NSMutableArray!
    var titleLabel : UILabel!
    var bottomView : UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        self.backgroundColor = COLOR_FITERGROUD.withAlphaComponent(0.1);
        let arr = ["取消","确定"]
        self.bottomView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 240, width: SCREEN_WIDTH, height: 40))
        self.bottomView.backgroundColor = COLOR_BLUE_BUTTON;
        self.addSubview(self.bottomView)
        for i in 0..<2 {
            let button = UIButton(frame: CGRect(x: 15 + (SCREEN_WIDTH - 50 - 30)*CGFloat(i) , y: 0, width: 50, height: 40))
            button.setTitleColor(COLOR_WHITE, for: .normal)
            button.contentHorizontalAlignment = .center
            button.setTitle(arr[i], for: .normal)
            button.tag = i
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            button.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
            self.bottomView.addSubview(button)
        }
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: 10, width: SCREEN_WIDTH/2, height: 20));
        self.titleLabel.center.x = SCREEN_WIDTH/2;
        self.titleLabel.font = UIFont.systemFont(ofSize: 15);
        self.titleLabel.textColor = COLOR_WHITE;
        self.titleLabel.textAlignment = .center;
        self.bottomView.addSubview(self.titleLabel);
        picker = UIPickerView()
        picker.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 200, width: SCREEN_WIDTH, height: 200)
        picker.backgroundColor = UIColor.white
        picker.delegate = self
        picker.dataSource = self
        self.addSubview(picker)
    }
    func btnClick(sender : UIButton){
        if sender.tag == 1 {
            let value = picker.selectedRow(inComponent: 0)
            if nameArr.count > 0 {
                print(nameArr[value])
                changeTitleAndClosure?(String(describing: nameArr[value]),value)
            }
           
        }
        
        self.removeFromSuperview()
        
    }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nameArr.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nameArr[row] as? String
    }
    override func  touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
