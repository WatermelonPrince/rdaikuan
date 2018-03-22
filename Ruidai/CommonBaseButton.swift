//
//  CommonBaseButton.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class CommonBaseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        self.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_BLUE!), for: .normal);
        
        self.layer.cornerRadius = 3;
        self.setTitleColor(COLOR_WHITE, for: .normal);
        
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class MarketBaseButton: CommonBaseButton {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setTitleColor(COLOR_WHITE, for: .selected);
        self.setTitleColor(COLOR_FONT_TEXT, for: .normal);
        self.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_BORDER), for: .normal);
        self.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_BLUE!), for: .selected);
        self.setTitle("重置", for: .normal);
        self.setTitle("确定", for: .selected);
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15);



    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
