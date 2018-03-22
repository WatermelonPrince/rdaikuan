//
//  LoanIMViewController.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/11/14.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanIMViewController: CommonRefreshTableViewController,LXChatBoxDelegate {
    var productId : String?

   
    
    
    var chatBox : LXChatBox?
    var array = Array<NSAttributedString>();
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.chatBox?.isDisappear = true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.chatBox?.isDisappear = false;
        self.chatBox?.status = .nothing;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        if self.array.count > 0 {
            let indexpath = NSIndexPath.init(row: (self.array.count) - 1, section: 0);
            self.tableView.scrollToRow(at: indexpath as IndexPath, at: .bottom, animated: false);
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = COLOR_WHITE;
        self.tableView.backgroundColor = COLOR_WHITE;
        self.title = "客服咨询";
        self.tableView.separatorStyle = .none;
        self.tableView.register(IMListTableViewCell.classForCoder(), forCellReuseIdentifier: "IMCell");
        self.tableView.mj_footer.isHidden = true;
        self.tableView.mj_header.isHidden = true;
        self.hasNoMoreData = true;
        self.chatBox = LXChatBox.init(frame: CGRect(x: 0, y: SCREEN_HEIGHT - TABBARHEIGHT, width: SCREEN_WIDTH, height: 49));
        self.chatBox?.maxVisibleLine = 2;
        self.chatBox?.delegate = self;

        self.view.addSubview(self.chatBox!);
        if #available(iOS 11.0, *) {
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }else{
            self.tableView.contentInset = UIEdgeInsetsMake(-NAVIHEIGHT, 0, 0, 0);
        }
        

        guard self.productId != nil else {
            return;
        }
        let path = "imhistorylist_\(String(describing: self.productId))".cacheDir();
        guard let arr = NSKeyedUnarchiver.unarchiveObject(withFile: path) else {
            return;
        }
        self.array = arr as!Array<NSAttributedString>;
        
        

        
        
        self.tableView.reloadData();
        
        

        // Do any additional setup after loading the view.
    }
    
    override func footerRefresh() {
        self.tableView.mj_footer.endRefreshing();
    }
    
    func changeStatusChat(_ chatBoxY: CGFloat) {
        self.tableView.frame = CGRect(x: 0, y: NAVIHEIGHT, width: SCREEN_WIDTH, height: chatBoxY  - NAVIHEIGHT);
        if self.array.count > 0 {
            let indexpath = NSIndexPath.init(row: (self.array.count) - 1, section: 0);
            self.tableView.scrollToRow(at: indexpath as IndexPath, at: .bottom, animated: false);
        }
       
        

    }
    
    func chatBoxSendTextMessage(_ message: String!) {
        let attribute = LXEmotionManager.transferMessageString(message, font: UIFont.systemFont(ofSize: 14), lineHeight: UIFont.systemFont(ofSize: 14).lineHeight);
        guard let atttex = attribute else {
            return;
        }
        
        self.array.append(atttex);
        self.tableView.reloadData();
        if self.array.count > 0 {
            let indexpath = NSIndexPath.init(row: (self.array.count) - 1, section: 0);
            self.tableView.scrollToRow(at: indexpath as IndexPath, at: .bottom, animated: false);
        }
        guard self.productId != nil else {
            return;
        }
        let path = "imhistorylist_\(String(describing: self.productId))".cacheDir();
        NSKeyedArchiver.archiveRootObject(self.array, toFile: path);
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if self.chatBox?.status !=  .nothing{
            self.chatBox?.status = .nothing;
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count ;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cell = self.tableView(tableView, cellForRowAt: indexPath) as! IMListTableViewCell
//        return 100;
        let cell = self.tableView(tableView, cellForRowAt: indexPath)as! IMListTableViewCell;
        return cell.height();
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IMCell")as! IMListTableViewCell;
        let str = self.array[indexPath.row];
        cell.reloadCell(string: str);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false);
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
