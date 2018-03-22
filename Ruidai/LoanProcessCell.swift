//
//  LoanProcessCell.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/25.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ProcessComponentView: UIView {
    var iconImageView : UIImageView!
    var titlelabel : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 33 * RATIO, height: 33 * RATIO));
        self.iconImageView.center.x = 40 * RATIO;
        self.titlelabel = UILabel(frame: CGRect(x: 0, y: self.iconImageView.bottom() + 7*RATIO, width: 80 * RATIO, height: 15 * RATIO));
        self.titlelabel.font = UIFont.systemFont(ofSize: K_FONT_SIZE);
        self.titlelabel.textColor = COLOR_FONT_HEAD;
        self.titlelabel.textAlignment = .center;
        self.addSubview(self.iconImageView);
        self.addSubview(self.titlelabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LoanProcessCell: CommonBaseTableViewCell {
    var lineView : UIView!
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.lineView = UIView(frame: CGRect(x: 0, y: 84*RATIO - DIMEN_BORDER, width: SCREEN_WIDTH, height: DIMEN_BORDER));
        self.lineView.backgroundColor = COLOR_BORDER;
        self.contentView.addSubview(self.lineView);
        
        
    }
    
    func reloadCellWithPrameter(dataArr:Array<Tags>){
        let width = 80 * RATIO;
        let spaceWidth = (SCREEN_WIDTH - 4 * 80 * RATIO - 30)/3
        var dataArr = dataArr;
        while dataArr.count > 4 {
            dataArr.removeLast();
        }
        if dataArr.count > 0{
            for (index,item) in dataArr.enumerated() {
                let view = ProcessComponentView(frame: CGRect(x: 15 + (width + spaceWidth)*CGFloat(index), y: 15, width: 80*RATIO, height: 55*RATIO));
                view.iconImageView.sd_setImage(with: CommonUtil.getURL(item.image), placeholderImage: UIImage(named: "icon_process"));
                view.titlelabel.text = item.name;
                let indictorImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 10 * RATIO, height: 15 * RATIO));
                indictorImage.image = #imageLiteral(resourceName: "icon_filter");
                indictorImage.center.x = view.right() + spaceWidth/2;
                indictorImage.center.y = view.iconImageView.height()/2 + view.top();
                if index == dataArr.count - 1 {
                    indictorImage.isHidden = true;
                }
                self.contentView.addSubview(view);
                self.contentView.addSubview(indictorImage);
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
