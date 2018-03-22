//
//  VerifyTextFieldView.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryButtonTextFieldView: CommonBaseTextFieldView {
    var button: UIButton!;
    var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.textField.frame.size.width -= 120;
        
        //Button
        self.button = UIButton(frame: CGRect(x: self.frame.width - 100 - 20, y: 10, width: 100, height: self.frame.height-10*2));
        self.button.clipsToBounds = true;
        self.button.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_WHITE), for: .normal);
        self.button.layer.cornerRadius = 3;
        self.button.layer.borderWidth = 0.5;
        self.button.layer.borderColor = COLOR_BLUE?.cgColor;
        self.button.setTitleColor(COLOR_BLUE, for: .normal);
        self.button.setTitleColor(COLOR_BORDER, for: .disabled);
        self.button.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        self.addSubview(self.button);
    }
    
    override func layoutSubviews() {
        self.textField.frame = CGRect(x: self.iconImage.frame.maxX+10, y: 15, width: self.frame.width-self.iconImage.right() - 40, height: 20);
        self.textField.frame.size.width -= 120;

    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VerifyTextFieldView: LotteryButtonTextFieldView {
    
    var verifyTimer: Timer?;
    var verifyTimeInt: Int = 59;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.textField.placeholder = "填写验证码";
        self.textField.keyboardType = .numberPad;
        
        //Button
        self.button.setTitle("获取验证码", for: .normal);
        self.button.setTitle("\(self.verifyTimeInt)s后获取", for: .disabled);
        
        if (self.verifyTimer != nil) {
            self.createVerifyTimer();
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createVerifyTimer() {
        self.verifyTimer?.invalidate();
        self.verifyTimer = nil;
        
        self.verifyTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(verifyTimerAction), userInfo: nil, repeats: true);
        self.button.isEnabled = false;
        self.button.setTitle("\(self.verifyTimeInt)s后获取", for: .disabled);
        self.button.layer.borderColor = COLOR_BORDER.cgColor;
    }
    
    func verifyTimerAction() {
        if (self.verifyTimeInt > 1) {
            self.verifyTimeInt -= 1;
            self.button.isEnabled = false;
            self.button.layer.borderColor = COLOR_BORDER.cgColor;
            self.button.setTitle("\(self.verifyTimeInt)s后获取", for: .disabled);
        } else {
            self.button.isEnabled = true;
            self.button.layer.borderColor = COLOR_BLUE?.cgColor;
            self.verifyTimeInt = 59;
            self.verifyTimer?.invalidate();
            self.verifyTimer = nil;
        }
    }

}
