//
//  LoanMarketViewController.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/9/21.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
//点击的时候讲categaryId置为nil
class LoanMarketViewController: CommonRefreshTableViewController,ServiceDelegate {
    var filterSwithView : UIView?
    var firstFilterView : MarketFirstWitchView!
    var secondFilterView : MarketSecondFilterView!
    var thirdFilterView : MarketThirdFilterView!
    var firstFilterBtn : MarketSwitchButton!
    var secdFilterBtn : MarketSwitchButton!
    var thirdFilterBtn : MarketSwitchButton!
    var filterInfoService : MarketFilterInfoService!
    var filterListService: MarketFilterListService!
    var filterListLoadMoreService: MarketFilterListLoadMoreService!
    
    var searchContent : String?
    var searchTags : Array<Tags>?
    var repaymentTags: Array<Tags>?
    var loanAmountTags : Array<Tags>?
    var filterTags: Array<Tags>?
    var repaymentContent: String?
    
    
    //初始化参数
    var authorizeTags : String?
    var loanAmount: String?
    var sortCondition: String?
    var repayMethod: String?
    var repayDays: String?
    var categoryId: String?
    
    //list
    var productList: Array<Product>?
    var paginator: Paginator?

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "贷款超市";
        
        
        
       
       
        
        self.tableView.frame = CGRect(x: 0, y: 54, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 44);
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        self.tableView.register(MarketTableViewCell.classForCoder(), forCellReuseIdentifier: "MarketTableViewCell");
        self.tableView.separatorStyle = .none;
        self.hasNoMoreData = false;
        self.tableView.mj_footer.isHidden = false;
        self.firstFilterView = MarketFirstWitchView(choiceArr: [], frame: CGRect(x: 0, y: NAVIHEIGHT + 44, width: SCREEN_WIDTH, height: SCREEN_HEIGHT));
        //综合排序，第一列筛选回调方法
        self.firstFilterView.tapCellActionHanlder = {
            (index) in
            self.firstFilterView.removeFromSuperview();
            self.firstFilterBtn.setSelectedTureOrFalse(selected: false);
            
            guard let tag = self.filterTags?[index!], let tagId = tag.tagsId else {
                return;
            }
            self.firstFilterBtn.setTitle(tag.name ?? "", for: .normal);
            self.sortCondition = String(tagId);
            self.categoryId = nil;
            self.headerRefresh();
            
        }
        self.firstFilterView.tapGesture?.addTarget(self, action: #selector(removeSelfFromWindow));
        
        self.secondFilterView = MarketSecondFilterView(frame: CGRect(x: 0, y: NAVIHEIGHT + 44, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 44 - 64));
        self.secondFilterView.selectedAmountHanlder = {
            (index,title) in
            self.secdFilterBtn?.setTitle(title, for: .normal);
            self.secdFilterBtn?.setSelectedTureOrFalse(selected: false);
            self.secondFilterView.removeFromSuperview();
            guard let tag = self.loanAmountTags?[index], let tagValue = tag.value else {
                return;
            }
            self.loanAmount = String(describing: tagValue);
            self.categoryId = nil;

            self.headerRefresh();
            
        }
        self.secondFilterView.reloadViewBtnTitleHanlder = {
            (btnStr) in
            self.secdFilterBtn.setTitle(btnStr, for: .normal);
        }
        self.setupThirdFilterView();
        self.thirdFilterView.makeSureActionHanlder = {
            (authorizeTags,repayMethod) in
            if authorizeTags != nil && authorizeTags != "" {
                self.authorizeTags = authorizeTags;
            }else{
                self.authorizeTags = nil;
            }
            if repayMethod != nil && repayMethod != "" {
                self.repayMethod = repayMethod;
            }else{
                self.repayMethod = nil;
            }
            self.thirdFilterView.removeFromSuperview();
            self.thirdFilterBtn.setSelectedTureOrFalse(selected: false);
            self.categoryId = nil;
            self.headerRefresh();
        }
        self.thirdFilterView.reloadViewHanlder = {
            (btnStr) in
            self.thirdFilterBtn.setTitle(btnStr, for: .normal);
        }
        
        self.setUpFilterSwitchView();
        
        self.filterInfoService = MarketFilterInfoService(delegate: self);
        self.filterListService = MarketFilterListService(delegate: self);
        self.filterListLoadMoreService = MarketFilterListLoadMoreService(delegate: self);
        self.headerRefresh();
        

        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if let tabBarTitle = UserDefaults.standard.object(forKey: "tabBarTitle") {
            let nav = self.tabBarController?.viewControllers![1] as! CommonBaseNavigationController;
            nav.tabBarItem.title = tabBarTitle as? String;
            self.title = nav.tabBarItem.title;
            
        }
    }
    
    func setupThirdFilterView(){
        self.thirdFilterView = MarketThirdFilterView(conditionArr: self.searchTags ?? [], repaymentArr: self.repaymentTags ?? [],conditonTitle: self.searchContent ?? "",repaymentTitle: self.repaymentContent ?? "", frame: CGRect(x: 0, y: NAVIHEIGHT + 44, width: SCREEN_WIDTH, height: SCREEN_HEIGHT));
        
        self.thirdFilterView.tapGesture?.addTarget(self, action: #selector(removeSelfFromWindow));
        
    }
    
    
    
    override func onCompleteSuccess(service: BaseService) {
        if service == self.filterInfoService {
            if self.filterInfoService.filterTags != nil {
                self.filterTags = self.filterInfoService.filterTags;
                self.firstFilterView.reloadFilterTableViewWithData(arr: self.filterTags!);
                
            }
            
            if self.filterInfoService.loanAmountTags != nil {
                self.loanAmountTags = self.filterInfoService.loanAmountTags;
                self.secondFilterView.reloadPickerViewWithArr(arr: self.loanAmountTags!);
            }
            
            self.searchContent = self.filterInfoService.searchContent ?? "";
            self.repaymentContent = self.filterInfoService.repaymentContent ?? "";
            
            if self.filterInfoService.searchTags != nil && self.filterInfoService.repaymentTags != nil {
                self.searchTags = self.filterInfoService.searchTags;
                self.repaymentTags = self.filterInfoService.repaymentTags;
                self.thirdFilterView.reloadViewWithData(conditionArr: self.searchTags ?? [], repaymentArr: self.repaymentTags ?? [], conditonTitle: self.searchContent ?? "", repaymentTitle: self.repaymentContent ?? "")
            }
            
            
        }else if service == self.filterListService {
            ViewUtil.dismissToast();
            if self.filterListService.paginator != nil {
                self.paginator = self.filterListService.paginator;
            }
            if self.filterListService.productList != nil {
                self.productList = self.filterListService.productList;
                self.tableView.reloadData();
            }
        }else if service == self.filterListLoadMoreService {
            ViewUtil.dismissToast();
            if self.filterListLoadMoreService.productList != nil {
                self.productList?.append(contentsOf: self.filterListLoadMoreService.productList!);
                self.tableView.reloadData();
            }
            if self.paginator != nil {
                self.paginator = self.filterListLoadMoreService.paginator;
            }
        }
        self.loadComplete(isSuccess: true);

        
    }
    
    override func headerRefresh() {
        self.filterInfoService.getFilterConditionInfo(authorizeTags: self.authorizeTags, loanAmount: self.loanAmount, sortCondition: self.sortCondition, repayMethod: self.repayMethod, repayDays: self.repayDays,categoryId: self.categoryId);
        self.filterListService.getMarketFilterList(authorizeTags: self.authorizeTags, loanAmount: self.loanAmount, sortCondition: self.sortCondition, repayMethod: self.repayMethod, repayDays: self.repayDays, categoryId: self.categoryId);
    }
    
    override func footerRefresh() {
        if self.paginator?.hasNextPage == false {
            ViewUtil.showToast(text: "没有更多数据");
            self.tableView.mj_footer.endRefreshing();
            return;
        }
        self.filterListLoadMoreService.getMarketFilterListLoadMore(authorizeTags: self.authorizeTags, loanAmount: self.loanAmount, sortCondition: self.sortCondition, repayMethod: self.repayMethod, repayDays: self.repayDays, categoryId: self.categoryId, nextPage: self.paginator?.nextPage, limit: self.paginator?.limit);
    }
    
    func setUpFilterSwitchView(){
        self.filterSwithView = UIView(frame: CGRect(x: 0, y: NAVIHEIGHT, width: SCREEN_WIDTH, height: 54));
        let colorView = UIView(frame: CGRect(x: 0, y: 44, width: SCREEN_WIDTH, height: 10));
        colorView.backgroundColor = COLOR_GROUND;
        let lineView = UIView(frame: CGRect(x: 0, y: 44 - 0.5, width: SCREEN_WIDTH, height: 0.5));
        lineView.backgroundColor = COLOR_BORDER;
        //self.filterSwithView?.addSubview(lineView);
        self.filterSwithView?.addSubview(colorView);
        self.filterSwithView?.backgroundColor = COLOR_WHITE;
        self.view.addSubview(self.filterSwithView!);
        self.firstFilterBtn = MarketSwitchButton(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH/3, height: 44));
        self.firstFilterBtn.setTitle("综合排序", for: .normal);
        self.firstFilterBtn.setSelectedTureOrFalse(selected: false);
        self.filterSwithView?.addSubview(self.firstFilterBtn);
        self.firstFilterBtn.addTarget(self, action: #selector(showAndHiddenConditionView), for: .touchUpInside);
        self.firstFilterBtn.tag = 10001;

        
        self.secdFilterBtn = MarketSwitchButton(frame: CGRect(x: SCREEN_WIDTH/3, y: 0, width: SCREEN_WIDTH/3, height: 44));
        self.secdFilterBtn.setTitle("金额不限", for: .normal);
        self.secdFilterBtn.setSelectedTureOrFalse(selected: false);
        self.filterSwithView?.addSubview(self.secdFilterBtn);
        self.secdFilterBtn.addTarget(self, action: #selector(showAndHiddenConditionView), for: .touchUpInside);
        self.secdFilterBtn.tag = 10002;
        self.secondFilterView.transformBtn = self.secdFilterBtn;

        
        self.thirdFilterBtn = MarketFilterSwitchButton(frame: CGRect(x: SCREEN_WIDTH/3 * 2, y: 0, width: SCREEN_WIDTH/3, height: 44));
        self.thirdFilterBtn.setTitle("条件筛选", for: .normal);
        self.thirdFilterBtn.setSelectedTureOrFalse(selected: false);
        self.thirdFilterBtn.addTarget(self, action: #selector(showAndHiddenConditionView), for: .touchUpInside);

        self.filterSwithView?.addSubview(self.thirdFilterBtn);
        self.thirdFilterBtn.tag = 10003;

        
    }
    
    func removeSelfFromWindow(tapGesture: UITapGestureRecognizer){
        let view = tapGesture.view;
        if view?.superview == self.firstFilterView {
            self.firstFilterBtn.setSelectedTureOrFalse(selected: false);
        }else{
            self.thirdFilterBtn.setSelectedTureOrFalse(selected: false);

        }
        view?.superview?.removeFromSuperview();
    }
    
    func showAndHiddenConditionView(button : UIButton) -> (){
        let button = button as! MarketSwitchButton;
        button.setSelectedTureOrFalse(selected: !button.isSelected);

        if button.tag == 10001 {
            self.secondFilterView.removeFromSuperview();
            self.secdFilterBtn.setSelectedTureOrFalse(selected: false);
            self.thirdFilterView.removeFromSuperview();
            self.thirdFilterBtn.setSelectedTureOrFalse(selected: false);
            if button.isSelected == true {
                UIApplication.shared.keyWindow?.addSubview(self.firstFilterView);
                
            }else{
                self.firstFilterView.removeFromSuperview();
            }
            
        }else if button.tag == 10002{
            self.thirdFilterView.removeFromSuperview();
            self.thirdFilterBtn.setSelectedTureOrFalse(selected: false);
            self.firstFilterView.removeFromSuperview();
            self.firstFilterBtn.setSelectedTureOrFalse(selected: false);
            if button.isSelected == true {
                UIApplication.shared.keyWindow?.addSubview(self.secondFilterView);
                
                
            }else{
                self.secondFilterView.removeFromSuperview();
            }
        }else{
            self.firstFilterView.removeFromSuperview();
            self.firstFilterBtn.setSelectedTureOrFalse(selected: false);
            self.secondFilterView.removeFromSuperview();
            self.secdFilterBtn.setSelectedTureOrFalse(selected: false);
            if button.isSelected == true {
                UIApplication.shared.keyWindow?.addSubview(self.thirdFilterView);
            }else{
                self.thirdFilterView.removeFromSuperview();
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketTableViewCell") as! MarketTableViewCell;
        //cell?.textLabel?.text = "test";
        let product = self.productList?[indexPath.row];
        cell.linkTapGesture?.addTarget(self, action: #selector(pushToWebViewController));
        cell.setData(product: product!);
        return cell;
    }
    
    func pushToWebViewController(action:UITapGestureRecognizer){
        let cell = (action.view as! UIImageView).superview?.superview as! HomeTableViewCell;
        guard let urlStr = cell.product?.strategyLink  else {
            return;
        }
        let webVC = CommonWebViewController();
        webVC.urlContent = urlStr;
        self.pushViewController(viewController: webVC);
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.productList == nil {
            return 0;
        }
        return (self.productList?.count)!;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.productList?[indexPath.row];
        let vc = LoanDetailViewController();
        vc.hidesBottomBarWhenPushed = true;
        vc.product = product;
        vc.productId = product?.productId;
        AppContext().sendProductStatis(productId: product?.productId);
        
        self.navigationController?.pushViewController(vc, animated: true);
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
