//
//  HomeNavTitleView.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/9/21.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class HomeNavTitleView: UIView {

    var iconImage : UIImageView?
    var labelBgView : UIView?
    var titlLabel : UILabel?
    var smallImage : UIImageView?
    var touchBtn : UIButton?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.iconImage = UIImageView(image: #imageLiteral(resourceName: "icon_homeNaviIcon"));
        self.iconImage?.frame = CGRect(x: 10, y: 2, width: 65, height: 25);
        self.labelBgView = UIView(frame: CGRect(x: (self.iconImage?.right())! + 5, y: 0, width: 240 * RATIO, height: 30));
        self.labelBgView?.backgroundColor = COLOR_WHITE.withAlphaComponent(0.3);
        //self.labelBgView?.backgroundColor = color_;
        self.labelBgView?.layer.cornerRadius = 3;
        self.labelBgView?.layer.masksToBounds = true;
        self.titlLabel = UILabel(frame: CGRect(x: 60 * RATIO, y: 0, width: 7 * 15 * RATIO, height: 30));
        self.titlLabel?.textColor = COLOR_FONT_SECONDARY;
        self.titlLabel?.font = UIFont.systemFont(ofSize: 15 * RATIO);
        self.titlLabel?.text = "你想借多少?";
        self.titlLabel?.textAlignment = .center;
        self.smallImage = UIImageView(frame: CGRect(x: (self.titlLabel?.right())!, y: 11, width: 12, height: 8));
        self.smallImage?.image = #imageLiteral(resourceName: "icon_arrow_down");
        self.touchBtn = UIButton(frame: CGRect(x: 0, y: 0, width: (self.labelBgView?.width())!, height: (self.labelBgView?.height())!));
        self.addSubview(self.iconImage!);
        self.addSubview(self.labelBgView!);
        self.labelBgView?.addSubview(self.titlLabel!);
        self.labelBgView?.addSubview(self.smallImage!);
        self.labelBgView?.addSubview(self.touchBtn!);
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
