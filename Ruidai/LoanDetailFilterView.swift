//
//  LoanDetailFilterView.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/25.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class DoubelLabel: UIView {
    var titleLabel: UILabel!
    var countLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 90, height: 15));
        self.titleLabel.textAlignment = .center;
        self.titleLabel.font = UIFont.systemFont(ofSize: 13 * RATIO);
        self.titleLabel.textColor = COLOR_WHITE;
        self.countLabel = UILabel(frame: CGRect(x: 0, y: self.titleLabel.bottom() + 18, width: self.titleLabel.width(), height: 22));
        self.countLabel.textAlignment = .center;
        self.countLabel.font = UIFont.boldSystemFont(ofSize: 20 * RATIO);
        self.countLabel.textColor = COLOR_WHITE;
        self.addSubview(self.titleLabel);
        self.addSubview(self.countLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FilterFiled: UIView {
    var imageView : UIImageView!
    var label : UILabel!
    var filterControl : UIControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        let width = (SCREEN_WIDTH - 65)/2;
        self.label = UILabel(frame: CGRect(x: 10, y: 0, width: width - 30, height: 30));
        self.label.textColor = COLOR_WHITE;
        self.label.font = UIFont.systemFont(ofSize: 13);
        self.imageView = UIImageView(frame: CGRect(x: width - 20, y: 0, width: 7, height: 4))
        self.imageView.image = #imageLiteral(resourceName: "icon_detail_xiala");
//        self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI/2));
        self.imageView.center.y = 30/2;
        

        self.filterControl = UIControl(frame: CGRect(x: 0, y: 0, width: width, height: 30));
        self.filterControl.layer.cornerRadius = 3;
//        self.filterControl.layer.borderWidth = 0.5;
//        self.filterControl.layer.borderColor = COLOR_BLUE?.cgColor;
        self.filterControl.backgroundColor = COLOR_WHITE.withAlphaComponent(0.5);
        self.addSubview(self.imageView);
        self.addSubview(self.label);
        self.addSubview(self.filterControl);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LoanDetailFilterView: UIView {
    var leftLabels : DoubelLabel!
    var centerLabels : DoubelLabel!
    var rightLabels : DoubelLabel!
    var loanAmount : FilterFiled!
    var loanTime : FilterFiled!
    var descLabel : UILabel!
    var lineView : UIView!
    var amountPickerView : PickerView!
    var timePickerView : PickerView!
    var amountArr = Array<Tags>();
    var timeArr = Array<Tags>();
    var pickersuperView : UIView?;
    var product : Product?;
    var hasSelectedAmount:Bool?;
    var hasSelectedTime:Bool?;
    var selectedAmount : Int?;
    var selectedTime : Int?;

    

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_BLUE;
        self.leftLabels = DoubelLabel(frame: CGRect(x: 15, y: 20 + NAVIHEIGHT, width: 90, height: 55));
        self.centerLabels = DoubelLabel(frame: CGRect(x: self.leftLabels.right() + 5, y: self.leftLabels.top(), width: SCREEN_WIDTH - 40 - 180, height: 55));
        self.centerLabels.titleLabel.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40 - 180, height: 15);
        self.centerLabels.countLabel.frame = CGRect(x: 0, y: 33, width: SCREEN_WIDTH - 40 - 180, height: 22);
        self.centerLabels.countLabel.font = UIFont.boldSystemFont(ofSize: 18*RATIO);
        self.rightLabels = DoubelLabel(frame: CGRect(x: self.centerLabels.right() + 5, y: self.leftLabels.top(), width: 90, height: 55));
        let filterWidth = (SCREEN_WIDTH - 65)/2;

        self.loanAmount = FilterFiled(frame: CGRect(x: 15, y: self.leftLabels.bottom() + 20, width: filterWidth, height: 30));
        self.loanTime = FilterFiled(frame: CGRect(x: self.loanAmount.right() + 35, y: self.loanAmount.top(), width: filterWidth, height: 30));
        
        self.descLabel = UILabel(frame: CGRect(x: 15, y: self.loanTime.bottom() + 12, width: SCREEN_WIDTH - 30, height: 15));
        self.descLabel.textColor = COLOR_FONT_TEXT;
        self.descLabel.font = UIFont.systemFont(ofSize: 12);
        self.descLabel.text = "*实际额度根据用户条件因人而异";
        self.lineView = UIView(frame: CGRect(x: 0, y: self.loanTime.bottom() + 20 - DIMEN_BORDER, width: SCREEN_WIDTH, height: DIMEN_BORDER))
        self.lineView.backgroundColor = COLOR_BORDER;
        
        self.addSubview(self.leftLabels);
        self.addSubview(self.centerLabels);
        self.addSubview(self.rightLabels);
        self.addSubview(self.loanAmount);
        self.addSubview(self.loanTime);
//        self.addSubview(self.descLabel);
        self.addSubview(self.lineView);
        
        self.loanAmount.filterControl.addTarget(self, action: #selector(showAmountPickerView), for: .touchUpInside);
         self.loanTime.filterControl.addTarget(self, action: #selector(showTimePickerView), for: .touchUpInside);
        
        
    }
    
    func  reloadViewWithParameter(product:Product) {
        if (product.monthRate != nil) {
            self.leftLabels.titleLabel.text = "参考月利率%";
            guard let monthRate = product.monthRate else {
                print("月利率为空!");
                return;
            }
            let monthRateStr = String(format: "%.2f", monthRate);
            self.leftLabels.countLabel.text = monthRateStr;
            self.centerLabels.titleLabel.text = "每月利息(元)";
            self.centerLabels.countLabel.text = "请选金额";
        }else{
            self.leftLabels.titleLabel.text = "参考日利率%";
            guard let dayRate = product.dayRate else {
                print("日利率为空!");
                return;
            }
            let dayRateStr = String(format: "%.2f", dayRate);
            self.leftLabels.countLabel.text = dayRateStr;
            self.centerLabels.titleLabel.text = "一次性还款(元)";
            self.centerLabels.countLabel.text = "请选金额/期限";
        }
        self.rightLabels.titleLabel.text = "平均额度";
        self.rightLabels.countLabel.text = product.averageAmount ?? "";
        self.amountArr = product.loanAmountTagsList ?? [];
        self.timeArr = product.repayDaysTagsList ?? [];
        self.loanAmount.label.text = product.loanAmount ?? "";
        self.loanTime.label.text = product.repayDays ?? "";
        self.product = product;
    }
    func showAmountPickerView(sender:UIControl){
        self.amountPickerView = PickerView();
        self.amountPickerView.changeTitleAndClosure = {
            (title:String , num : Int)  in
            print("-------\(title)=======\(num)")
            self.loanAmount.label.text = title;
            let tagModel = self.product?.loanAmountTagsList?[num];
            self.hasSelectedAmount = true;
            self.selectedAmount = tagModel?.value;
            if self.product?.monthRate != nil && self.hasSelectedAmount == true {
                let repayAmount = Double((self.selectedAmount)!) * (self.product?.monthRate)! / 100;
                let repayStr = String(format: "%.2f", repayAmount);
                self.centerLabels.countLabel.text = repayStr;
                self.centerLabels.countLabel.font = UIFont.boldSystemFont(ofSize: 20 * RATIO);
                return;
            }
            if self.product?.monthRate == nil && self.hasSelectedAmount == true && self.product?.dayRate != nil && self.hasSelectedTime == nil {
                self.centerLabels.countLabel.font = UIFont.boldSystemFont(ofSize: 18 * RATIO);
                self.centerLabels.countLabel.text = "请选期限";
                return;
            }
            
            if self.product?.monthRate == nil && self.hasSelectedAmount == true && self.product?.dayRate != nil && self.hasSelectedTime == true {
                let repayAmount = Double((self.selectedTime)!) * Double((self.selectedAmount)!) * (self.product?.dayRate!)!/100;
                let repayStr = String(format: "%.2f", repayAmount);
                self.centerLabels.countLabel.text = repayStr;
                self.centerLabels.countLabel.font = UIFont.boldSystemFont(ofSize: 20 * RATIO);
                return;
            }
            
        }
        var strArr = Array<String>();
        for item in self.amountArr {
            strArr.append(item.name!);
        }
        self.amountPickerView.titleLabel.text = self.product?.loanAmount ?? "";
        
        self.amountPickerView.nameArr = NSMutableArray.init(array: strArr);
        if self.pickersuperView != nil {
            self.pickersuperView?.addSubview(self.amountPickerView);
            
        }
 
    }
    
    func showTimePickerView(sender : UIControl){
        self.timePickerView = PickerView();
        self.timePickerView.changeTitleAndClosure = {
            (title:String , num : Int)  in
            print("-------\(title)=======\(num)")
            self.loanTime.label.text = title;
            let tagModel = self.product?.repayDaysTagsList?[num];
            self.hasSelectedTime = true;
            self.selectedTime = tagModel?.value;
            if self.product?.monthRate == nil && self.product?.dayRate != nil && self.hasSelectedAmount == true {
                let repayAmount = Double((self.selectedTime)!) * Double((self.selectedAmount)!) * (self.product?.dayRate)!/100;
                let repayStr = String(format: "%.2f", repayAmount);
                self.centerLabels.countLabel.text = repayStr;
                self.centerLabels.countLabel.font = UIFont.boldSystemFont(ofSize: 20 * RATIO);
                return;
            }
            
            if self.product?.monthRate == nil && self.product?.dayRate != nil && self.hasSelectedAmount == nil {
                self.centerLabels.countLabel.text = "请选金额";
                self.centerLabels.countLabel.font = UIFont.boldSystemFont(ofSize: 18 * RATIO);
                return;
            };
            
            
        }
        var strArr = Array<String>();
        for item in self.timeArr {
            strArr.append(item.name!);
        }
        self.timePickerView.nameArr = NSMutableArray.init(array: strArr);
        self.timePickerView.titleLabel.text = self.product?.repayDays ?? "";
        if self.pickersuperView != nil {
            self.pickersuperView?.addSubview(self.timePickerView);

        }
       

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
