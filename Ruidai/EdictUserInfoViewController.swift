//
//  EdictUserInfoViewController.swift
//  Loan
//
//  Created by zhaohuan on 2017/9/13.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class EdictUserInfoViewController: BaseViewController,UITextFieldDelegate,ServiceDelegate{
    var edictView : EditUserInfoTextFieldView!
    var rightItem : UIBarButtonItem!
    var userService : UserService!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改昵称";
        self.edictView = EditUserInfoTextFieldView(frame: CGRect(x: 0, y: NAVIHEIGHT, width: SCREEN_WIDTH, height: 50));
        self.edictView.backgroundColor = COLOR_WHITE;
        self.edictView.textField.placeholder = "请填写昵称";
        self.view.backgroundColor = COLOR_GROUND;
        self.view.addSubview(self.edictView);
        self.rightItem = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(saveChangeAction));
        self.navigationItem.rightBarButtonItem = self.rightItem;
        self.userService = UserService(delegate: self);

        // Do any additional setup after loading the view.
    }
    
    func onCompleteSuccess(service: BaseService) {
        ViewUtil.showToast(text: "修改成功");
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: LoanMineTableViewController.userStatusChangeNotificationName), object: self, userInfo: nil));
        self.navigationController?.popViewController(animated: true);
        

    }
    
    func saveChangeAction(){

        guard let str = self.edictView.textField.text else {
            return;
        }
        self.view.endEditing(true);

        if (str as NSString).length == 0 {
            ViewUtil.showToast(text: "昵称不能为空");
            return;
        }
        
        self.userService.commitInfo(name: str);

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
