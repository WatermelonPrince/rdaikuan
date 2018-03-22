//
//  LoanCouponInfoView.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/11/16.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanCouponInfoView: UIView {
    var titleImage: UIImageView!
    var infoBgView: UIView!
    var titleLabel: UILabel!
    var secondLabel: UILabel!
    var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_BLACK.withAlphaComponent(0.5);
        self.infoBgView = UIView(frame: CGRect(x: (SCREEN_WIDTH - 260)/2, y: (SCREEN_HEIGHT - 300)/2, width: 260, height: 300));
        self.infoBgView.backgroundColor = COLOR_WHITE;
        self.infoBgView.layer.cornerRadius = 8;
        self.infoBgView.layer.masksToBounds = true;
        self.titleImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 260, height: 110));
        self.titleImage.image = #imageLiteral(resourceName: "icon_apply_coupon");
        self.titleLabel = UILabel(frame: CGRect(x: 15, y: self.titleImage.bottom() + 25, width: self.infoBgView.width() - 30, height: 40));
        self.titleLabel.font = UIFont.systemFont(ofSize: 16);
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textColor = COLOR_FONT_HEAD;
        self.titleLabel.textAlignment = .center;
        self.secondLabel = UILabel(frame: CGRect(x: 15, y: self.titleLabel.bottom() + 15, width: self.infoBgView.width() - 30, height: 15));
        self.secondLabel.textAlignment = .center;
        self.secondLabel.textColor = COLOR_BORDER;
        self.secondLabel.font = UIFont.systemFont(ofSize: 14);
        self.secondLabel.text = "请在官方渠道下载该机构APP";
        
        self.button = UIButton(frame: CGRect(x: (self.infoBgView.width() - 100)/2, y: self.secondLabel.bottom() + 15, width: 100, height: 57));
        self.button.setImage(#imageLiteral(resourceName: "icon_know_btn"), for: .normal);
        
        self.addSubview(self.infoBgView);
        self.infoBgView.addSubview(self.titleImage);
        self.infoBgView.addSubview(self.titleLabel);
        self.infoBgView.addSubview(self.secondLabel);
        self.infoBgView.addSubview(self.button);
        
        
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
