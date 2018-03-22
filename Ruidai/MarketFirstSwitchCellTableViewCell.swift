//
//  MarketFirstSwitchCellTableViewCell.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/9.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MarketFirstSwitchCellTableViewCell: UITableViewCell {
    var titleLabel : UILabel!
    var selectedImageView : UIImageView!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.titleLabel = UILabel(frame: CGRect(x: 15, y: 12, width: 70, height: 20));
        self.titleLabel.textColor = COLOR_FONT_TEXT;
        self.titleLabel.font = UIFont.systemFont(ofSize: 14);
        self.selectedImageView = UIImageView(frame: CGRect(x: self.titleLabel.right() + 5, y: 17, width: 15, height: 10));
        self.selectedImageView.image = #imageLiteral(resourceName: "market_selected");
        self.selectedImageView.isHidden = true;
        self.contentView.addSubview(self.titleLabel);
        self.contentView.addSubview(self.selectedImageView);
        
    }
    
    func setCellSelected(isSelected: Bool){
        if isSelected == true {
            self.selectedImageView.isHidden = false;
            self.titleLabel.textColor = COLOR_BLUE;
        }else{
            self.selectedImageView.isHidden = true;
            self.titleLabel.textColor = COLOR_FONT_TEXT;
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
