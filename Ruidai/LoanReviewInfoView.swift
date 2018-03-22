//
//  LoanReviewInfoView.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/12.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanReviewInfoView: UIView {
    var iconImage: UIImageView?
    var titleLabel: UILabel?
    var rateFavaLevelView: LoanTitleAndStarReviewView?
    var loanFavaLevelView: LoanTitleAndStarReviewView?
    var processFavaLevelView: LoanTitleAndStarReviewView?
    var levelBgView: UIView?
    var lineImage: UIImageView?
    
    //height:117
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_WHITE;
        self.iconImage = UIImageView(frame: CGRect(x: 15, y: 22, width: 73, height: 73));
        self.iconImage?.image = #imageLiteral(resourceName: "icon_review_circle");
//        self.iconImage?.backgroundColor = COLOR_ORANGEGROUND;
        self.iconImage?.contentMode = .scaleToFill;
        self.iconImage?.layer.cornerRadius = 73/2;
        self.iconImage?.layer.masksToBounds = true;
        self.titleLabel = UILabel(frame: (self.iconImage?.frame)!);
        self.titleLabel?.layer.cornerRadius = 73/2;
        self.titleLabel?.textAlignment = .center;
        self.titleLabel?.numberOfLines = 2;
        self.levelBgView = UIView();
        self.rateFavaLevelView = LoanTitleAndStarReviewView(frame: CGRect(x: 0, y: 0, width: 215, height: 16));
        self.rateFavaLevelView?.titleLabel?.text = "费率满意度:";
        
        self.loanFavaLevelView = LoanTitleAndStarReviewView(frame: CGRect(x: 0, y: (self.rateFavaLevelView?.bottom())! + 10, width: 215, height: 16));
        self.loanFavaLevelView?.titleLabel?.text = "贷款满意度:";
        self.processFavaLevelView = LoanTitleAndStarReviewView(frame: CGRect(x: 0, y: (self.loanFavaLevelView?.bottom())! + 10, width: 215, height: 16));
        self.processFavaLevelView?.titleLabel?.text = "流程满意度:";
        self.levelBgView?.addSubview(self.rateFavaLevelView!);
        self.levelBgView?.addSubview(self.loanFavaLevelView!);
        self.levelBgView?.addSubview(self.processFavaLevelView!);
        
        self.levelBgView?.frame = CGRect(x: (self.iconImage?.right())!, y: 0, width: 215, height: (self.processFavaLevelView?.bottom())!);
        self.levelBgView?.center.y = (self.iconImage?.center.y)!;
//        self.levelBgView?.backgroundColor = COLOR_RED;
        
        self.lineImage = UIImageView(frame: CGRect(x: 15, y: 117 - DIMEN_BORDER, width: SCREEN_WIDTH - 30, height: DIMEN_BORDER));
        self.lineImage?.image = #imageLiteral(resourceName: "icon_xuxian");
        
        self.addSubview(self.iconImage!);
        self.addSubview(self.titleLabel!);
        self.addSubview(self.levelBgView!);
        self.addSubview(self.lineImage!);
    }
    
    func reloadLoanInfo(favaRate:Int,rateFavaLevel:Int,loanFavaLevel:Int,processFavaLevel:Int){
        let attMutableStr = NSMutableAttributedString(string: String(favaRate), attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 25),NSForegroundColorAttributeName:COLOR_WHITE]);
        let centerAttstr = NSMutableAttributedString(string: "%\n", attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 12),NSForegroundColorAttributeName:COLOR_WHITE]);
        let finaAttstr = NSMutableAttributedString(string: "好评率", attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 12),NSForegroundColorAttributeName:COLOR_WHITE]);
        attMutableStr.append(centerAttstr);
        attMutableStr.append(finaAttstr);
        self.titleLabel?.attributedText = attMutableStr;
        self.rateFavaLevelView?.reviewStarView?.reloadViewWithStarsValue(value: rateFavaLevel);
        self.loanFavaLevelView?.reviewStarView?.reloadViewWithStarsValue(value: loanFavaLevel);
        self.processFavaLevelView?.reviewStarView?.reloadViewWithStarsValue(value: processFavaLevel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

   

}
