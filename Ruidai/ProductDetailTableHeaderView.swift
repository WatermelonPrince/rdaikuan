//
//  ProductDetailHeaderView.swift
//  Loan
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ProductDetailTableHeaderView: UIView {
    var productLogoImageView: UIImageView!;
    var productNameLabel: UILabel!;
    var tagsLabelArray: Array<UILabel>!;
    var rateNameLabel: UILabel!;
    var rateValueLabel: UILabel!;
    var interestNameLabel: UILabel!;
    var interestValueLabel: UILabel!;
    var averageAmountLabel: UILabel!;
    var loanAmountButton: UIButton!;
    var repayDaysButton: UIButton!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_WHITE;
        
        self.productLogoImageView = UIImageView(frame: CGRect(x: 13.8, y: 20.1, width: 66.3, height: 66.3));
        self.addSubview(self.productLogoImageView);
        
//        //BalanceLabel
//        self.balanceLabel = UILabel(frame: CGRect(x: 0, y: 20, width: self.frame.width, height: 20));
//        self.balanceLabel.textColor = COLOR_FONT_TEXT;
//        self.balanceLabel.font = UIFont.systemFont(ofSize: 15);
//        self.balanceLabel.textAlignment = .center;
//        self.addSubview(self.balanceLabel);
//        self.balanceLabel.text = "账户余额（元）";
//        
//        //BalanceNumberLabel
//        self.balanceNumberLabel = UILabel(frame: CGRect(x: 0, y: self.balanceLabel.frame.maxY, width: self.frame.width, height: 60));
//        self.balanceNumberLabel.textColor = COLOR_BLUE;
//        self.balanceNumberLabel.font = UIFont.systemFont(ofSize: 40);
//        self.balanceNumberLabel.textAlignment = .center;
//        self.addSubview(self.balanceNumberLabel);
//        
//        //AvailableLabel
//        self.availableLabel = UILabel(frame: CGRect(x: 0, y: self.balanceNumberLabel.frame.maxY, width: 0, height: self.balanceLabel.frame.height));
//        self.availableLabel.textColor = self.balanceLabel.textColor;
//        self.availableLabel.font = self.balanceLabel.font;
//        self.availableLabel.textAlignment = .center;
//        self.addSubview(self.availableLabel);
//        
//        //QuestionMarkButton
//        self.questionMarkButton = QuestionMarkButton(frame: CGRect(x: self.frame.maxX*2, y: self.availableLabel.frame.minY+1, width: self.availableLabel.frame.height-4, height: self.availableLabel.frame.height-4));
//        self.addSubview(self.questionMarkButton);
//        self.questionMarkButton.addTarget(self, action: #selector(questionMarkAction), for: .touchUpInside);
//        
//        //ChargeButton
//        self.chargeButton = CommonBaseButton(frame: CGRect(x: 20, y: self.availableLabel.frame.maxY + 20, width: (self.frame.width-3*20)/2, height: 35));
//        self.addSubview(self.chargeButton);
//        self.chargeButton.setTitle("充  值", for: .normal);
//        
//        //WithdrawButton
//        self.withdrawButton = CommonBaseButton(frame: CGRect(x: self.chargeButton.frame.maxX+20, y: self.chargeButton.frame.minY, width: self.chargeButton.frame.width, height: self.chargeButton.frame.height));
//        self.withdrawButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_WHITE), for: .normal);
//        self.withdrawButton.setTitleColor(COLOR_BLUE, for: .normal);
//        self.withdrawButton.layer.borderWidth = 1;
//        self.withdrawButton.layer.borderColor = COLOR_BLUE.cgColor;
//        self.addSubview(self.withdrawButton);
//        self.withdrawButton.setTitle("提  现", for: .normal);
//        
//        self.setData(accountBalance: 0.00, freezeAmount: 0.00);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(accountBalance: Double, freezeAmount: Double) {
     
    }
    
    func questionMarkAction() {
        let alertController = UIAlertController(title: "提现中金额", message: "您发起提现后，提现会先进入等待审核状态，系统会将提现金额冻结。", preferredStyle: .alert);
        let cancelAction = UIAlertAction(title: "我知道了", style: .cancel, handler: nil);
        alertController.addAction(cancelAction);
        alertController.show();
    }
    
}
