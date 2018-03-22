//
//  LoanTabBarViewController.swift
//  Lottery
//
//  Created by DTY on 17/1/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
import StoreKit

class LoanTabBarViewController: UITabBarController {
    
    var homeViewController = HomeViewController();
    var loanMarketViewController = LoanMarketViewController();
    var fuliTableViewController = FuliTableViewController();
    var mineViewController = LoanMineTableViewController();
        
    override func viewDidLoad() {
        super.viewDidLoad();
        
        UIApplication.shared.setStatusBarHidden(false, with: .slide);
        
        let homeNavigationController = CommonBaseNavigationController(rootViewController: self.homeViewController);
        let LoanMarketNavigationController = CommonBaseNavigationController(rootViewController:self.loanMarketViewController);
        let fuliNavigationController = CommonBaseNavigationController(rootViewController: self.fuliTableViewController);
        let mineNavigationController = CommonBaseNavigationController(rootViewController: self.mineViewController);
        
        homeNavigationController.tabBarItem.title = "首页";
        LoanMarketNavigationController.tabBarItem.title = "贷款超市";
        fuliNavigationController.tabBarItem.title = "福利大全";
        mineNavigationController.tabBarItem.title = "我的";
        
        homeNavigationController.tabBarItem.image = UIImage(named: "icon_home")?.withRenderingMode(.alwaysOriginal);
        homeNavigationController.tabBarItem.selectedImage = UIImage(named: "icon_home_selected")?.withRenderingMode(.alwaysOriginal);
        LoanMarketNavigationController.tabBarItem.image = #imageLiteral(resourceName: "icon_loanmarket").withRenderingMode(.alwaysOriginal);
        LoanMarketNavigationController.tabBarItem.selectedImage = #imageLiteral(resourceName: "icon_loanmarket_selected").withRenderingMode(.alwaysOriginal);
        
        fuliNavigationController.tabBarItem.image = UIImage(named: "icon_notice")?.withRenderingMode(.alwaysOriginal);
        fuliNavigationController.tabBarItem.selectedImage = UIImage(named: "icon_notice_selected")?.withRenderingMode(.alwaysOriginal);
        mineNavigationController.tabBarItem.image = UIImage(named: "icon_mine")?.withRenderingMode(.alwaysOriginal);
        mineNavigationController.tabBarItem.selectedImage = UIImage(named: "icon_mine_selected")?.withRenderingMode(.alwaysOriginal);
        
        let controllers = [homeNavigationController,LoanMarketNavigationController, fuliNavigationController, mineNavigationController];
        self.viewControllers = controllers;
        
        //TabBar
        self.tabBar.tintColor = COLOR_BLUE_NAV;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

}
