//
//  WelfareHeaderView.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/10.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class WelfareHeaderView: UIView {

    var iconImageView: UIImageView?
    var titleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.iconImageView = UIImageView(frame: CGRect(x: 15, y: 13, width: 22, height: 22));
        self.titleLabel = UILabel(frame: CGRect(x: (self.iconImageView?.right())! + 5, y: 15, width: SCREEN_WIDTH - 60, height: 20));
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        self.titleLabel?.textColor = COLOR_FONT_HEAD;
        self.addSubview(self.titleLabel!);
        self.addSubview(self.iconImageView!);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
