//
//  LoanDetailSwithBtn.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/12.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanDetailSwithBtn: UIButton {
    var lineView: UIView?
    var showLineView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    convenience init(title:String,normalColor:UIColor,selectedColor:UIColor,titleFont:UIFont,lineColor:UIColor,frame:CGRect) {
        self.init(frame: frame);
        self.titleLabel?.font = titleFont;
        self.setTitle(title, for: .normal);
        self.setTitleColor(normalColor, for: .normal);
        self.setTitleColor(selectedColor, for: .selected);
        self.lineView = UIView(frame: CGRect(x: 40, y: frame.size.height - 1, width: frame.size.width - 80, height: 1));
        self.showLineView = UIView(frame: CGRect(x: 0, y: frame.size.height - DIMEN_BORDER, width: SCREEN_WIDTH, height: DIMEN_BORDER));
        self.showLineView?.backgroundColor = COLOR_BORDER;
        self.lineView?.backgroundColor = lineColor;
        self.lineView?.isHidden = true;
        self.backgroundColor = COLOR_WHITE;
        
        self.addSubview(self.lineView!);
//        self.addSubview(self.showLineView!);
        
    }
    
    func setSelectedTrueOrFalse(isSlected: Bool){
        
            self.lineView?.isHidden = !isSlected;
            self.isSelected = isSlected;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   

}
