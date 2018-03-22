//
//  PasswordTextFieldView.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class PasswordTextFieldView: CommonBaseTextFieldView {
    var codeInputStyleBtn : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.iconImage.image = UIImage.init(named: "icon_mine");
        
        self.textField.placeholder = "请输入密码";
        self.textField.isSecureTextEntry = true;
        self.textField.keyboardType = .asciiCapable;
        self.textField.frame = CGRect(x: self.textField.left(), y: self.textField.top(), width: self.textField.width() - 25, height: self.textField.height());
        self.codeInputStyleBtn = UIButton(frame: CGRect(x: SCREEN_WIDTH - 50, y: 5, width: 40, height: 40));
        self.codeInputStyleBtn.setImage(#imageLiteral(resourceName: "icon_loginpasshidden"), for: .normal);
        self.codeInputStyleBtn.setImage(#imageLiteral(resourceName: "icon_loginpassshow"), for: .selected);
        self.addSubview(self.codeInputStyleBtn);
    }
    
    override func layoutSubviews() {
        self.textField.frame = CGRect(x: self.iconImage.frame.maxX+10, y: 17, width: self.frame.width-self.iconImage.right() - 25 - 25, height: 15);
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
