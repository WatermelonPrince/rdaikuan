//
//  CommonBaseNavigationController.swift
//  Lottery
//
//  Created by DTY on 17/2/4.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class CommonBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //NavigationBar
        self.navigationBar.barTintColor = COLOR_BLUE_NAV;
        self.navigationBar.tintColor = COLOR_WHITE;
        let navigationTitleAttr = [NSForegroundColorAttributeName:COLOR_WHITE];
        self.navigationBar.titleTextAttributes = navigationTitleAttr;

//        self.navigationBar.isTranslucent = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
    

}
