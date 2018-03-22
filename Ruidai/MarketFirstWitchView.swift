//
//  MarketFirstWitchView.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/9.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MarketFirstWitchView: UIView,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {
    
    var tableView : UITableView?
    var backGroundView : UIView?
    var choiceArr = Array<Tags>()
    var selected:Bool = false;
    var tapGesture : UITapGestureRecognizer?
    var tapCellActionHanlder: ((_ Index: Int?)->())?
    var reloadBtnTitleHanlder: ((_ titlteStr: String?)->())?
    var hasSelectedTag: Bool?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backGroundView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT));
        self.backGroundView?.backgroundColor = COLOR_BLACK.withAlphaComponent(0.6);
        self.tableView = UITableView();
        self.tableView?.delegate = self;
        self.tableView?.dataSource = self;
        self.tableView?.register(MarketFirstSwitchCellTableViewCell.classForCoder(), forCellReuseIdentifier: "MarketFirstSwitchCellTableViewCell");
        self.tapGesture = UITapGestureRecognizer();
        self.tapGesture?.delegate = self;
        self.backGroundView?.addGestureRecognizer(self.tapGesture!);
    }
    
    
    convenience init(choiceArr: Array<Tags>,frame: CGRect) {
        self.init(frame: frame);
        self.tableView?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44 * CGFloat(choiceArr.count));
        self.choiceArr = choiceArr;
        self.addSubview(self.backGroundView!);
        self.backGroundView?.addSubview(self.tableView!);
        self.tableView?.reloadData();
    }
    
    func reloadFilterTableViewWithData(arr: Array<Tags>){
        self.choiceArr.removeAll();
        var indexSelected = -1;
        for (index,item) in arr.enumerated() {
            if item.hasSelected == true {
                indexSelected = index;
            }
        }
        
        self.choiceArr = arr;
        if indexSelected == -1 && self.choiceArr.count > 0{
            self.choiceArr[0].hasSelected = true;
            indexSelected = 0;
        }
        if self.choiceArr.count > 0 {
            if self.choiceArr[indexSelected].name != nil && self.reloadBtnTitleHanlder != nil{
                self.reloadBtnTitleHanlder!(self.choiceArr[indexSelected].name);
            }
        }
        
        
        self.tableView?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44 * CGFloat(choiceArr.count));
        self.tableView?.reloadData();
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if NSStringFromClass((touch.view?.classForCoder)!) == "UITableViewCellContentView" {
            return false;
        }
        return true;
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketFirstSwitchCellTableViewCell")as! MarketFirstSwitchCellTableViewCell;
        let tag = self.choiceArr[indexPath.row];
        cell.titleLabel.text = self.choiceArr[indexPath.row].name;
        if tag.hasSelected == true{
            cell.setCellSelected(isSelected: true);
        }else{
            cell.setCellSelected(isSelected: false);
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.choiceArr.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for (index,item) in self.choiceArr.enumerated() {
            if index != indexPath.row {
                item.isSelected = false;
            }else{
                item.isSelected = true;
            }
        }
        if self.tapCellActionHanlder != nil {
            self.tapCellActionHanlder!(indexPath.row);
        }
        self.tableView?.reloadData();
                

        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}
