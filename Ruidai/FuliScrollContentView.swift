//
//  FuliScrollContentView.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/11.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class FuliScrollContentView: UIView {
    var bgImageView: UIImageView?
    var titleLabel: UILabel?
    var descripLabel: UILabel?
    var touchView: UIView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 97));
        self.bgImageView?.contentMode = .scaleAspectFit;
        self.bgImageView?.layer.cornerRadius = 6;
        self.bgImageView?.layer.masksToBounds = true;
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: 97 + 3, width: frame.size.width, height: 20));
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        self.titleLabel?.textColor = COLOR_FONT_HEAD;
        self.descripLabel = UILabel(frame: CGRect(x: 0, y: (self.titleLabel?.bottom())! + 2, width: frame.size.width, height: 18));
        self.descripLabel?.font = UIFont.systemFont(ofSize: 15);
        self.descripLabel?.textColor = COLOR_FONT_TEXT;
        self.touchView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 140));
        self.addSubview(self.bgImageView!);
        self.addSubview(self.titleLabel!);
        self.addSubview(self.descripLabel!);
        self.addSubview(self.touchView!);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
