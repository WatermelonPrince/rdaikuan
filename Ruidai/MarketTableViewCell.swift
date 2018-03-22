//
//  MarketTableViewCell.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/10.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MarketTableViewCell: HomeTableViewCell {
    var lineImageView: UIImageView?
    
    var advantageBgView: UIView?
    var loanDescribLabel: UILabel?
    var lineImage: UIImageView?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
       /* self.lineImageView = UIImageView(frame: CGRect(x: self.logoImageView.left(), y: self.tagBgView.bottom() + 25, width: SCREEN_WIDTH - 30, height: 0.5));
        self.lineImageView?.image = #imageLiteral(resourceName: "icon_xuxian");
        self.advantageBgView = UIView(frame: CGRect(x: 0, y: (self.lineImageView?.bottom())!, width: SCREEN_WIDTH, height: 44));
        self.advantageLabel.frame = CGRect.zero;
        self.contentView.addSubview(self.lineImageView!);
        self.contentView.addSubview(self.advantageBgView!);*/
        
        self.loanDescribLabel = UILabel(frame: CGRect(x: self.tagBgView.left(), y: self.tagBgView.bottom() + 10, width: self.tagBgView.width(), height: 15));
        self.loanDescribLabel?.font = UIFont.systemFont(ofSize: 12);
        self.loanDescribLabel?.textColor = COLOR_FONT_TEXT;
        self.lineImage = UIImageView(frame: CGRect(x: 15, y: (self.loanDescribLabel?.bottom())! + 10 - DIMEN_BORDER, width: SCREEN_WIDTH - 30, height: DIMEN_BORDER));
        self.lineImage?.image = #imageLiteral(resourceName: "icon_xuxian");
        self.advantageLabel.frame = CGRect(x: 15, y: (self.lineImage?.bottom())! + 10, width: SCREEN_WIDTH - 30, height: 17);
        self.herlineView.isHidden = true;
        let view = UIView();
        view.frame = CGRect(x: 0, y: 160, width: SCREEN_WIDTH, height: 10);
        view.backgroundColor = COLOR_GROUND;
        self.contentView.addSubview(self.lineImage!);
        self.contentView.addSubview(self.loanDescribLabel!);
        self.contentView.addSubview(view);
//        self.advantageLabel = UILabel(frame: CGRect(x: self.merchantNameLabel.left(), y: tagBgView.bottom() + 10, width: self.merchantNameLabel.width(), height: 15));
    }
    
    
    override func setData(product: Product) {
        super.setData(product: product);
        let postiveRateStr = NSMutableAttributedString(string: "\(product.positiveRate ?? "")%好评", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:COLOR_ORANGE!]);
        let productCountStr = NSMutableAttributedString(string: "   \(product.productCount ?? "")已申请", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:COLOR_BLUE_NAV!]);
        postiveRateStr.append(productCountStr);
        self.loanDescribLabel?.attributedText = postiveRateStr;
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
