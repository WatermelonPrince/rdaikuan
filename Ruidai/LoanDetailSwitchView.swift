//
//  LoanDetailSwitchView.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/12.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanDetailSwitchView: UIView {
    var firstBtn: LoanDetailSwithBtn?
    var secondBtn: LoanDetailSwithBtn?
    var thirdBtn: LoanDetailSwithBtn?
    var lineView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_GROUND;

        
        
        
    }
    
    convenience init(arrStr: Array<String>, count: Int?, frame: CGRect) {
        self.init(frame: frame);
        if count == 3 {
            self.firstBtn = LoanDetailSwithBtn(title: "贷款详情", normalColor: COLOR_FONT_SECONDARY, selectedColor: COLOR_BLUE!, titleFont: UIFont.systemFont(ofSize: 15), lineColor: COLOR_BLUE!, frame: CGRect(x: 0, y: 10, width: SCREEN_WIDTH/3, height: 45));
            self.firstBtn?.setSelectedTrueOrFalse(isSlected: true);
            self.secondBtn = LoanDetailSwithBtn(title: "用户评价", normalColor: COLOR_FONT_SECONDARY, selectedColor: COLOR_BLUE!, titleFont: UIFont.systemFont(ofSize: 15), lineColor: COLOR_BLUE!, frame: CGRect(x: SCREEN_WIDTH/3, y: 10, width: SCREEN_WIDTH/3, height: 45));
            self.thirdBtn = LoanDetailSwithBtn(title: "贷款攻略", normalColor: COLOR_FONT_SECONDARY, selectedColor: COLOR_BLUE!, titleFont: UIFont.systemFont(ofSize: 15), lineColor: COLOR_BLUE!, frame: CGRect(x: SCREEN_WIDTH/3*2, y: 10, width: SCREEN_WIDTH/3, height: 45));
            self.lineView = UIView(frame: CGRect(x: 0, y: 55 - DIMEN_BORDER, width: SCREEN_WIDTH, height: DIMEN_BORDER));
            self.lineView?.backgroundColor = COLOR_BORDER;
            
            self.addSubview(self.firstBtn!);
            self.addSubview(self.secondBtn!);
            self.addSubview(self.thirdBtn!);
            return;
        }
        
        if count == 2 {
            self.firstBtn = LoanDetailSwithBtn(title: "贷款详情", normalColor: COLOR_FONT_SECONDARY, selectedColor: COLOR_BLUE!, titleFont: UIFont.systemFont(ofSize: 15), lineColor: COLOR_BLUE!, frame: CGRect(x: 0, y: 10, width: SCREEN_WIDTH/2, height: 45));
            self.firstBtn?.setSelectedTrueOrFalse(isSlected: true);
            self.secondBtn = LoanDetailSwithBtn(title: "用户评价", normalColor: COLOR_FONT_SECONDARY, selectedColor: COLOR_BLUE!, titleFont: UIFont.systemFont(ofSize: 15), lineColor: COLOR_BLUE!, frame: CGRect(x: (self.firstBtn?.right())!, y: 10, width: SCREEN_WIDTH/2, height: 45));
            self.addSubview(self.firstBtn!);
            self.addSubview(self.secondBtn!);
        }
        
    }
    
    func setBtnSelected(index:Int){
        if index > 2 {
            return;
        }
        
        if index == 0 {
            self.firstBtn?.setSelectedTrueOrFalse(isSlected: true);
            self.secondBtn?.setSelectedTrueOrFalse(isSlected: false);
            self.thirdBtn?.setSelectedTrueOrFalse(isSlected: false);
        }else if index == 1{
            self.firstBtn?.setSelectedTrueOrFalse(isSlected: false);
            self.secondBtn?.setSelectedTrueOrFalse(isSlected: true);
            self.thirdBtn?.setSelectedTrueOrFalse(isSlected: false);
        }else{
            self.firstBtn?.setSelectedTrueOrFalse(isSlected: false);
            self.secondBtn?.setSelectedTrueOrFalse(isSlected: false);
            self.thirdBtn?.setSelectedTrueOrFalse(isSlected: true);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   

}
