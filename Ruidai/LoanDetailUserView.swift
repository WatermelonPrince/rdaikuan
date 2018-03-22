//
//  LoanDetailUserView.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/25.
//  Copyright © 2017年 caipiao. All rights reserved.
//

class TagModel: BaseModel {
    var titleStr : String!
    var type : Int!
    
}
class LoanDetailUserView: UIView {
    var iconImageView : UIImageView!
    var titleLabel : UILabel!
    var tagBgView : UIView!
    var titleArr = Array<Tags>();
    var favaRateLabel: UILabel!
    var applyCountLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.iconImageView = UIImageView(frame: CGRect(x: 15, y: 20, width: 45, height: 45));
        
        self.iconImageView.contentMode = .scaleAspectFit;
        self.iconImageView.layer.cornerRadius = 22.5;
        self.iconImageView.layer.masksToBounds = true;
        self.titleLabel = UILabel(frame: CGRect(x: self.iconImageView.right() + 20, y: 20, width: SCREEN_WIDTH - 50 - self.iconImageView.width(), height: 20));
        self.titleLabel.font = UIFont.systemFont(ofSize: 16);
        self.titleLabel.textColor = COLOR_FONT_HEAD;
        self.tagBgView = UIView(frame: CGRect(x: self.titleLabel.left(), y: self.titleLabel.bottom() + 10, width: self.titleLabel.width(), height: 15));
        self.favaRateLabel = UILabel(frame: CGRect(x: self.tagBgView.left(), y: self.tagBgView.bottom() + 10, width: 110, height: 20));
        self.favaRateLabel.textColor = COLOR_ORANGE;
        self.favaRateLabel.font = UIFont.systemFont(ofSize: 14);
        self.favaRateLabel.text = "好评率：100%";
        self.applyCountLabel = UILabel(frame: CGRect(x: self.favaRateLabel.right(), y: self.tagBgView.bottom() + 10, width: self.tagBgView.width()/2, height: 20));
        self.applyCountLabel.textColor = COLOR_BLUE;
        self.applyCountLabel.font = UIFont.systemFont(ofSize: 14);
        self.applyCountLabel.text = "已申请：5.1万";
//        self.tagBgView.backgroundColor = COLOR_RED;
        let lineView = UIImageView(frame: CGRect(x: 15, y: self.applyCountLabel.bottom() + 10, width: SCREEN_WIDTH - 30, height: 0.5));
        lineView.image = #imageLiteral(resourceName: "icon_xuxian");
//        lineView.backgroundColor = COLOR_BORDER;
        self.addSubview(self.iconImageView);
        self.addSubview(self.titleLabel);
        self.addSubview(self.tagBgView);
        self.addSubview(self.favaRateLabel);
        self.addSubview(self.applyCountLabel);
        self.addSubview(lineView);
        self.backgroundColor = COLOR_WHITE;
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadArr(conditionArr:Array<Tags>,descArr:Array<Tags>,imageUrl:String,title:String){
        self.iconImageView.sd_setImage(with: CommonUtil.getURL(imageUrl), placeholderImage: nil);
        self.titleLabel.text = title;
        
        //清空上次标签
        self.titleArr.removeAll();
        for view in self.tagBgView.subviews {
            view.removeFromSuperview();
        }
        
        for tagmodel in conditionArr {
            tagmodel.colorType = 0;
            
            self.titleArr.append(tagmodel);
        }
        
        for tagmodel in descArr {
            tagmodel.colorType = 1;
            
            self.titleArr.append(tagmodel);
        }
        
        
        var totalWidth = CGFloat(0);
        for tagModel in self.titleArr {
           let strWith = CommonUtil.autoLabelWidth(text: tagModel.name ?? "", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 11)]) + 12;
           let width = CommonUtil.autoLabelWidth(text: tagModel.name ?? "", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 11)]) + 12 + totalWidth;
            if width < self.tagBgView.width() {
                totalWidth = CommonUtil.autoLabelWidth(text: tagModel.name ?? "", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 11)]) + totalWidth + 12;
                let label = UILabel(frame: CGRect(x: totalWidth - strWith, y: 0, width: strWith - 4, height: 18));
                label.font = UIFont.systemFont(ofSize: 11);
                label.layer.cornerRadius = 2;
                label.textAlignment = .center;
//                label.layer.borderWidth = DIMEN_BORDER;
                label.text = tagModel.name;
                self.tagBgView.addSubview(label);
                if tagModel.colorType == 0 {
                    label.backgroundColor = COLOR_TAGGROUNG;
//                    label.layer.borderColor = COLOR_TAG_BLUE.cgColor;
                    label.textColor = COLOR_FONT_TEXT;
                }else{
                    label.backgroundColor = COLOR_TAGGROUNG;
//                    label.layer.borderColor = COLOR_YELLOW.cgColor;
                    label.textColor = COLOR_FONT_TEXT;
                    
                }
            }
            
        }
        
    }
    
    
    

}
