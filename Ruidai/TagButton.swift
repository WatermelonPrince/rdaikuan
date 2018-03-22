//
//  TagButton.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/9/25.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class TagButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    func setSelectedTrueOrFalse(isSelected : Bool){
        if isSelected == true {
            self.layer.cornerRadius = 3;
            self.layer.borderColor = COLOR_BLUE?.cgColor;
            self.layer.borderWidth = DIMEN_BORDER;
            self.backgroundColor = COLOR_BUTTON_GROUND;
//            self.setTitle("身份证", for: .normal);
            self.setTitleColor(COLOR_BLUE, for: .normal);
            self.titleLabel?.font = UIFont.systemFont(ofSize: 13*RATIO);
            self.isSelected = true;
        }else{
            self.layer.cornerRadius = 3;
            self.layer.borderColor = COLOR_BORDER.cgColor;
            self.layer.borderWidth = DIMEN_BORDER;
            self.backgroundColor = COLOR_WHITE;
//            self.setTitle("身份证", for: .normal);
            self.setTitleColor(COLOR_FONT_TEXT, for: .normal);
            self.titleLabel?.font = UIFont.systemFont(ofSize: 13*RATIO);
            self.isSelected = false;
        }
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
