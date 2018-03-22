//
//  MyLoanTableListCell.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MyLoanTableListCell: FuliTableViewCell {
    var tagImage : UIImageView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.patiButton.isHidden = true;
        self.iconImage.frame = CGRect(x: 15, y: 10, width: 60, height: 60);
        self.titleLabel.frame = CGRect(x: self.iconImage.right() + 25 * RATIO, y: 10, width: SCREEN_WIDTH - 60 - self.iconImage.width() , height: 20);
        self.secondLabel.frame = CGRect(x: self.titleLabel.left(), y: self.titleLabel.bottom()+8, width: self.titleLabel.width(), height: 15);
        self.countLabel.frame = CGRect(x: self.titleLabel.left(), y: self.secondLabel.bottom() + 8, width: self.titleLabel.width(), height: 15);
        self.tagImage = UIImageView(frame: CGRect(x: SCREEN_WIDTH - 35, y: 0, width: 35, height: 35));
        self.tagImage.contentMode = .scaleAspectFill;
        self.addSubview(self.tagImage);
        
    }
    
    func setData(model : Apply){
        self.iconImage.sd_setImage(with: CommonUtil.getURL(model.productLogo ?? ""));
        self.titleLabel.text = model.productName ?? "";
        self.secondLabel.text = (model.loanAmountStr ?? "") + "  " + (model.repayDaysStr ?? "");
        self.countLabel.text = model.applyTimeStr ?? "";
        self.tagImage.sd_setImage(with: CommonUtil.getURL(model.statusTags?.image ?? ""));
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
