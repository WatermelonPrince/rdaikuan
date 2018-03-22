//
//  SettingsViewController.swift
//  Lottery
//
//  Created by DTY on 17/3/31.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class SettingsViewController: CommonBaseTableViewController {
    var shakeSwitch: UISwitch!;

    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "设置";
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0);

        //ShakeSwitch
        self.shakeSwitch = UISwitch();
        
        self.shakeSwitch.addTarget(self, action: #selector(shakeSwitchAction), for: .valueChanged);
        
        //Observer
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name(rawValue: LoanMineTableViewController.userStatusChangeNotificationName), object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(enterForgroundReload), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil);
    }
    
    
    func enterForgroundReload(){
        self.tableView.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    func reloadTableView() {
        self.tableView.reloadData();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1;
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        return 4;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingsTableViewCell();
        
        var indexPath = indexPath;
        if (tableView.numberOfSections == 3 || tableView.numberOfSections == 4) {
            indexPath.section = indexPath.section + 1;
        }
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.selectionStyle = .none;
                cell.textLabel?.text = "接受消息推送";
                cell.accessoryView = self.shakeSwitch;
                self.checkNotificationStatus();
                
            }else if(indexPath.row == 1) {
                cell.textLabel?.text = "用户反馈";
                cell.accessoryType = .disclosureIndicator;
            }else if (indexPath.row == 2) {
                let cell = SettingsTableViewCell(style: .value1, reuseIdentifier: nil);
                cell.textLabel?.text = "清理缓存";
                var tempSize = Double(SDImageCache.shared().getSize())/Double(1024*1024);
                tempSize = tempSize + Double(XHLaunchAd.diskCacheSize());
                cell.detailTextLabel?.text = CommonUtil.formatDoubleString(double: tempSize) + "M";
                cell.accessoryType = .disclosureIndicator;
                cell.textLabel?.textColor = COLOR_FONT_HEAD;

                return cell;

            }else{
                cell.textLabel?.text = "关于瑞贷";
                cell.accessoryType = .disclosureIndicator;
            }
        }
        cell.textLabel?.textColor = COLOR_FONT_HEAD;

        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        

        if indexPath.row == 1 {
            let vc = FeedbackViewController();
            self.pushViewController(viewController: vc);
        }else if(indexPath.row == 2){
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet);
            alertController.addAction(UIAlertAction(title: "清理缓存", style: .destructive, handler: { (action) in
                ViewUtil.showProgressToast(text: "正在清理");
                XHLaunchAd.clearDiskCache();
                SDImageCache.shared().clearMemory();
                SDImageCache.shared().clearDisk(onCompletion: {
                    ViewUtil.dismissToast();
                    tableView.reloadData();
                })
            }));
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil));
            alertController.show();

        }else if(indexPath.row == 3){
            LoanRoutes.routeURLString(HTTPConstants.ABOUT);

            
        }
    }
    
    func shakeSwitchAction() {
        if self.shakeSwitch.isOn == true {
            if UIApplication.shared.currentUserNotificationSettings?.types.rawValue == 0 {
                let alert = UIAlertController(title: nil, message: "请在设置中打开通知权限", preferredStyle: .alert)
                
                let tempAction = UIAlertAction(title: "确定", style: .cancel) { (action) in
                    UIApplication.shared.openURL(URL(string: "App-Prefs:root=NOTIFICATIONS_ID")!);
                }
                alert.addAction(tempAction)
                self.present(alert, animated: true, completion: nil)
            }
            GeTuiSdk.setPushModeForOff(false);
            UserDefaults.standard.set(true, forKey: NOTICE_STATE);
            UserDefaults.standard.synchronize()

            
        }else{
            GeTuiSdk.setPushModeForOff(true);
            UserDefaults.standard.set(false, forKey: NOTICE_STATE);
            UserDefaults.standard.synchronize()

        }
    }
    
    func checkNotificationStatus(){
        let state = UserDefaults.standard.bool(forKey: NOTICE_STATE);
        if (UIDevice.current.systemVersion as NSString).floatValue >= 8.0 {
            let setting = UIApplication.shared.currentUserNotificationSettings;
            if setting?.types.rawValue != 0 && state == true {
                self.shakeSwitch.isOn = true;
            }else{
                self.shakeSwitch.isOn = false;
            }
        }
    }
    
}
