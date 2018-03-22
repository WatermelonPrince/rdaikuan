//
//  LoanReviewCell.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/12.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanReviewCell: CommonBaseTableViewCell{
    var avatarImageView: UIImageView?
    var nickNameLabel: UILabel?
    var loanStarsView: LoanReviewStarsView?
    var dateLabel: UILabel?
    var locationLabel: UILabel?
    var detailLabel: UILabel?
    var loanStatusLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.backgroundColor = COLOR_WHITE;
        self.avatarImageView = UIImageView(frame: CGRect(x: 15, y: 15, width: 20, height: 20));
        self.avatarImageView?.layer.cornerRadius = 10;
        self.avatarImageView?.layer.masksToBounds = true;
        self.avatarImageView?.contentMode = .scaleAspectFill;
        self.nickNameLabel = UILabel(frame: CGRect(x: (self.avatarImageView?.right())! + 10, y: (self.avatarImageView?.top())!, width: 90, height: 20));
        self.nickNameLabel?.textColor = COLOR_FONT_HEAD;
        self.nickNameLabel?.font = UIFont.systemFont(ofSize: 15);
        self.loanStarsView = LoanReviewStarsView(frame: CGRect(x: (self.nickNameLabel?.right())! + 15,y: (self.nickNameLabel?.top())! + 4 , width: 80, height: 12), spaceWidth: 5, starWidth: 12, starCount: 5);
        self.dateLabel = UILabel(frame: CGRect(x: SCREEN_WIDTH - 100, y: (self.nickNameLabel?.top())!, width: 85, height: 20));
        self.dateLabel?.textColor = COLOR_FONT_SECONDARY;
        self.dateLabel?.font = UIFont.systemFont(ofSize: 15);
        self.locationLabel = UILabel(frame: CGRect(x: (self.nickNameLabel?.left())!, y: (self.nickNameLabel?.bottom())!, width: 200, height: 17));
        self.locationLabel?.textColor = COLOR_FONT_SECONDARY;
        self.locationLabel?.font = UIFont.systemFont(ofSize: 13);
        self.detailLabel = UILabel();
        self.detailLabel?.font = UIFont.systemFont(ofSize: 15);
        self.detailLabel?.textColor = COLOR_FONT_TEXT;
        self.detailLabel?.numberOfLines = 0;
        self.loanStatusLabel = UILabel();
        self.loanStatusLabel?.textColor = COLOR_BLUE;
        self.loanStatusLabel?.font = UIFont.systemFont(ofSize: 15);
        
        self.loanStatusLabel?.font = UIFont.systemFont(ofSize: 15);
        
        self.contentView.addSubview(self.avatarImageView!);
        self.contentView.addSubview(self.nickNameLabel!);
        self.contentView.addSubview(self.loanStarsView!);
        self.contentView.addSubview(self.dateLabel!);
        self.contentView.addSubview(self.locationLabel!);
        self.contentView.addSubview(self.detailLabel!);
        self.contentView.addSubview(self.loanStatusLabel!);
    }
    
    
    func reloadCellWithData(commentModel: CommentVo){
        let height = CommonUtil.getLabelHeight(text: commentModel.content ?? "", width: SCREEN_WIDTH - 30, font: UIFont.systemFont(ofSize: 15));
        self.detailLabel?.frame = CGRect(x: 15, y: (self.locationLabel?.bottom())! + 15, width: SCREEN_WIDTH-30, height: height);
        self.loanStatusLabel?.frame = CGRect(x: 15, y: (self.detailLabel?.bottom())! + 15, width: SCREEN_WIDTH - 30, height: 20);
        self.contentView.addSubview(self.detailLabel!);
        self.contentView.addSubview(self.loanStatusLabel!);
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: (self.loanStatusLabel?.bottom())! + 15);
        
        self.avatarImageView?.sd_setImage(with: CommonUtil.getURL(commentModel.userAvatar ?? ""), placeholderImage: #imageLiteral(resourceName: "icon_avatar"));
        self.nickNameLabel?.text = commentModel.userName ?? "";
        self.loanStarsView?.reloadViewWithStarsValue(value: commentModel.mark ?? 5);
        self.detailLabel?.text = commentModel.content ?? "";
        self.dateLabel?.text = commentModel.createTimeStr ?? "";
        self.locationLabel?.text = commentModel.location ?? "";
        self.loanStatusLabel?.text = "贷款状态：\(commentModel.applyStatus ?? "")";
        
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
