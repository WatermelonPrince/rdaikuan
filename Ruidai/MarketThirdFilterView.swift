//
//  MarketThirdFilterView.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/9.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MarketThirdFilterView: UIView {
    var conditionLabel: UILabel?
    var repaymentMethodLabel: UILabel?
    var conditionBgView: UIView?
    var repaymentMethodBgView: UIView?
    var resetBtn: UIButton?
    var makeSureBtn: UIButton?
    var backGroudView: UIView?
    var backView: UIView?
    var buttonBgView: UIView?
    var tapGesture : UITapGestureRecognizer?
    var conditionArr : Array<Tags>?
    var repaymentArr : Array<Tags>?
    var selectedConditonArr = Array<Tags>();
    var selectedrepaymentTag: Tags?
    
    var conditionBtns = Array<TagButton>();
    var repaymentBtns = Array<TagButton>();
    
    var makeSureActionHanlder: ((_ authorizeTags: String?,_ repayMethod: String?)->())?
    var reloadViewHanlder: ((_ btnStr: String)->())?

    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    convenience init(conditionArr: Array<Tags>,repaymentArr: Array<Tags>,conditonTitle: String,repaymentTitle: String,frame: CGRect) {
        self.init(frame: frame);
        self.backGroudView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 44));
        self.backGroudView?.backgroundColor = COLOR_BLACK.withAlphaComponent(0.7);
        self.backView = UIView();
        self.conditionBgView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0));
        
        self.conditionArr = conditionArr;
        self.repaymentArr = repaymentArr;
        self.conditionBtns.removeAll();
        self.repaymentBtns.removeAll();
        if conditionArr.count > 0 {
            self.conditionLabel = UILabel(frame: CGRect(x: 15, y: 15, width: SCREEN_WIDTH - 30, height: 20));
            self.conditionLabel?.textColor = COLOR_FONT_HEAD;
            self.conditionLabel?.font = UIFont.systemFont(ofSize: 14);
            self.conditionLabel?.text = conditonTitle;
            self.conditionBgView?.addSubview(self.conditionLabel!);
            let spaceWidth = CGFloat(12);
            let itemWidth = CGFloat((SCREEN_WIDTH - 5 * 12)/4);
            let itemHeight = CGFloat(30);
            var totalHeight = CGFloat(0);
            for (index,item) in conditionArr.enumerated() {
                let a = index%4;
                let b = index/4;
                let button = TagButton(frame: CGRect(x: spaceWidth + (itemWidth + spaceWidth)*CGFloat(a), y: (self.conditionLabel?.bottom())! + 10 + (itemHeight + 10)*CGFloat(b), width: itemWidth, height: itemHeight));
                button.setSelectedTrueOrFalse(isSelected: false);
                button.setTitle(item.name ?? "", for: .normal);
                button.addTarget(self, action: #selector(addConditionAction), for: .touchUpInside);
                button.tag = index + 333;

                self.conditionBtns.append(button);
                totalHeight = button.bottom();
                self.conditionBgView?.addSubview(button);
            }
            let lineView = UIView(frame: CGRect(x: 0, y: totalHeight + 14.5, width: SCREEN_WIDTH, height: 0.5));
            lineView.backgroundColor = COLOR_BORDER;
            self.conditionBgView?.addSubview(lineView);
            self.conditionBgView?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: totalHeight + 15);
        }
        self.repaymentMethodBgView = UIView(frame:CGRect(x: 0, y: (self.conditionBgView?.bottom())!, width: SCREEN_WIDTH, height: 0));
        if repaymentArr.count > 0 {
            self.repaymentMethodLabel = UILabel(frame: CGRect(x: 15, y: 15, width: SCREEN_WIDTH - 30, height: 20));
            self.repaymentMethodLabel?.textColor = COLOR_FONT_HEAD;
            self.repaymentMethodLabel?.font = UIFont.systemFont(ofSize: 14);
            self.repaymentMethodLabel?.text = repaymentTitle;
            self.repaymentMethodBgView?.addSubview(self.repaymentMethodLabel!);
            
            let spaceWidth = CGFloat(12);
            let itemWidth = CGFloat((SCREEN_WIDTH - 5 * 12)/3.6);
            let itemHeight = CGFloat(30);
            var totalHeight = CGFloat(0);
            for (index,item) in repaymentArr.enumerated() {
                let a = index%3;
                let b = index/3;
                let button = TagButton(frame: CGRect(x: spaceWidth + (itemWidth + spaceWidth)*CGFloat(a), y: (self.repaymentMethodLabel?.bottom())! + 10 + (itemHeight + 10)*CGFloat(b), width: itemWidth, height: itemHeight));
                button.setSelectedTrueOrFalse(isSelected: false);
                button.setTitle(item.name ?? "", for: .normal);
                button.addTarget(self, action: #selector(switchRepaymentMethodAction), for: .touchUpInside);
                button.tag = index + 222;
                self.repaymentBtns.append(button);


              
                totalHeight = button.bottom();
                self.repaymentMethodBgView?.addSubview(button);
            }
            let lineView = UIView(frame: CGRect(x: 0, y: totalHeight + 14.5, width: SCREEN_WIDTH, height: 0.5));
            lineView.backgroundColor = COLOR_BORDER;
            self.repaymentMethodBgView?.addSubview(lineView);
            self.repaymentMethodBgView?.frame = CGRect(x: 0, y: (self.conditionBgView?.bottom())!, width: SCREEN_WIDTH, height: totalHeight + 15);
        }
        
        self.buttonBgView = UIView(frame: CGRect(x: 0, y: (self.repaymentMethodBgView?.bottom())!, width: SCREEN_WIDTH, height: 65));
        let spaceWidth = CGFloat((SCREEN_WIDTH - 210)/5)
        self.resetBtn = MarketBaseButton(frame: CGRect(x: spaceWidth * 2, y: 15, width: 105, height: 35));
        self.resetBtn?.isSelected = false;
        self.makeSureBtn = MarketBaseButton(frame: CGRect(x: (self.resetBtn?.right())! + spaceWidth, y: 15, width: 105, height: 35));
        self.makeSureBtn?.isSelected = true;
        self.resetBtn?.addTarget(self, action: #selector(resetSelectedAction), for: .touchUpInside);
        self.makeSureBtn?.addTarget(self, action: #selector(makesureSelectionAction), for: .touchUpInside);
        self.buttonBgView?.addSubview(self.resetBtn!);
        self.buttonBgView?.addSubview(self.makeSureBtn!);
        
        self.backView?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: (self.buttonBgView?.bottom())!);
        self.backView?.addSubview(self.conditionBgView!);
        self.backView?.addSubview(self.repaymentMethodBgView!);
        self.backView?.addSubview(self.buttonBgView!);

        
        self.backView?.backgroundColor = COLOR_WHITE;
        
        self.backGroudView?.addSubview(self.backView!);
        
        self.addSubview(self.backGroudView!);
        self.addSubview(self.backView!);
        
        
        self.tapGesture = UITapGestureRecognizer();
//        self.tapGesture?.delegate = self;
        self.backGroudView?.addGestureRecognizer(self.tapGesture!);

        
        
        
        
        
        
        
    }
    
    func resetSelectedAction(){
        self.selectedConditonArr.removeAll();
        self.selectedrepaymentTag = nil;
        for item in self.conditionBtns {
            item.setSelectedTrueOrFalse(isSelected: false);
        }
        
        for item in self.repaymentBtns {
            item.setSelectedTrueOrFalse(isSelected: false);
        }
        
        
    }
    
    func makesureSelectionAction(){
        var authorizeTagsStr = "";
        var repayMethodStr = "";
        
        var tagIdArr = Array<Int>();
        for item in self.selectedConditonArr {
            tagIdArr.append(item.tagsId!);
        }
        if (self.selectedConditonArr.count) > 0 {
            authorizeTagsStr = CommonUtil.toServerParameterString(IndexArray: tagIdArr);
        }else{
            authorizeTagsStr = "";
        }
        if self.selectedrepaymentTag != nil && self.selectedrepaymentTag?.tagsId != nil {
            repayMethodStr = "\(String(describing: self.selectedrepaymentTag!.tagsId!))";
        }else{
            repayMethodStr = ""
        }
        if self.makeSureActionHanlder != nil {
            self.makeSureActionHanlder!(authorizeTagsStr,repayMethodStr);
        }
        
        
        
        
    }
    
    
    
    func addConditionAction(action: UIButton){
        let btn = action as! TagButton;
        let tag = self.conditionArr?[action.tag - 333];
        if btn.isSelected == false {
            btn.setSelectedTrueOrFalse(isSelected: true);
            self.selectedConditonArr.append(tag!);
        }else{
            btn.setSelectedTrueOrFalse(isSelected: false);
            var newArr = Array<Tags>();
            for indexTag in self.selectedConditonArr {
                if indexTag.tagsId != tag?.tagsId {
                    newArr.append(indexTag);
                }
            }
            self.selectedConditonArr = newArr;
        }
       
    }
    
    func switchRepaymentMethodAction(action: UIButton){
        let btn = action as! TagButton;
        let tag = self.repaymentArr?[action.tag - 222];
        if tag?.tagsId != self.selectedrepaymentTag?.tagsId {
            for item in self.repaymentBtns {
                item.setSelectedTrueOrFalse(isSelected: false);
            }
            btn.setSelectedTrueOrFalse(isSelected: true);
            self.selectedrepaymentTag = tag;
        }else{
            for item in self.repaymentBtns {
                item.setSelectedTrueOrFalse(isSelected: false);
            }
            self.selectedrepaymentTag = nil;
        }

       
        

        
        

    }
    
    
    func reloadViewWithData(conditionArr: Array<Tags>,repaymentArr: Array<Tags>,conditonTitle: String,repaymentTitle: String){
        
        self.conditionArr = conditionArr;
        self.repaymentArr = repaymentArr;
        self.conditionBtns.removeAll();
        self.repaymentBtns.removeAll();
        self.selectedConditonArr.removeAll();
        self.selectedrepaymentTag = nil;
        
        for view in (self.conditionBgView?.subviews)! {
            view.removeFromSuperview();
        }
        for view in (self.repaymentMethodBgView?.subviews)! {
            view.removeFromSuperview();
        }
        
        if conditionArr.count > 0 {
            self.conditionLabel = UILabel(frame: CGRect(x: 15, y: 15, width: SCREEN_WIDTH - 30, height: 20));
            self.conditionLabel?.textColor = COLOR_FONT_HEAD;
            self.conditionLabel?.font = UIFont.systemFont(ofSize: 14);
            self.conditionLabel?.text = conditonTitle;
            self.conditionBgView?.addSubview(self.conditionLabel!);
            let spaceWidth = CGFloat(12);
            let itemWidth = CGFloat((SCREEN_WIDTH - 5 * 12)/4);
            let itemHeight = CGFloat(30);
            var totalHeight = CGFloat(0);
            for (index,item) in conditionArr.enumerated() {
                let a = index%4;
                let b = index/4;
                let button = TagButton(frame: CGRect(x: spaceWidth + (itemWidth + spaceWidth)*CGFloat(a), y: (self.conditionLabel?.bottom())! + 10 + (itemHeight + 10)*CGFloat(b), width: itemWidth, height: itemHeight));
                    if item.hasSelected == true {
                        button.setSelectedTrueOrFalse(isSelected: true);
                        self.selectedConditonArr.append(item);
                    }else{
                        button.setSelectedTrueOrFalse(isSelected: false);
                    }
                
                button.setTitle(item.name ?? "", for: .normal);
                button.addTarget(self, action: #selector(addConditionAction), for: .touchUpInside);
                button.tag = index + 333;
                
                self.conditionBtns.append(button);
                totalHeight = button.bottom();
                self.conditionBgView?.addSubview(button);
            }
            let lineView = UIView(frame: CGRect(x: 0, y: totalHeight + 14.5, width: SCREEN_WIDTH, height: 0.5));
            lineView.backgroundColor = COLOR_BORDER;
            self.conditionBgView?.addSubview(lineView);
            self.conditionBgView?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: totalHeight + 15);
        }
        
        if repaymentArr.count > 0 {
            self.repaymentMethodLabel = UILabel(frame: CGRect(x: 15, y: 15, width: SCREEN_WIDTH - 30, height: 20));
            self.repaymentMethodLabel?.textColor = COLOR_FONT_HEAD;
            self.repaymentMethodLabel?.font = UIFont.systemFont(ofSize: 14);
            self.repaymentMethodLabel?.text = repaymentTitle;
            self.repaymentMethodBgView?.addSubview(self.repaymentMethodLabel!);
            
            let spaceWidth = CGFloat(12);
            let itemWidth = CGFloat((SCREEN_WIDTH - 5 * 12)/3.6);
            let itemHeight = CGFloat(30);
            var totalHeight = CGFloat(0);
            for (index,item) in repaymentArr.enumerated() {
                let a = index%3;
                let b = index/3;
                let button = TagButton(frame: CGRect(x: spaceWidth + (itemWidth + spaceWidth)*CGFloat(a), y: (self.repaymentMethodLabel?.bottom())! + 10 + (itemHeight + 10)*CGFloat(b), width: itemWidth, height: itemHeight));
                
                    if item.hasSelected == true {
                        button.setSelectedTrueOrFalse(isSelected: true);
                        self.selectedrepaymentTag = item;
                    }else{
                        button.setSelectedTrueOrFalse(isSelected: false);
                    }
                button.setTitle(item.name ?? "", for: .normal);
                button.addTarget(self, action: #selector(switchRepaymentMethodAction), for: .touchUpInside);
                button.tag = index + 222;
                self.repaymentBtns.append(button);
                
                
                
                totalHeight = button.bottom();
                self.repaymentMethodBgView?.addSubview(button);
            }
            let lineView = UIView(frame: CGRect(x: 0, y: totalHeight + 14.5, width: SCREEN_WIDTH, height: 0.5));
            lineView.backgroundColor = COLOR_BORDER;
            self.repaymentMethodBgView?.addSubview(lineView);
            self.repaymentMethodBgView?.frame = CGRect(x: 0, y: (self.conditionBgView?.bottom())!, width: SCREEN_WIDTH, height: totalHeight + 15);
        }
        var titleStr = "";
        
        if self.selectedConditonArr.count > 0 {
            for item in self.selectedConditonArr {
                titleStr.append(item.name ?? "");
            }
        }
        
        if self.selectedrepaymentTag != nil {
            titleStr.append((self.selectedrepaymentTag?.name)!);
        }
        if self.reloadViewHanlder != nil {
            if titleStr == "" {
                titleStr = "条件筛选";
            }
            self.reloadViewHanlder!(titleStr);
        }
        
        self.buttonBgView?.frame = CGRect(x: 0, y: (self.repaymentMethodBgView?.bottom())!, width: SCREEN_WIDTH, height: 65);
        
        self.backView?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: (self.buttonBgView?.bottom())!);
        self.backView?.addSubview(self.conditionBgView!);
        self.backView?.addSubview(self.repaymentMethodBgView!);
        self.backView?.addSubview(self.buttonBgView!);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
