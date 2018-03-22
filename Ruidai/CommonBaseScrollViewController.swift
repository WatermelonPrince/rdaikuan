//
//  CommonBaseScrollViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/6.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class CommonBaseScrollViewController: BaseViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        self.scrollView = UIScrollView(frame: self.view.bounds);
       
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: SCREEN_HEIGHT-NAVIHEIGHT + 1);
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never

        }
        self.view.addSubview(self.scrollView);
        self.scrollView.delegate = self;
//        self.navigationController?.navigationBar.isTranslucent = false;
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resignTextFieldAction));
        self.scrollView.addGestureRecognizer(tapGestureRecognizer);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.resignTextFieldAction();
    }
    
    func resignTextFieldAction() {
        for subview in scrollView.subviews {
            if (subview.isKind(of: CommonBaseTextFieldView.classForCoder())) {
                for textField in subview.subviews {
                    if (textField.isKind(of: UITextField.classForCoder())) {
                        if (textField.isFirstResponder) {
                            textField.resignFirstResponder();
                            return;
                        }
                    }
                }
            }
        }
    }
    

}
