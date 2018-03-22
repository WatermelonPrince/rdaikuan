//
//  LoanActivityPreHeaderView.swift
//  Jubaodai
//
//  Created by zhaohuan on 2017/12/7.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanActivityPreHeaderView: UIView {
    var seciton: Int?
    var touchView: UIView?
    var clickHanlder: ((_ index: Int) -> ())?
    var tapGesture: UITapGestureRecognizer?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.touchView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44));
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction));
        self.touchView?.addGestureRecognizer(self.tapGesture!);
        self.addSubview(self.touchView!);
    
    }
    
    func tapAction(){
        if self.clickHanlder != nil && self.seciton != nil {
            self.clickHanlder!(self.seciton!);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
