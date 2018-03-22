//
//  MyLoanListViewController.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MyLoanListViewController: CommonRefreshTableViewController,ServiceDelegate {
    var paginator = Paginator();
    var applyList = Array<Apply>();
    var applyService : LoanApplyListService!
    var applyLoadMoreService : LoanApplyListLoadMoreService!
    var product : Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的贷款";
        self.applyService = LoanApplyListService(delegate: self);
        self.applyLoadMoreService = LoanApplyListLoadMoreService(delegate : self);
        self.tableView.register(MyLoanTableListCell.classForCoder(), forCellReuseIdentifier: "MyLoanTableListCell");
        
        self.tableView.mj_footer.isHidden = false;
        self.hasNoMoreData = false
        
        ViewUtil.showProgressToast();
        self.headerRefresh();

    }
    
    
    
    
    
    override func headerRefresh() {
        
        self.applyService.getApplyList(token: LotteryUtil.token()!, productId:nil,merchantId: nil);
    }
    
    override func footerRefresh() {
        if self.paginator.hasNextPage == false {
            ViewUtil.showToast(text: "没有更多数据");
            self.tableView.mj_footer.endRefreshing();
            return;
        }
        self.applyLoadMoreService.getApplyList(token: LotteryUtil.token(), productId: nil, merchantId: nil, limit: self.paginator.limit, page: self.paginator.nextPage);
    }
    
    override func onCompleteSuccess(service: BaseService) {
        ViewUtil.dismissToast();
        if service.isKind(of: LoanApplyListService.classForCoder()){
            if self.applyService.applyList != nil {
                self.applyList = self.applyService.applyList;
               
            }
            if self.applyService.paginator != nil {
                self.paginator = self.applyService.paginator;
            }
            self.tableView.reloadData();
            self.loadSuccess();
        }else if service.isKind(of: LoanApplyListLoadMoreService.classForCoder()){
            if self.applyLoadMoreService.applyList != nil {
                self.applyList.append(contentsOf: self.applyLoadMoreService.applyList);
            }
            if self.applyLoadMoreService.paginator != nil {
                self.paginator = self.applyService.paginator;
            }
            self.tableView.reloadData();
            self.loadSuccess();
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.applyList[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyLoanTableListCell")as!MyLoanTableListCell;
        cell.setData(model: model);
        cell.selectionStyle = .none;
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.applyList.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        let model = self.applyList[indexPath.row];
        let vc = LoanDetailViewController();
        vc.productId = model.productId;
        AppContext().sendProductStatis(productId: model.productId);
        
        self.navigationController?.pushViewController(vc, animated: true);
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
