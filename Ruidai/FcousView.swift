//
//  FcousView.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/24.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit


class MatchViewHeader : ViewforHeaderInLoan{
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.verLineView.frame = CGRect(x: 0, y: 15, width: 4, height: 15);
        self.titleLabel.frame = CGRect(x: self.verLineView.right() + 10, y: 12, width: SCREEN_WIDTH - self.verLineView.right() - 20 - self.tagImageView.width() , height: 20);
        self.bottomHorLineView.isHidden = true;
        self.horLineView.isHidden = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ViewforHeaderInLoan: UIView {
    var horLineView : UIView!;
    var titleLabel : UILabel!;
    var verLineView : UIView!;
    var bottomHorLineView : UIView!;
    var tagImageView : UIImageView!;
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.horLineView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: DIMEN_BORDER));
        self.horLineView.backgroundColor = COLOR_BORDER;
        self.tagImageView = UIImageView(frame: CGRect(x: SCREEN_WIDTH - 35, y: 0, width: 35, height: 35));
        self.verLineView = UIView(frame: CGRect(x: 0, y: 15, width: 5, height: 15));
        self.titleLabel = UILabel(frame: CGRect(x: self.verLineView.right() + 10, y: 12, width: SCREEN_WIDTH - self.verLineView.right() - 20 - self.tagImageView.width() , height: 20));
        self.titleLabel.font = UIFont.systemFont(ofSize: 16);
        self.titleLabel.textColor = COLOR_FONT_HEAD;
        self.titleLabel.textAlignment = .left;
        self.bottomHorLineView = UIView(frame: CGRect(x: 0, y: 45 - DIMEN_BORDER, width: SCREEN_WIDTH, height: DIMEN_BORDER));
        self.bottomHorLineView.backgroundColor = COLOR_BORDER;
//        self.addSubview(self.horLineView);
        self.addSubview(self.tagImageView);
        self.addSubview(self.verLineView);
        self.addSubview(self.titleLabel);
//        self.addSubview(self.bottomHorLineView);
        
        self.backgroundColor = COLOR_WHITE;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FcousView: UIView {
    var fcousButton: UIButton!
    var fcousLabel : UILabel!
    
    

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.fcousButton = UIButton(frame: CGRect(x: 35/2, y: 0, width: 35, height: 35));
        self.fcousLabel = UILabel(frame: CGRect(x: 0, y: self.fcousButton.bottom() + 5, width: frame.width, height:20));
        self.fcousLabel.textColor = COLOR_FONT_SECONDARY;
        self.fcousLabel.font = UIFont.systemFont(ofSize: 13);
        self.fcousLabel.textAlignment = .center;
        self.addSubview(self.fcousButton);
        self.addSubview(self.fcousLabel);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
