//
//  MarketSecondFilterView.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/9.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MarketSecondFilterView: UIView {
    var pickerView : MarketPickerView!
    var backGroudView : UIView!
    var transformBtn : MarketSwitchButton?
    var selectedAmountHanlder: ((_ index: Int,_ titleStr: String)-> ())?
    var dataArr = Array<String>();
    var reloadViewBtnTitleHanlder: ((_ btnTitle: String?)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backGroudView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT));
        self.backGroudView?.backgroundColor = COLOR_BLACK.withAlphaComponent(0.6);
        self.pickerView = MarketPickerView(frame: frame);
        self.pickerView.changeTitleAndClosure = {
            (title:String , num : Int)  in
            
            if self.selectedAmountHanlder != nil {
                
                self.selectedAmountHanlder!(num,title);
            }
            
            
        }
        self.pickerView.removeAction = {
            () in
            if self.transformBtn != nil {
                self.transformBtn?.setSelectedTureOrFalse(selected: false);
            }
            self.removeFromSuperview();
        }
        
        self.pickerView.nameArr = ["金额不限","500元","1500元","10000元"];
        self.pickerView.titleLabel.text = "选择金额";
        self.backGroudView.addSubview(self.pickerView);
        
        self.addSubview(self.backGroudView);
        self.addSubview(self.pickerView);
    }
    
    
    func reloadPickerViewWithArr(arr: Array<Tags>){
        self.dataArr.removeAll();
        var indexSlected = -1;
        for (index,item) in arr.enumerated() {
            self.dataArr.append(item.name ?? "");
            if item.hasSelected == true {
                indexSlected = index;
                if self.reloadViewBtnTitleHanlder != nil {
                    self.reloadViewBtnTitleHanlder!(item.name ?? "不限金额");
                }
            }
        }
         self.pickerView.nameArr = NSMutableArray(array: self.dataArr);
        if self.pickerView.nameArr.count > 0 && indexSlected != -1{
            self.pickerView.picker.selectRow(indexSlected, inComponent: 0, animated: false);
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

   

}
