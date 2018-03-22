//
//  ProductRecommendView.swift
//  Loan
//
//  Created by zhaohuan on 2017/9/18.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ProductRecommendView: UIView {

    var backGroundView : UIView!
    var continueBtn : UIButton!
    var applySuccessBtn : UIButton!
    var backGroudImageView : UIImageView!
    var titleLabel : UILabel!
    var headTitleLabel : UILabel!
    var lineView : UIView!
    var applySuccessHanlder : (()->())?;
    var returnHomeBtn : UIButton?
    var luckListbackView : UIView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_BLACK.withAlphaComponent(0.5);
        
        self.backGroundView = UIView(frame: CGRect(x: (frame.size.width - 280)/2, y: 110 * RATIO, width: 280, height: 330));
        self.backGroundView.layer.cornerRadius = 7;
        self.backGroundView.layer.masksToBounds = true;
        self.backGroundView.backgroundColor = COLOR_WHITE;
        self.backGroudImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.backGroundView.width(), height: 140));
        self.backGroudImageView.layer.cornerRadius = 3;
        self.backGroudImageView.contentMode = .scaleAspectFill;
        self.backGroudImageView.image = #imageLiteral(resourceName: "icon_imagebackgroud");
        let bottomlineView = UIView(frame: CGRect(x: 0, y: self.backGroudImageView.bottom(), width: self.backGroundView.width(), height: DIMEN_BORDER));
        bottomlineView.backgroundColor = COLOR_BORDER;
        self.titleLabel = UILabel(frame: CGRect(x: (self.backGroundView.width() - 180)/2, y: self.backGroudImageView.bottom() + 20, width: 180, height: 44));
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textAlignment = .center;
        self.titleLabel.font = UIFont.systemFont(ofSize: 16);
        self.titleLabel.text = "距离拿到钱还差一小步，\n再坚持一下呗~";
        self.continueBtn = UIButton(frame: CGRect(x: (self.backGroundView.width() - 200)/5*2, y: self.titleLabel.bottom() + 10, width: 100, height: 35));
        self.continueBtn.setTitle("继续拿钱", for: .normal);
        self.continueBtn.layer.cornerRadius = 5;
        self.continueBtn.backgroundColor = COLOR_BLUE_BUTTON;
        self.continueBtn.titleLabel?.textColor = COLOR_WHITE;
        self.continueBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        self.continueBtn.addTarget(self, action: #selector(continueAciton), for: .touchUpInside);
        self.applySuccessBtn = UIButton(frame: CGRect(x: (self.backGroundView.width() - 200)/5 + self.continueBtn.right(), y: self.continueBtn.top(), width: 100, height: 35));
        self.applySuccessBtn.setTitle("申请成功", for: .normal);
        self.applySuccessBtn.layer.cornerRadius = 5;
        self.applySuccessBtn.layer.borderWidth = DIMEN_BORDER;
        self.applySuccessBtn.layer.borderColor = COLOR_BLUE?.cgColor;
        self.applySuccessBtn.setTitleColor(COLOR_BLUE, for: .normal);
        self.applySuccessBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        self.applySuccessBtn.addTarget(self, action: #selector(applySuccessAction), for: .touchUpInside);

        self.lineView = UIView(frame: CGRect(x: self.continueBtn.left(), y: self.applySuccessBtn.bottom() + 20, width: self.backGroundView.width() - 2 * self.continueBtn.left(), height: DIMEN_BORDER));
        self.lineView.backgroundColor = COLOR_FONT_SECONDARY;
        self.headTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 20));
        self.headTitleLabel.text = "看看有谁拿了钱";
        self.headTitleLabel.backgroundColor = COLOR_WHITE;
        self.headTitleLabel.textAlignment = .center;
        self.headTitleLabel.font = UIFont.systemFont(ofSize: 11);
        self.headTitleLabel.textColor = COLOR_FONT_SECONDARY;
        
        
        self.headTitleLabel.center.y = self.lineView.center.y;
        self.headTitleLabel.center.x = self.lineView.center.x;
        self.returnHomeBtn = LoginBaseButton(frame: CGRect(x: self.backGroundView.left(), y: self.backGroundView.bottom(), width: self.backGroundView.width(), height: 44));
        self.returnHomeBtn?.addTarget(self, action: #selector(applySuccessAction), for: .touchUpInside);
        self.returnHomeBtn?.setImage(#imageLiteral(resourceName: "icon_returnhome"), for: .normal);
        self.returnHomeBtn?.setTitle("离开并返回首页", for: .normal);
        self.returnHomeBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17);
        self.luckListbackView = UIView(frame: CGRect(x: self.continueBtn.left() - 10, y: self.headTitleLabel.bottom(), width: self.backGroundView.width() - 2 * self.continueBtn.left() + 20, height: 40));
//        self.luckListbackView?.backgroundColor = COLOR_RED;
        self.backGroundView.addSubview(self.backGroudImageView);
        self.backGroundView.addSubview(bottomlineView);
        self.backGroundView.addSubview(self.titleLabel);
        self.backGroundView.addSubview(self.continueBtn);
        self.backGroundView.addSubview(self.applySuccessBtn);
        self.backGroundView.addSubview(self.lineView);
        self.backGroundView.addSubview(self.headTitleLabel);
        self.backGroundView.addSubview(self.luckListbackView!);
        self.addSubview(self.backGroundView);
        self.addSubview(self.returnHomeBtn!);
    }
    
    func continueAciton(){
        self.removeFromSuperview();
    }
    func applySuccessAction(){
        guard self.applySuccessHanlder != nil else {
            return;
        }
        self.removeFromSuperview();
        self.applySuccessHanlder!();
        
    }
    
    func reloadViewWithModel(modelArr : Array<String>){
        for subView in (self.luckListbackView?.subviews)! {
            subView.removeFromSuperview();
        }
        for i in 0..<4 {
            let k = i < 2 ? 0 : 1;
            let label = UILabel(frame: CGRect(x: (self.luckListbackView?.width())!/2*CGFloat(i%2), y: 20 * CGFloat(k), width: (self.luckListbackView?.width())!/2, height: 20));
            label.font = UIFont.systemFont(ofSize: 10);
            label.textColor = COLOR_FONT_SECONDARY;
            label.textAlignment = .center;
            label.text = modelArr[i];
            self.luckListbackView?.addSubview(label);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



