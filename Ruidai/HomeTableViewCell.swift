//
//  HomeTableViewCell.swift
//  Lottery
//
//  Created by DTY on 17/1/18.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanMarketTableViewCell: HomeTableViewCell {
    var loanDescribLabel: UILabel?
    var lineImage: UIImageView?
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.loanDescribLabel = UILabel(frame: CGRect(x: self.tagBgView.left(), y: self.tagBgView.bottom() + 5, width: self.tagBgView.width(), height: 18));
        self.lineImage = UIImageView(frame: CGRect(x: 15, y: (self.loanDescribLabel?.bottom())! + 5 - DIMEN_BORDER, width: SCREEN_WIDTH - 30, height: DIMEN_BORDER));
        self.lineImage?.image = #imageLiteral(resourceName: "icon_xuxian");
        self.advantageLabel.frame = CGRect(x: 15, y: (self.lineImage?.bottom())! + 3, width: SCREEN_WIDTH - 30, height: 17);
        self.herlineView.isHidden = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class HomeTableViewCell: CommonBaseTableViewCell {
    let MAX_AUTHORIZE_TAGS = 5;
    
    var borderView: UIView!;
    var logoImageView: UIImageView!
    var merchantNameLabel: UILabel!;
    var loanAmountLabel: UILabel!;
    var loanDaysLabel: UILabel!;
    var authorizeTagsLabelArray: Array<UILabel>!;
    var advantageLabel: UILabel!;
    var titleArr = Array<Tags>();
    var tagBgView : UIView!
    var recommandImage : UIImageView!
    var recommandLabel : UILabel!
    var herlineView: UIView!
    
    var linkTapGesture: UITapGestureRecognizer?
    var product: Product?
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none;
        
        self.backgroundColor = COLOR_WHITE;
        
        self.borderView = UIView(frame: CGRect(x: 10, y: 5, width: SCREEN_WIDTH - 20, height: 130));
        self.borderView.backgroundColor = COLOR_WHITE;
        self.borderView.layer.cornerRadius = 6;
        self.borderView.layer.borderColor = COLOR_BORDER.cgColor;
        self.borderView.layer.borderWidth = 0.5;
//        self.contentView.addSubview(borderView);
        
        // 公司logo
        self.logoImageView = UIImageView(frame: CGRect(x: 15, y: 15, width: 40, height: 40));
        self.logoImageView.layer.cornerRadius = 20;
        self.logoImageView.layer.masksToBounds = true;
        self.contentView.addSubview(self.logoImageView);
        
        
        // 公司名称
        self.merchantNameLabel = UILabel(frame: CGRect(x: self.logoImageView.frame.maxX + 10, y: self.logoImageView.frame.minY, width: SCREEN_WIDTH - self.logoImageView.frame.maxX - 20 - 40 , height: 20));
        self.merchantNameLabel.font = UIFont.boldSystemFont(ofSize: 17);
        self.merchantNameLabel.textColor = COLOR_FONT_TEXT;
        self.merchantNameLabel.textAlignment = .left;
        self.contentView.addSubview(self.merchantNameLabel);
//        self.merchantNameLabel.backgroundColor = COLOR_RED;
        
        // 金额
        self.loanAmountLabel = UILabel(frame: CGRect(x: self.merchantNameLabel.frame.minX, y: self.merchantNameLabel.frame.maxY + 5, width: self.merchantNameLabel.frame.width, height: 24));
//        self.loanAmountLabel.font = UIFont.systemFont(ofSize: 15);
        self.loanAmountLabel.textColor = COLOR_FONT_SECONDARY;
        self.contentView.addSubview(self.loanAmountLabel);
        
        //标签背景视图
        self.tagBgView = UIView(frame: CGRect(x: self.loanAmountLabel.left(), y: self.loanAmountLabel.bottom() + 5, width: self.loanAmountLabel.width(), height: 20));

      //推荐tag图
        self.recommandImage = UIImageView(frame: CGRect(x: SCREEN_WIDTH - 40, y: self.merchantNameLabel.top(), width: 25, height: 25));
        self.recommandImage.isUserInteractionEnabled = true;
        self.linkTapGesture = UITapGestureRecognizer();
        self.recommandImage.addGestureRecognizer(self.linkTapGesture!);
        
        self.recommandLabel = UILabel(frame: CGRect(x: self.recommandImage.left(), y: self.recommandImage.bottom() + 5, width: self.recommandImage.width(), height: self.recommandImage.height()));
        self.recommandLabel.font = UIFont.systemFont(ofSize: 12);
        self.recommandLabel.textColor = COLOR_FONT_SECONDARY;
        
        
        
        
        
       
        
        //优势
        self.advantageLabel = UILabel(frame: CGRect(x: self.merchantNameLabel.left(), y: tagBgView.bottom() + 10, width: self.merchantNameLabel.width(), height: 15));
        self.advantageLabel.textColor = COLOR_FONT_SECONDARY;
        self.advantageLabel.font = UIFont.systemFont(ofSize: 13);
        
        
        self.herlineView = UIView(frame: CGRect(x: 15, y: self.advantageLabel.bottom() + 15, width: SCREEN_WIDTH - 30, height: DIMEN_BORDER));
        self.herlineView.backgroundColor = COLOR_BORDER;
        
        self.contentView.addSubview(self.herlineView);
        self.contentView.addSubview(self.recommandImage);
        self.contentView.addSubview(self.recommandLabel);
        self.contentView.addSubview(self.advantageLabel);
        self.contentView.addSubview(self.tagBgView);

        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(product: Product) {
        self.product = product;
        self.logoImageView.sd_setImage(with: CommonUtil.getURL(product.productLogo ?? ""));
        self.merchantNameLabel.text = product.productName;
        let appedStr = NSMutableAttributedString(string: "最高额度：", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 15)]);
        let amoutAttstr = NSMutableAttributedString(string: product.maxLoanAmount ?? "", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 15),NSForegroundColorAttributeName:COLOR_ORANGE]);
        appedStr.append(amoutAttstr);
        self.loanAmountLabel.attributedText = appedStr;
        
//        //清空上次标签
        for view in self.tagBgView.subviews {
            view.removeFromSuperview();
        }
        self.titleArr.removeAll();
        
        if product.authorizeTagsList != nil {
            for tagModel in product.authorizeTagsList! {
                tagModel.colorType = 0;
                self.titleArr.append(tagModel);
            }
        }
        
        if product.featureTagsList != nil {
            for tagModel in product.featureTagsList! {
                tagModel.colorType = 1;

                self.titleArr.append(tagModel);
            }
        }
        
        
        
        
        
        var totalWidth = CGFloat(0);
        for tagModel in self.titleArr {
            let strWith = CommonUtil.autoLabelWidth(text: tagModel.name!, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 11)]) + 18;
            let width = CommonUtil.autoLabelWidth(text: tagModel.name!, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 11)]) + 18 + totalWidth;
            if width < self.tagBgView.width() {
                totalWidth = CommonUtil.autoLabelWidth(text: tagModel.name!, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 11)]) + totalWidth + 18;
                let label = UILabel(frame: CGRect(x: totalWidth - strWith, y: 0, width: strWith - 8, height: 20));
                label.font = UIFont.systemFont(ofSize: 11);
                label.layer.cornerRadius = 4;
                label.textAlignment = .center;
                label.backgroundColor = COLOR_TAGGROUNG;
                label.textColor = COLOR_FONT_TEXT;
//                label.layer.borderWidth = DIMEN_BORDER;
                label.text = tagModel.name;
                self.tagBgView.addSubview(label);
//                if tagModel.colorType == 0 {
//                    label.backgroundColor = COLOR_TAGGROUND_BLUE;
//                    label.layer.borderColor = COLOR_TAG_BLUE.cgColor;
//                    label.textColor = COLOR_TAG_BLUE;
//                }else{
//                    label.backgroundColor = COLOR_TAGGROUND_YELLOW.withAlphaComponent(0.7);
//                    label.layer.borderColor = COLOR_YELLOW.cgColor;
//                    label.textColor = COLOR_TAGTEXT_YELLOW;
//                    
//                }
                
            }
            
        }
        self.recommandImage.image = nil;
        if (product.strategyLink != nil && product.strategyLink != "") {
            self.recommandImage.sd_setImage(with: CommonUtil.getURL(product.strategyImage));
            self.recommandLabel.text = "攻略";
        }else{
            self.recommandImage.image = nil;
            self.recommandLabel.text = "";
        }
        
        self.advantageLabel.text = product.advantage ?? "";

    }
    
}

