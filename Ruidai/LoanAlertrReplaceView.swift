//
//  LoanAlertrReplaceView.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/31.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanAlertrReplaceView: UIView {
    var backGroudView: UIView!
    var alertBgView: UIView!
    var titleLabel:UILabel!
    var makeSureBtn: UIButton!
    var lineView: UIView!
    var cancleBtn: UIButton!
    var verlineView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backGroudView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT));
        self.backGroudView?.backgroundColor = COLOR_BLACK.withAlphaComponent(0.6);
        self.alertBgView = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 90));
        self.alertBgView.backgroundColor = COLOR_WHITE;
        self.alertBgView.center.x = self.backGroudView.width()/2;
        self.alertBgView.center.y = self.backGroudView.height()/2;
        self.alertBgView.layer.cornerRadius = 10;
        self.alertBgView.layer.masksToBounds = true;
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.alertBgView.width(), height: 50));
        self.titleLabel.font = UIFont.systemFont(ofSize: 17);
        self.titleLabel.textAlignment = .center;
        self.lineView = UIView(frame: CGRect(x: 0, y: self.titleLabel.bottom(), width: self.alertBgView.width(), height: DIMEN_BORDER));
        self.lineView.backgroundColor = COLOR_BORDER;
        self.cancleBtn = UIButton(frame: CGRect(x: 0, y: self.lineView.bottom(), width: self.alertBgView.width()/2, height: self.alertBgView.height() - self.lineView.bottom()));
        self.cancleBtn.setTitle("取消", for: .normal);
        self.cancleBtn.setTitleColor(UIColor.blue, for: .normal);
        self.verlineView = UIView(frame: CGRect(x: self.cancleBtn.right(), y: self.lineView.bottom(), width: DIMEN_BORDER, height: self.cancleBtn.height()));
        self.verlineView.backgroundColor = COLOR_BORDER;
        self.makeSureBtn = UIButton(frame: CGRect(x: self.verlineView.right(), y: self.lineView.bottom(), width: self.alertBgView.width() - self.verlineView.right(), height: self.cancleBtn.height()));
        self.makeSureBtn.setTitle("确定", for: .normal);
        self.makeSureBtn.setTitleColor(UIColor.blue, for: .normal);
        self.alertBgView.addSubview(self.titleLabel);
        self.alertBgView.addSubview(self.lineView);
        self.alertBgView.addSubview(self.cancleBtn);
        self.alertBgView.addSubview(self.verlineView);
        self.alertBgView.addSubview(self.makeSureBtn);
        self.addSubview(self.backGroudView);
        self.addSubview(self.alertBgView);
        
        self.titleLabel.text = "请在设置中打开网络访问权限";
        
        self.cancleBtn.addTarget(self, action: #selector(cancleAction), for: .touchUpInside);
        self.makeSureBtn.addTarget(self, action: #selector(makeSureClickAction), for: .touchUpInside);
        
        
    }
    func cancleAction(){
        self.isHidden = true;
    }
    
    func makeSureClickAction(){
        self.isHidden = true;
        UIApplication.shared.openURL(URL(string: "App-Prefs:root=NOTIFICATIONS_ID")!);

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
