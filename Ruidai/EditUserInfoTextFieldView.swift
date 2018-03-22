//
//  EditNickNameTextFieldView.swift
//  Loan
//
//  Created by zhaohuan on 2017/9/11.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class EditUserInfoTextFieldView: UIView,UITextFieldDelegate {
    
    var textField: CommonBaseTextField!;
    var lineView : UIView!



    override init(frame: CGRect) {
        super.init(frame: frame);
        
        //TextField
        self.textField = CommonBaseTextField(frame: CGRect(x: 15, y: 10, width: self.frame.width-30, height: 30));
        self.textField.font = UIFont.boldSystemFont(ofSize: 15);
        self.textField.returnKeyType = .done;
        self.textField.clearButtonMode = .whileEditing;
        self.addSubview(self.textField);
        self.textField.delegate = self;
        self.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        //lineVIew
        self.lineView = UIView(frame: CGRect(x: 10, y: 50 - DIMEN_BORDER, width: SCREEN_WIDTH - 20, height: DIMEN_BORDER));
        self.lineView.backgroundColor = COLOR_BORDER;
        self.addSubview(self.textField);
        self.addSubview(self.lineView);

        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        (textField as! CommonBaseTextField).resetTipColor();
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        (textField as! CommonBaseTextField).resetTipColor();
    }

}
