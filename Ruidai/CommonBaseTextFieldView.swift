//
//  CommonBaseTextFieldView.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class CommonBaseTextFieldView: UIView, UITextFieldDelegate{
    var label : UILabel!
    var iconImage: UIImageView!;
    var textField: CommonBaseTextField!;
    var lineView : UIView!
    static let baseHeight: CGFloat = 50;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_WHITE;
        //Label
        self.label = UILabel();
        self.label.textColor = COLOR_FONT_TEXT;
        self.label.font = UIFont.systemFont(ofSize: K_FONT_SIZE);
        self.label.textAlignment = .right;
        self.addSubview(self.label);
        
        //icon
        self.iconImage = UIImageView(frame: CGRect(x: self.label.right() + 15, y: 17, width: 15, height: 15));
//        self.iconImage.image = UIImage.init(named: "icon_mine");
        
        //TextField
        self.textField = CommonBaseTextField(frame: CGRect(x: self.iconImage.frame.maxX+10, y: self.iconImage.frame.minY, width: self.frame.width-self.iconImage.frame.width-40, height: self.iconImage.frame.height));
        self.textField.font = UIFont.boldSystemFont(ofSize: 15);
        self.textField.returnKeyType = .done;
        self.textField.clearButtonMode = .whileEditing;
        self.addSubview(self.textField);
        self.textField.delegate = self;
        self.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        //lineVIew
        self.lineView = UIView(frame: CGRect(x: 10, y: 50 - DIMEN_BORDER, width: SCREEN_WIDTH - 20, height: DIMEN_BORDER));
        self.lineView.backgroundColor = COLOR_BORDER;
        self.addSubview(self.lineView);
        self.addSubview(self.iconImage);
        
    }
    
    
    override func layoutSubviews() {
        self.textField.frame = CGRect(x: self.iconImage.frame.maxX+10, y: 15, width: self.frame.width-self.iconImage.right() - 40, height: 20);
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
