//
//  FuliCatagoryListViewController.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/29.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class FuliCatagoryListViewController: CommonRefreshTableViewController,ServiceDelegate {
    var category : AdvertisementCategory!
    var advertisements = Array<Advertisement>()
    var fuliCatagoryService : FuliCatagoryService!
    var catagoryId : String!
    

    override func viewDidLoad() {
        super.viewDidLoad();
        self.fuliCatagoryService = FuliCatagoryService(delegate: self);
        self.tableView.register(FuliTableViewCell.classForCoder(), forCellReuseIdentifier: "FuliTableViewCell");
        
    
        ViewUtil.showProgressToast();
        self.headerRefresh();
    }
    
    override func headerRefresh() {
        self.fuliCatagoryService.getCatagoryList(catogoryId: self.catagoryId);
    
    }
    
    override func onCompleteSuccess(service: BaseService) {
        ViewUtil.dismissToast();
        if self.fuliCatagoryService.category != nil {
            self.category = self.fuliCatagoryService.category;
            self.title = self.category.name;
        }
        if self.fuliCatagoryService.advertisements != nil {
            self.advertisements = self.fuliCatagoryService.advertisements;
        }
        
        self.loadSuccess();
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FuliTableViewCell")as!FuliTableViewCell;
        let product = self.advertisements[indexPath.row];
        cell.setData(model: product);
        cell.selectionStyle = .none;
        cell.patiButton.addTarget(self, action: #selector(cellButtonAction), for: .touchUpInside);

        return cell;
    }
    
    func cellButtonAction(action:PaticipateButton){
        let model = action.fuliModel;
        if (model?.link != nil){
            LoanRoutes.routeURLString((model?.link)!);
        }else{
            let alertController = UIAlertController(title: "敬请期待", message: nil, preferredStyle: .alert);
            alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
            alertController.show();
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.advertisements.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fuliProduct = self.advertisements[indexPath.row];
        if fuliProduct.link != nil {
            LoanRoutes.routeURLString(fuliProduct.link ?? "");
        }else{
            let alertController = UIAlertController(title: "敬请期待", message: nil, preferredStyle: .alert);
            alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
            alertController.show();
        }
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
