//
//  PushLoanMarketViewController.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/23.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class PushLoanMarketViewController: LoanMarketViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.frame = CGRect(x: 0, y: 54, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - TABBARHEIGHT);

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.firstFilterView.removeFromSuperview();
        self.secondFilterView.removeFromSuperview();
        self.thirdFilterView.removeFromSuperview();
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
