//
//  MobileTextFieldView.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MobileTextFieldView: CommonBaseTextFieldView {
 
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.textField.placeholder = "请输入您的手机号";
        self.textField.keyboardType = .numberPad;
        self.textField.clearButtonMode = .whileEditing;
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
