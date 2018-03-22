//
//  FuliTableViewCell.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/24.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class PaticipateButton: UIButton {
    var fuliModel:Advertisement!
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FuliTableViewCell: CommonBaseTableViewCell {
    var iconImage: UIImageView!
    var titleLabel: UILabel!
    var secondLabel: UILabel!
    var countLabel: UILabel!
    var patiButton: PaticipateButton!
    var lineView: UIView!
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.iconImage = UIImageView();
        self.iconImage.frame = CGRect(x: 15, y: 15, width: 40, height: 40);
        self.iconImage.contentMode = .scaleAspectFit;
        self.iconImage.layer.cornerRadius = 20;
        self.iconImage.layer.masksToBounds = true;
        self.patiButton = PaticipateButton();
        self.patiButton.frame = CGRect(x: SCREEN_WIDTH - 100, y: 0, width: 85, height: 30);
        self.patiButton.center.y = 50;
        self.patiButton.layer.cornerRadius = 15;
        self.patiButton.layer.borderWidth = 0.5;
        self.patiButton.layer.borderColor = COLOR_BLUE!.cgColor;
        self.patiButton.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        self.titleLabel = UILabel(frame: CGRect(x: self.iconImage.right() + 12, y: 15, width: SCREEN_WIDTH - 60 - self.iconImage.width() - self.patiButton.width(), height: 20));
        self.titleLabel.textColor = COLOR_FONT_TEXT;
        self.titleLabel.font = UIFont.systemFont(ofSize: 14);
        self.secondLabel = UILabel(frame: CGRect(x: self.titleLabel.left(), y: self.titleLabel.bottom()+8, width: self.titleLabel.width(), height: 15));
        self.secondLabel.textColor = COLOR_FONT_SECONDARY;
        self.secondLabel.font = UIFont.systemFont(ofSize: 13);
        self.countLabel = UILabel(frame: CGRect(x: self.titleLabel.left(), y: self.secondLabel.bottom() + 8, width: self.titleLabel.width(), height: 15));
        self.countLabel.textColor = COLOR_FONT_SECONDARY;
        self.countLabel.font = UIFont.systemFont(ofSize: 13);
        
        self.contentView .addSubview(self.iconImage);
        self.contentView.addSubview(self.secondLabel);
        self.contentView.addSubview(self.patiButton);
        self.contentView.addSubview(self.titleLabel);
        self.contentView.addSubview(self.countLabel);
        
    }
    
    func setData(model:Advertisement){
        self.iconImage.sd_setImage(with: CommonUtil.getURL(model.imageUrl), placeholderImage: nil);
        self.titleLabel.text = model.title;
        self.secondLabel.text = model.subTitle;
        let appAttStr = NSMutableAttributedString(string: model.categoryDesc ?? "");
        let patiCountAttStr = NSMutableAttributedString(string: ((model.count ?? "")+"人 "), attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 13),NSForegroundColorAttributeName:COLOR_ORANGE!]);
        patiCountAttStr.append(appAttStr);
        self.countLabel.attributedText = patiCountAttStr;
        self.patiButton.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        self.patiButton.setTitle(model.buttonName, for: .normal);
        self.patiButton.setTitleColor(COLOR_BLUE, for: .normal);
        self.patiButton.fuliModel = model;

        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
