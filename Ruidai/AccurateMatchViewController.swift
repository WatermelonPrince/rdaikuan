//
//  AccurateMatchViewController.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/9/22.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class AccurateMatchViewController: CommonBaseScrollViewController,HHRuleViewDelegate,ServiceDelegate {
    var iconImage : UIImageView?
    var applyAmountBgView : UIView?
    var loanTermBgView : UIView?
    var conditionBgView : UIView?
    var requstBgView : UIView?
    var amountView : HHRuleView?
    var loanTermDayView : HHRuleView?
    var loanTermMonthView : HHRuleView?
    var switchTermButton : UIButton?
    var selectedAmount : Int?
    var selectedMonth : Int?
    var selectedDay : Int?
    var selectedTermStyle : Int?
    var matchButton : UIButton?
    var accurateMatchInfoService : AccurateMatchInfoService!
    
    var loanAmountRuler: ProductRuler?
    var repayDayRuler: ProductRuler?
    var repayMonthRuler: ProductRuler?
    var searchContent: String?
    var searchTags: Array<Tags>?
    var repaymentContent: String?
    var repaymentTags: Array<Tags>?
    
    var conditionBtns = Array<TagButton>();
    var repaymentBtns = Array<TagButton>();
    var selectedConditonArr = Array<Tags>();
    var selectedrepaymentTag: Tags?
    var isRulerInDay: Bool?
    
    
    var loanAmount : String?
    var repayDays : String?
    var authorizeTags: String?
    var repayMethod: String?
    
//    var scrollView: UIScrollView!





    override func viewDidLoad() {
        super.viewDidLoad();
//        self.tableView.frame = CGRect.zero;
//        self.scrollView = UIScrollView.init(frame: CGRect(x: 0, y: -64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT));
        self.scrollView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - TABBARHEIGHT);
        self.scrollView.delegate = self;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.scrollView.contentSize = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT + 500);
        navBarBackgroundAlpha = 0
        self.iconImage = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH/750*375));
        self.iconImage?.contentMode = .scaleAspectFill;
        self.iconImage?.image = #imageLiteral(resourceName: "icon_ruizhibanner");
        self.scrollView.addSubview(self.iconImage!);
        self.applyAmountBgView = UIView();
        self.loanTermBgView = UIView();
        self.conditionBgView = UIView();
        self.requstBgView = UIView();
        self.scrollView.addSubview(self.applyAmountBgView!);
        self.scrollView.addSubview(self.loanTermBgView!);
        self.scrollView.addSubview(self.conditionBgView!);
        self.scrollView.addSubview(self.requstBgView!);
        self.scrollView.backgroundColor = COLOR_WHITE;
        
       
        
//        self.reloadFilterView();
//        self.reloadConditionView();
//        self.reloadRequstView();
        
        self.matchButton = UIButton(frame: CGRect(x: 0, y: SCREEN_HEIGHT - FOOTERSAFEHEIGHT - 50, width: SCREEN_WIDTH, height: 50));
        self.matchButton?.backgroundColor = COLOR_BLUE;
        self.matchButton?.setTitle("开始匹配", for: .normal);
        self.matchButton?.addTarget(self, action: #selector(pushIntoMarketListViewController), for: .touchUpInside);
        self.view.addSubview(self.matchButton!);
        self.accurateMatchInfoService = AccurateMatchInfoService(delegate: self);
        self.accurateMatchInfoService.getAccurateMatchInfo();
        
        
    }
    
    
    
    func pushIntoMarketListViewController(){
        self.loanAmount = self.reduceSelectedLoanAmountValue();
        self.repayDays = self.reduceSelectedRepaymentDays();
        self.reduceSelectedConditionTagAndSelectedRequstTag();
        let vc = PushLoanMarketViewController();
        vc.loanAmount = self.loanAmount;
        vc.repayDays = self.repayDays;
        vc.authorizeTags = self.authorizeTags;
        vc.repayMethod = self.repayMethod;
        self.pushViewController(viewController: vc);
    }
    
     func onCompleteSuccess(service: BaseService) {
        if service == self.accurateMatchInfoService {
            if self.accurateMatchInfoService.loanAmountRuler != nil && self.accurateMatchInfoService.repayDayRuler != nil && self.accurateMatchInfoService.repayMonthRuler != nil{
                self.loanAmountRuler = self.accurateMatchInfoService.loanAmountRuler;
                self.repayDayRuler = self.accurateMatchInfoService.repayDayRuler;
                self.repayMonthRuler = self.accurateMatchInfoService.repayMonthRuler;
                self.reloadFilterView();
            }
            if self.accurateMatchInfoService.searchTags != nil {
                self.searchTags = self.accurateMatchInfoService.searchTags;
                self.reloadConditionView();
            }
            if self.accurateMatchInfoService.repaymentTags != nil {
                self.repaymentTags = self.accurateMatchInfoService.repaymentTags;
                self.reloadRequstView();
            }
        }
    }
    
    func reloadFilterView(){
        let header = MatchViewHeader(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 45));
        header.titleLabel.text = "申请金额（元）"
        header.verLineView.backgroundColor = COLOR_BLUE;
        guard let scaleMax = self.loanAmountRuler?.scaleMax,let scaleMin = self.loanAmountRuler?.scaleMin,let scaleUnit = self.loanAmountRuler?.scaleUnit  else {
            return;
        }
        self.amountView = HHRuleView.init(maxValue: scaleMax, minValue: scaleMin, scale: scaleUnit * 10, unitStr: nil, frame: CGRect(x: 0, y: header.bottom(), width: SCREEN_WIDTH, height: 140));
        self.amountView?.delegate = self;
        self.amountView?.isRound = true;
        self.applyAmountBgView?.addSubview(header);
        self.applyAmountBgView?.addSubview(self.amountView!);
        self.applyAmountBgView?.frame = CGRect(x: 0, y: (self.iconImage?.bottom())!, width: SCREEN_WIDTH, height: (self.amountView?.bottom())!);
        
        let secondHeader = MatchViewHeader(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 45));
        secondHeader.titleLabel.text = "贷款期限";
        secondHeader.verLineView.backgroundColor = COLOR_BLUE;
        guard let dayMax = self.repayDayRuler?.scaleMax,let dayMin = self.repayDayRuler?.scaleMin,let dayUnit = self.repayDayRuler?.scaleUnit  else {
            return;
        }
        self.loanTermDayView = HHRuleView.init(maxValue: dayMax, minValue: dayMin, scale: dayUnit * 10, unitStr: "天", frame: CGRect(x: 0, y: secondHeader.bottom(), width: SCREEN_WIDTH, height: 150));
        guard let monthMax = self.repayMonthRuler?.scaleMax,let monthMin = self.repayMonthRuler?.scaleMin,let monthUnit = self.repayMonthRuler?.scaleUnit  else {
            return;
        }
         self.loanTermMonthView = HHRuleView.init(maxValue: monthMax, minValue: monthMin, scale: monthUnit*10, unitStr: "月", frame: CGRect(x: 0, y: secondHeader.bottom(), width: SCREEN_WIDTH, height: 150));
        self.loanTermDayView?.delegate = self;
        self.loanTermDayView?.isRound = true;
        self.loanTermMonthView?.delegate = self;
        self.loanTermMonthView?.isRound = true;
        self.loanTermMonthView?.isHidden = true;
        self.loanTermBgView?.addSubview(secondHeader);
        self.isRulerInDay = true;
        
        self.switchTermButton = UIButton(frame: CGRect(x: SCREEN_WIDTH/2 - 47, y: (self.loanTermDayView?.height())!/2 + 30, width: 94, height: 18));
        self.switchTermButton?.setImage(#imageLiteral(resourceName: "icon_day_switch"), for: .normal);
        self.switchTermButton?.setImage(#imageLiteral(resourceName: "icon_month_switch"), for: .selected);
        self.switchTermButton?.addTarget(self, action: #selector(switchDayAndMonthAction), for: .touchUpInside);
        
        self.loanTermBgView?.addSubview(self.loanTermDayView!);
        self.loanTermBgView?.addSubview(self.loanTermMonthView!);
        self.loanTermBgView?.addSubview(self.switchTermButton!);
        self.loanTermBgView?.frame = CGRect(x: 0, y: (self.applyAmountBgView?.bottom())! + 10, width: SCREEN_WIDTH, height: (self.loanTermDayView?.bottom())!);
        
        self.scrollView.contentSize = CGSize.init(width: SCREEN_WIDTH, height: (self.loanTermBgView?.bottom())! + 100);

        
    }
    
    
    
    func reloadConditionView(){
        self.selectedConditonArr.removeAll();
        self.conditionBtns.removeAll();
        let header = MatchViewHeader(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 45));
        header.titleLabel.text = "我的"
        header.verLineView.backgroundColor = COLOR_BLUE;
        self.conditionBgView?.addSubview(header);
        self.conditionBgView?.backgroundColor = COLOR_WHITE;
//        let arr = [0,1,2,3,4,5];
        guard let arr = self.searchTags else {
            return;
        }
        let spaceWidth = CGFloat(12);
        let itemWidth = CGFloat((SCREEN_WIDTH - 5 * 12)/4);
        let itemHeight = CGFloat(30);
        var totalHeight = CGFloat(0);
        for (index,item) in arr.enumerated() {
            let a = index%4;
            let b = index/4;
            let button = TagButton(frame: CGRect(x: spaceWidth + (itemWidth + spaceWidth)*CGFloat(a), y: header.bottom() + 10 + (itemHeight + 10)*CGFloat(b), width: itemWidth, height: itemHeight));
            button.setTitle(item.name, for: .normal);
            
            button.setSelectedTrueOrFalse(isSelected: false);
            
           
            button.addTarget(self, action: #selector(addConditionAction), for: .touchUpInside);
            button.tag = index + 333;
            self.conditionBtns.append(button);


            self.conditionBgView?.addSubview(button);
            totalHeight = button.bottom();
        }
        
        self.conditionBgView?.frame = CGRect(x: 0, y: (self.loanTermBgView?.bottom())! + 10, width: SCREEN_WIDTH, height:totalHeight);
        
        self.scrollView.contentSize = CGSize.init(width: SCREEN_WIDTH, height: (self.conditionBgView?.bottom())! + 100);

        
    }
    
    func reloadRequstView(){
        self.repaymentBtns.removeAll();
        let header = MatchViewHeader(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 45));
        header.titleLabel.text = "我想"
        header.verLineView.backgroundColor = COLOR_BLUE;
        self.requstBgView?.addSubview(header);
        self.requstBgView?.backgroundColor = COLOR_WHITE;
        guard let arr = self.repaymentTags else {
            return;
        }
        let spaceWidth = CGFloat(12);
        let itemWidth = CGFloat((SCREEN_WIDTH - 5 * 12)/4);
        let itemHeight = CGFloat(30);
        var totalHeight = CGFloat(0);
        for (index,item) in arr.enumerated() {
            let a = index%4;
            let b = index/4;
            let button = TagButton(frame: CGRect(x: spaceWidth + (itemWidth + spaceWidth)*CGFloat(a), y: header.bottom() + 10 + (itemHeight + 10)*CGFloat(b), width: itemWidth, height: itemHeight));
            button.setTitle(item.name, for: .normal);
            
            button.setSelectedTrueOrFalse(isSelected: false);
            
            
            button.addTarget(self, action: #selector(switchRepaymentMethodAction), for: .touchUpInside);
            button.tag = index + 222;
            self.repaymentBtns.append(button);

            
           
            
            
            self.requstBgView?.addSubview(button);
            totalHeight = button.bottom();
        }
        
        self.requstBgView?.frame = CGRect(x: 0, y: (self.conditionBgView?.bottom())! + 10, width: SCREEN_WIDTH, height:totalHeight);
        
        self.scrollView.contentSize = CGSize.init(width: SCREEN_WIDTH, height: (self.requstBgView?.bottom())! + 100);

    }
    
    func switchRepaymentMethodAction(action: UIButton){
        let btn = action as! TagButton;
        let tag = self.repaymentTags?[action.tag - 222];
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
    
    func addConditionAction(action: UIButton){
        let btn = action as! TagButton;
        let tag = self.searchTags?[action.tag - 333];
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
    
    
    func switchDayAndMonthAction(){
        self.isRulerInDay = !self.isRulerInDay!;
        self.switchTermButton?.isSelected = !(self.switchTermButton?.isSelected)!;
        self.loanTermMonthView?.isHidden = !(self.switchTermButton?.isSelected)!;
    }
    
    func ruleViewDidScroll(_ ruleView: HHRuleView!, pointValue value: CGFloat) {
        if ruleView.isEqual(self.loanTermDayView) {
            self.selectedDay = Int(value);
        }
        if ruleView.isEqual(self.amountView) {
            self.selectedAmount = Int(value);
        }
        if ruleView.isEqual(self.loanTermMonthView) {
            self.selectedMonth = Int(value);
        }
    }
    
    func reduceSelectedLoanAmountValue() -> String? {
        if self.selectedAmount == nil {
            self.loanAmount = nil;
            return self.loanAmount;
        }else{
            self.loanAmount = String(describing: self.selectedAmount!);
            return self.loanAmount;
        }
    }
    
    func reduceSelectedRepaymentDays() -> String? {
        if self.selectedDay == nil && self.selectedMonth == nil {
            self.repayDays = nil;
            return self.repayDays;
        }
        if self.isRulerInDay == true && self.selectedDay == nil {
            self.repayDays = nil;
            return self.repayDays;
        }
        if self.isRulerInDay == false && self.selectedMonth == nil {
            self.repayDays = nil;
            return self.repayDays;
        }
        if self.isRulerInDay == true && self.selectedDay != nil {
            self.repayDays = String(describing: self.selectedDay!);
            return self.repayDays;
        }
        if self.isRulerInDay == false && self.selectedMonth != nil {
            let day = self.selectedMonth! * 30;
            self.repayDays = String(day);
            return self.repayDays;
        }
        return nil;
    }
    
    func reduceSelectedConditionTagAndSelectedRequstTag(){
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
        self.authorizeTags = authorizeTagsStr;
        self.repayMethod = repayMethodStr;
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        MXNavigationBarManager.changeAlpha(withCurrentOffset: scrollView.contentOffset.y);
        super.scrollViewDidScroll(scrollView);
        let offsetY = scrollView.contentOffset.y
        
        if (offsetY > SCREEN_WIDTH/750*375)
        {
            let alpha = (offsetY - SCREEN_WIDTH/750*375) / CGFloat(64)
            navBarBackgroundAlpha = alpha
            navBarTintColor = COLOR_WHITE.withAlphaComponent(alpha)
            navBarTitleColor = COLOR_WHITE.withAlphaComponent(alpha)
            statusBarStyle = .default
            self.title = "智能匹配";

        }
        else
        {
            navBarBackgroundAlpha = 0
            navBarTintColor = .white
            navBarTitleColor = .white
            statusBarStyle = .lightContent
            self.title = "";
        }
        self.view.endEditing(true);
    }

}
