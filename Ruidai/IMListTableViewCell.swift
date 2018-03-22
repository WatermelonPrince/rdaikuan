//
//  IMListTableViewCell.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/11/15.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class IMListTableViewCell: UITableViewCell {
    var userImage: UIImageView!
    var infoImage: UIImageView!
    var infoLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.userImage = UIImageView(frame: CGRect(x: SCREEN_WIDTH - 45 , y: 15, width: 30, height: 30));
        self.userImage.layer.cornerRadius = 15;
        self.userImage.layer.masksToBounds = true;
        self.userImage.sd_setImage(with: CommonUtil.getURL(LotteryUtil.user()?.avatar), placeholderImage: nil);
        self.infoLabel = UILabel();
        self.infoLabel.numberOfLines = 0;
        var image = UIImage.init(named: "im_msgbubble");
        image = image?.stretchableImage(withLeftCapWidth: Int(image!.size.width * 0.5), topCapHeight: Int(image!.size.height * 0.5));
        
       

        self.infoImage = UIImageView();
        self.infoImage.image = image;
        self.contentView.addSubview(self.userImage);
        self.contentView.addSubview(self.infoImage);
        self.infoImage.addSubview(self.infoLabel);
        
        
        
    }
    
    func reloadCell(string: NSAttributedString){
        
    
        let maxImageWidth = SCREEN_WIDTH - 55;
        let maxContentWidth = SCREEN_WIDTH - 80;
        var realHeight = CGFloat(0);
        var realImageWidth = CGFloat(0);
        var realLabelWidth = CGFloat(0);
        let rect =  string.boundingRect(with: CGSize.init(width: 0, height: 30), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil);
        if rect.size.width > maxContentWidth {
            let rect = string.boundingRect(with: CGSize.init(width: maxContentWidth
                , height: 0), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil);
            realHeight = rect.size.height;
            realImageWidth = maxImageWidth;
            realLabelWidth = maxContentWidth;
            self.infoImage.frame = CGRect(x: SCREEN_WIDTH - 45 - realImageWidth, y: self.userImage.top(), width: realImageWidth, height: realHeight + 20);

            self.infoLabel.frame = CGRect(x: 13, y: 8, width: realLabelWidth, height: realHeight);
            self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.infoImage.bottom() + 10);
        }else{
            realHeight = 30;
            realLabelWidth = rect.size.width;
            realImageWidth = realLabelWidth + 25;
            self.infoImage.frame = CGRect(x: SCREEN_WIDTH - 45 - realImageWidth, y: self.userImage.top(), width: realImageWidth, height: 30);
            self.infoLabel.frame = CGRect(x: 13, y: 0, width: realLabelWidth, height: realHeight);
            self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.infoImage.bottom() + 10);
        }

        self.infoLabel.attributedText = string;
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
