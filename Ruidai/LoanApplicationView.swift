//
//  LoanApplicationView.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/28.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanApplicationView: UIView {
    var lineView : UIView!
    var commentsBtn: UIButton!
    var applicationBtn : UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.lineView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: DIMEN_BORDER));
        self.lineView.backgroundColor = COLOR_BORDER;
        self.commentsBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 110 * RATIO, height: 50));
        self.commentsBtn.backgroundColor = COLOR_LIGHT_GREEN;
        self.commentsBtn.setImage(#imageLiteral(resourceName: "icon_comments"), for: .normal);
        self.commentsBtn.setTitle(" 点评", for: .normal);
        self.commentsBtn.setTitleColor(COLOR_BLUE, for: .normal);
        self.commentsBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * RATIO);
        self.applicationBtn = UIButton(frame: CGRect(x: self.commentsBtn.right(), y: 0, width: SCREEN_WIDTH - self.commentsBtn.width(), height: 50));
        self.applicationBtn.backgroundColor = COLOR_BLUE_BUTTON;
        self.applicationBtn.setTitle("立即申请", for: .normal);
        self.applicationBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * RATIO);
//        self.applicationBtn.layer.cornerRadius = 5;
//        self.applicationBtn.layer.masksToBounds = true;
        self.backgroundColor = COLOR_WHITE;
//        self.addSubview(self.lineView);
        self.addSubview(self.commentsBtn);
        self.addSubview(self.applicationBtn);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}
