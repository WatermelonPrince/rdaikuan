//
//  BaseViewController.swift
//  Lottery
//
//  Created by DTY on 17/1/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //Background
        self.view.backgroundColor = COLOR_GROUND;
        
        let backItem = UIBarButtonItem();
        backItem.title = " ";
        self.navigationItem.backBarButtonItem = backItem;
        self.navigationController?.navigationBar.alpha = 1;

//                self.navigationController?.navigationBar.isTranslucent = false;
//                self.edgesForExtendedLayout = UIRectEdge(rawValue: 0);
        // 设置导航栏颜色
        navBarBarTintColor = COLOR_BLUE_NAV!;
        
        // 设置初始导航栏透明度
        navBarBackgroundAlpha = 1;
        
        // 设置导航栏按钮和标题颜色
        navBarTintColor = .white;
        
        // 如果需要隐藏导航栏底部分割线，设置 hideShadowImage 为true
        // hideShadowImage = true

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pushViewController(viewController: UIViewController) {
        viewController.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(viewController, animated: true);
    }
    
}
