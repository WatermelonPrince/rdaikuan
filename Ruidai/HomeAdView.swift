//
//  HomeAdViewController.swift
//  Loan
//
//  Created by zhaohuan on 2017/9/14.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
//首页广告
class HomeAdView: UIView{
    var adverImageView : UIImageView!
    var exitButton : UIButton!
    var tapGesture : UITapGestureRecognizer?
    

    
//    override func viewDidLoad() {
//        super.viewDidLoad();
//        self.view.backgroundColor = COLOR_BLACK.withAlphaComponent(0.5);
//        self.adverImageView = UIImageView(frame: CGRect(x: (SCREEN_WIDTH - 270 * RATIO)/2, y: (SCREEN_HEIGHT - 335 * RATIO)/2, width: 270 * RATIO, height: 335 * RATIO));
//        self.adverImageView.contentMode = .scaleAspectFill;
//        self.exitButton = UIButton(frame: CGRect(x: (SCREEN_WIDTH - 50)/2, y: self.adverImageView.bottom() + 30, width: 50, height: 50));
//        self.exitButton.addTarget(self, action: #selector(exictVC), for: .touchUpInside);
//        self.exitButton.setImage(#imageLiteral(resourceName: "icon_clearclose"), for: .normal);
//        self.view.addSubview(self.exitButton);
//        self.view.addSubview(self.adverImageView);
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_BLACK.withAlphaComponent(0.5);
        self.adverImageView = UIImageView(frame: CGRect(x: (SCREEN_WIDTH - 270 * RATIO)/2, y: (SCREEN_HEIGHT - 335 * RATIO)/2, width: 270 * RATIO, height: 335 * RATIO));
        self.adverImageView.contentMode = .scaleAspectFill;
        self.exitButton = UIButton(frame: CGRect(x: (SCREEN_WIDTH - 50)/2, y: self.adverImageView.bottom() + 30, width: 50, height: 50));
        self.exitButton.addTarget(self, action: #selector(exictVC), for: .touchUpInside);
        self.exitButton.setImage(#imageLiteral(resourceName: "icon_clearclose"), for: .normal);
        self.tapGesture = UITapGestureRecognizer();
        self.adverImageView.addGestureRecognizer(self.tapGesture!);
        self.adverImageView.isUserInteractionEnabled = true;
        self.addSubview(self.exitButton);
        self.addSubview(self.adverImageView);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

   
    
    func exictVC() {
        self.removeFromSuperview();
    }

   
}
