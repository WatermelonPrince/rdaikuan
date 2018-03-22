//
//  LoanMineUserInfoCell.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/28.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanMineUserInfoCell: CommonBaseTableViewCell {
    
    var userImage : UIImageView!
    var phoneLabel : UILabel!
    var lineView : UIView!
    var userImageClickAction : (() -> ())?;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.userImage = UIImageView(frame: CGRect(x: 15, y: 20, width: 42, height: 42));
        self.userImage.layer.cornerRadius = 21;
        self.userImage.layer.masksToBounds = true;
        self.userImage.contentMode = .scaleAspectFill;
        self.userImage.isUserInteractionEnabled = true;
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(clickImageAction));
        self.userImage.addGestureRecognizer(tapGesture);
        self.phoneLabel = UILabel(frame: CGRect(x: self.userImage.right() + 15, y: 0, width: SCREEN_WIDTH - self.userImage.right() - 30, height: 20));
        self.phoneLabel.font = UIFont.systemFont(ofSize: 15);
        self.phoneLabel.textColor = COLOR_FONT_HEAD;
        self.phoneLabel.center.y = self.userImage.center.y;
        self.lineView = UIView(frame: CGRect(x: 0, y: self.userImage.bottom() + 20 - DIMEN_BORDER, width: SCREEN_WIDTH, height: DIMEN_BORDER));
        self.lineView.backgroundColor = COLOR_BORDER;
        self.contentView.addSubview(self.userImage);
        self.contentView.addSubview(self.phoneLabel);
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clickImageAction(){
        guard let imageClickAction = self.userImageClickAction else {
            return ();
        }
        imageClickAction();
    }

   

}
