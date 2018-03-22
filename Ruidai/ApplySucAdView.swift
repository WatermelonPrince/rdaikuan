//
//  ApplySucAdView.swift
//  Loan
//
//  Created by zhaohuan on 2017/11/9.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ApplySucAdView: HomeAdView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.adverImageView.frame = CGRect(x: (SCREEN_WIDTH - 350 * RATIO)/2, y: (SCREEN_HEIGHT - 430 * RATIO)/2, width: 350 * RATIO, height: 430 * RATIO);
        self.exitButton.frame = CGRect(x: self.adverImageView.right() - 50, y: self.adverImageView.top() -   90, width: 50, height: 50);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
