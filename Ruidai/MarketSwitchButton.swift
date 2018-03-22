//
//  MarketSwitchButton.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/9/25.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MarketFilterSwitchButton: MarketSwitchButton {
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    override func setSelectedTureOrFalse(selected: Bool) {
        if selected == true {
            self.setImage(#imageLiteral(resourceName: "icon_market_filter"), for: .selected);
            self.setTitleColor(COLOR_BLUE, for: .selected);
            self.isSelected = true;
            
        }else{
            self.setImage(#imageLiteral(resourceName: "icon_market_filter"), for: .normal);
            self.setTitleColor(COLOR_FONT_TEXT, for: .normal);
            self.isSelected = false;
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MarketSwitchButton: UIButton {
    
    let ratio  = CGFloat(5);
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14);


    }
    
    
    func setSelectedTureOrFalse(selected : Bool){
        if selected == true {
            self.setImage(#imageLiteral(resourceName: "icon_shangsanjiao"), for: .selected);
            self.setTitleColor(COLOR_BLUE, for: .selected);
            self.isSelected = true;

        }else{
            self.setImage(#imageLiteral(resourceName: "icon_xiasanjiao"), for: .normal);
            self.setTitleColor(COLOR_FONT_TEXT, for: .normal);
            self.isSelected = false;

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        var imageRect = self.imageView?.frame;
        let width = self.imageView?.image?.size.width ?? 0;
        let height = self.imageView?.image?.size.height ?? 0;
        imageRect?.size = CGSize.init(width: width, height: height);
        imageRect?.origin.x = self.frame.size.width - width - self.frame.width/ratio;
        imageRect?.origin.y = (self.frame.size.height - height)/2.0;
        var titleRect = self.titleLabel?.frame;
        titleRect?.origin.x = (self.frame.size.width - (imageRect?.size.width)! - (titleRect?.size.width)! - self.frame.width/ratio);
        titleRect?.origin.y = (self.frame.size.height - (titleRect?.size.height)!)/2.0;
        self.imageView?.frame = imageRect!;
        self.titleLabel?.frame = titleRect!;
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
