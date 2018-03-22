//
//  LoanMineTableViewController.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/28.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanMineTableViewController: CommonRefreshTableViewController,ServiceDelegate {
    var userService : UserService!
    static let userStatusChangeNotificationName = "UserStatusChange";


    override func viewDidLoad() {
        super.viewDidLoad()
//        let nav = self.tabBarController?.viewControllers![1] as! CommonBaseNavigationController;
//        nav.tabBarItem.title = "哈哈哈";
        self.tableView.register(LoanMineUserInfoCell.classForCoder(), forCellReuseIdentifier: "LoanMineUserInfoCell");
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        

        self.tableView.backgroundColor = COLOR_GROUND;
        self.tableView.tableFooterView = UIView();
        self.userService = UserService(delegate: self);
        //Observer
        NotificationCenter.default.addObserver(self, selector: #selector(beginRefreshing), name: NSNotification.Name(rawValue:LoanMineTableViewController.userStatusChangeNotificationName), object: nil);
        self.beginRefreshing();
        self.tableView.mj_footer.isHidden = true;
        self.hasNoMoreData = true;
        self.title = "我的";
               
       
        
    }
    
    
    
    override func headerRefresh() {
        if LotteryUtil.isLogin() == false {
            self.tableView.mj_header.endRefreshing();
            self.tableView.reloadData();
            LotteryUtil.shouldLogin();
            return;
        }
        self.userService.getUser();
    }
    
    override func onCompleteSuccess(service: BaseService) {
        self.loadSuccess();
        self.tableView.reloadData();
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoanMineUserInfoCell")as!LoanMineUserInfoCell;
            
            cell.phoneLabel.text = LotteryUtil.isLogin() ? LotteryUtil.user()?.name : "请点击登录";
            cell.userImage.sd_setImage(with: CommonUtil.getURL(LotteryUtil.user()?.avatar ?? ""), placeholderImage: #imageLiteral(resourceName: "icon_avatar"));
            cell.selectionStyle = .none;
            return cell;
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!;
            if indexPath.section == 1 {
                if indexPath.row == 0 {
                    cell.imageView?.image = UIImage(named: "icon_mineloan");
                    cell.textLabel?.textColor = COLOR_FONT_HEAD;
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 15);
                    cell.textLabel?.text = "我的借贷";
                    cell.accessoryType = .disclosureIndicator
                    
                }/*else if indexPath.row == 1{
                    cell.imageView?.image = UIImage(named: "icon_feedback_1");
                    cell.textLabel?.textColor = COLOR_FONT_HEAD;
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 15);
                    cell.textLabel?.text = "用户反馈";
                    cell.accessoryType = .disclosureIndicator;
                }*/else if indexPath.row == 1{
                    if LotteryUtil.isLogin(){
                        cell.imageView?.image = #imageLiteral(resourceName: "icon_changepw");
                        cell.textLabel?.textColor = COLOR_FONT_HEAD;
                        cell.textLabel?.font = UIFont.systemFont(ofSize: 15);
                        cell.textLabel?.text = "修改密码";
                        cell.accessoryType = .disclosureIndicator;
                    }else{
                        cell.imageView?.image = UIImage(named: "icon_aboutus");
                        cell.textLabel?.textColor = COLOR_FONT_HEAD;
                        cell.textLabel?.font = UIFont.systemFont(ofSize: 15);
                        cell.textLabel?.text = "设置";
                        cell.accessoryType = .disclosureIndicator;
                    }
                    
                    
                }else{
                    cell.imageView?.image = #imageLiteral(resourceName: "icon_minesetting");
                    cell.textLabel?.textColor = COLOR_FONT_HEAD;
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 15);
                    cell.textLabel?.text = "设置";
                    cell.accessoryType = .disclosureIndicator;
                    
                }
            }else{
                cell.textLabel?.font = UIFont.systemFont(ofSize: 15);
                cell.textLabel?.textAlignment = .center;
                cell.textLabel?.textColor = COLOR_FONT_HEAD;
                cell.textLabel?.text = "退出登录";
            }
            cell.selectionStyle = .none;
            
            return cell;
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if LotteryUtil.isLogin() {
            return 3;
        }else{
            return 2;
        }
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1;
        }else if section == 1{
            if LotteryUtil.isLogin() {
                return 3;
            }else{
                return 2;
            }
            
        }else{
            return 1;
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 15));
        view.backgroundColor = COLOR_GROUND;
        let topLine = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: DIMEN_BORDER));
        topLine.backgroundColor = COLOR_BORDER;
        let lineview = UIView(frame: CGRect(x: 0, y: 15 - DIMEN_BORDER, width: SCREEN_WIDTH, height: DIMEN_BORDER));
        lineview.backgroundColor = COLOR_BORDER;
        view.addSubview(topLine);
        view.addSubview(lineview);
        return view;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 82;
        }else{
            return 44;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0;
        }
        return 15;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if LotteryUtil.isLogin() == false {
                LotteryUtil.shouldLogin();
                return;
            }
            let userInfoVC = UserInfoResetViewController();
            self.pushViewController(viewController: userInfoVC);
            
        }
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                if LotteryUtil.isLogin() == false {
                    ViewUtil.dismissToast();
                    self.tableView.mj_header.endRefreshing();
                    LotteryUtil.shouldLogin();
                    return;
                }
                let vc = MyLoanListViewController();
                self.pushViewController(viewController: vc);
           
            case 1:
                if LotteryUtil.isLogin(){
                    let vc = ChangePasswordViewController();
                    self.pushViewController(viewController: vc);
                }else{
//                    LoanRoutes.routeURLString(HTTPConstants.ABOUT);
                    let vc = SettingsViewController();
                    self.pushViewController(viewController: vc);

                }
               
            case 2:
                let vc = SettingsViewController();
                self.pushViewController(viewController: vc);
            default:
                ();
            }
        }
        
        if indexPath.section == 2 {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet);
            alertController.addAction(UIAlertAction(title: "退出登录", style: .destructive, handler: { (action) in
                GeTuiSdk.unbindAlias(LotteryUtil.user()?.bindAlias, andSequenceNum: LotteryUtil.user()?.bindAlias);
                LotteryUtil.clearLoginSession();
                tableView.reloadData();
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: LoanMineTableViewController.userStatusChangeNotificationName)));
                
            }));
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil));
            alertController.show();
        }
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
