//
//  LoanSimpleInfoView.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/16.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanSimpleInfoView: UIView {
    var iconImage: UIImageView!
    var titleLable: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_WHITE;
        self.iconImage = UIImageView(frame: CGRect(x: 15, y: 15, width: 40, height: 40));
        self.iconImage.layer.cornerRadius = 20;
        self.iconImage.layer.masksToBounds = true;
        self.titleLable = UILabel(frame: CGRect(x: self.iconImage.right() + 10, y: 0, width: SCREEN_WIDTH - 40 - self.iconImage.width() , height: 20));
        self.titleLable.center.y = self.iconImage.center.y;
        self.addSubview(self.iconImage);
        self.addSubview(self.titleLable);
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
