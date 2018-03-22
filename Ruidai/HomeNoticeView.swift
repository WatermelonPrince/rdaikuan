//
//  HomeNoticeView.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/9/21.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class HomeNoticeView: UIView {
    var applyCountLabel : UILabel?
    var noticeView : SGAdvertScrollView?

    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.noticeView = SGAdvertScrollView(frame: CGRect(x: 5, y: 5, width: SCREEN_WIDTH - 20, height: 50));
        self.noticeView?.isHaveMutableAttributedString = true;
        self.applyCountLabel = UILabel(frame: CGRect(x: SCREEN_WIDTH/4, y: 5, width: SCREEN_WIDTH/4 * 3 - 15, height: 20));
        self.applyCountLabel?.textAlignment = .right;
        self.addSubview(self.noticeView!);
        self.addSubview(self.applyCountLabel!);
        self.backgroundColor = COLOR_WHITE;
        
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
