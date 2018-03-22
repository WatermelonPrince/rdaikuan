//
//  LoanDetailsTableViewCell.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/28.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanDetailsTableViewCell: CommonBaseTableViewCell {
    var detailLabel : UILabel!
    var lineView : UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.detailLabel = UILabel();
        self.detailLabel.font = UIFont.systemFont(ofSize: 14);
        self.detailLabel.textColor = COLOR_FONT_TEXT;
        self.contentView.addSubview(self.detailLabel);
    }
    
    func reloadCell(textStr:String) {
        let attStr = NSMutableAttributedString(string: textStr);
        let paragraphStyle = NSMutableParagraphStyle();
        paragraphStyle.lineSpacing = 8;
        attStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, (textStr as NSString).length));
        
        self.detailLabel.attributedText = attStr;
        
        let  height = CommonUtil.autoLabelHeight(text: textStr, labelWidth: SCREEN_WIDTH - 30, attributes: [NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:UIFont.systemFont(ofSize: 14)]);
        self.detailLabel.frame =  CGRect(x: 15, y: 15, width: SCREEN_WIDTH - 30, height: height);
        self.detailLabel.lineBreakMode = .byWordWrapping;
        self.detailLabel.numberOfLines = 0;
        
        
        self.lineView = UIView();
        self.lineView.frame = CGRect(x: 0, y: self.detailLabel.bottom() + 15 - DIMEN_BORDER, width: SCREEN_WIDTH, height: DIMEN_BORDER);
        self.lineView.backgroundColor = COLOR_BORDER;
        
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.lineView.bottom());
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 

}
