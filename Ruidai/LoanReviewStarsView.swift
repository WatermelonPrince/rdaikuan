//
//  LoanReviewStarsView.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/12.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
//可以点击的评分View
class LoanTitleAndStarClickView: UIView {
    var titleLabel: UILabel?
    var reviewStarView : LoanReviewStarsSelectedView?
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 95, height: 16));
        self.titleLabel?.textAlignment = .right;
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        self.titleLabel?.textColor = COLOR_FONT_HEAD;
        self.reviewStarView = LoanReviewStarsSelectedView(frame:CGRect(x: 105, y: 0, width: 105, height: 16), spaceWidth: 5, starWidth: 16, starCount: 5);
        self.addSubview(self.titleLabel!);
        self.addSubview(self.reviewStarView!);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//只是显示的评分View
class LoanTitleAndStarReviewView: UIView {
    var titleLabel: UILabel?
    var reviewStarView: LoanReviewStarsView?
    //width:215
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 95, height: 16));
        self.titleLabel?.textAlignment = .right;
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        self.titleLabel?.textColor = COLOR_FONT_HEAD;
        self.reviewStarView = LoanReviewStarsView(frame:CGRect(x: 105, y: 0, width: 105, height: 16), spaceWidth: 5, starWidth: 16, starCount: 5);
        self.addSubview(self.titleLabel!);
        self.addSubview(self.reviewStarView!);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LoanReviewStarsSelectedView: LoanReviewStarsView {
    var selectedIndex : Int?
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    override func selectedAction(action: UIButton) {
        self.reloadViewWithStarsValue(value: 0);
        self.selectedIndex = action.tag - 11111;
        for i in 0...(action.tag - 11111) {
            self.arrBtn?[i].isSelected = true;
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LoanReviewStarsView: UIView {
    var arrBtn: Array<UIButton>?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    convenience init(frame:CGRect,spaceWidth:CGFloat,starWidth:CGFloat,starCount:Int) {
        self.init(frame: frame);
        self.arrBtn = Array<UIButton>();
        for i in 0..<starCount {
            let starBtn = UIButton(frame: CGRect(x: (starWidth + spaceWidth) * CGFloat(i), y: 0, width: starWidth, height: starWidth));
            starBtn.setImage(#imageLiteral(resourceName: "icon_review_star"), for: .selected);
            starBtn.setImage(#imageLiteral(resourceName: "icon_normal_star"), for: .normal);
            starBtn.tag = 11111 + i;
            starBtn.addTarget(self, action: #selector(selectedAction), for: .touchUpInside);
            self.arrBtn?.append(starBtn);
            self.addSubview(starBtn);
        }
    }
    
    func selectedAction(action : UIButton){
        
    }
    
    func reloadViewWithStarsValue(value:Int){
        for (index,item) in (self.arrBtn?.enumerated())! {
            item.isSelected = false;
            if index < value {
                item.isSelected = true;
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   

}
