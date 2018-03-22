//
//  LoanDetailViewController.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/25.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanDetailViewController: CommonRefreshTableViewController,ServiceDelegate,WKNavigationDelegate{
    var userHeaderView : LoanDetailUserView!
    var userFilterView : LoanDetailFilterView!
    var loanReviewInfoView : LoanReviewInfoView!
    var tableHeaderView : UIView!
    var loanApplicationView : LoanApplicationView!
    var loanApplyCouponView: LoanApplicationView!
    var product : Product!
    var monthRate : String?
    var dayRate : String?
    var tableViewArr = Array<ProductDetailComponent>();
    var applyCommitService : LoanApplyCommitService!
    var productDetailService : ProductService!
    var reviewListService: UserReviewService!
    var reviewListLoadMoreService: UserReviewLoadMoreService!
    var paginitor: Paginator?
    var productId : String?
    var loanDetailSwithView: LoanDetailSwitchView?
    var loanDetailSwithBgView: UIView?
    var commenList = Array<CommentVo>();
    var webView: WKWebView?
    var webViewFirstLoad = true;
    var webCellScrollView: UIScrollView?;
    var webHeight:CGFloat = 0;
    var couponInfoView: LoanCouponInfoView?;
    
    
  
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.userFilterView = LoanDetailFilterView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 172 + NAVIHEIGHT - 27));
        
        self.userFilterView.pickersuperView = self.view;
        
        
        self.loanDetailSwithBgView = UIView(frame: CGRect(x: 0, y: self.userFilterView.bottom(), width: SCREEN_WIDTH, height: 55));
        self.configureLoanSwitchView();

        
        
        self.userHeaderView = LoanDetailUserView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 105.5));
        self.loanReviewInfoView = LoanReviewInfoView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 117));

        
        if self.product != nil {
            self.title = self.product.productName ?? "";
//            self.userHeaderView.reloadArr(conditionArr: self.product.authorizeTagsList ?? [], descArr: self.product.featureTagsList ?? [], imageUrl: product.productLogo ?? "", title: product.productName ?? "");
//            self.userFilterView.reloadViewWithParameter(product: self.product);
//            self.reduceProductForTableData(product: self.product);
//            self.loanReviewInfoView.reloadLoanInfo(favaRate: 95, rateFavaLevel: 4, loanFavaLevel: 4, processFavaLevel: 3);
        }
        
        self.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: (self.loanDetailSwithBgView?.bottom())!));
//        self.tableHeaderView.addSubview(self.userHeaderView);
        self.tableHeaderView.addSubview(self.userFilterView);
        self.tableHeaderView.addSubview(self.loanDetailSwithBgView!);
        self.tableView.tableHeaderView = self.tableHeaderView;
        self.tableView.mj_header.isHidden = false;
        self.tableView.mj_footer.isHidden = true;
        self.hasNoMoreData = true;
        self.tableView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 50 - FOOTERSAFEHEIGHT);
        if #available(iOS 11.0, *) {
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }else{
            self.tableView.contentInset = UIEdgeInsetsMake(-NAVIHEIGHT, 0, 0, 0);
        }
        self.loanApplicationView = LoanApplicationView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 50 - FOOTERSAFEHEIGHT, width: SCREEN_WIDTH, height: 56));
        self.loanApplicationView.applicationBtn.addTarget(self, action: #selector(applyCommit), for: .touchUpInside);
        self.loanApplicationView.commentsBtn.addTarget(self, action: #selector(modalToCommentsViewController), for: .touchUpInside);
        
        self.view.addSubview(self.loanApplicationView);
        
        self.loanApplyCouponView = LoanApplicationView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 50 - FOOTERSAFEHEIGHT, width: SCREEN_WIDTH, height: 56));
        self.loanApplyCouponView.commentsBtn.setImage(#imageLiteral(resourceName: "im_contact"), for: .normal);
        self.loanApplyCouponView.commentsBtn.setTitle("机构客服", for: .normal);
        self.loanApplyCouponView.applicationBtn.setTitle("领取免息券", for: .normal);
        self.loanApplyCouponView.applicationBtn.addTarget(self, action: #selector(applyCouponAction), for: .touchUpInside);
        self.loanApplyCouponView.commentsBtn.addTarget(self, action: #selector(pushToIMVC), for: .touchUpInside);
        self.view.addSubview(self.loanApplyCouponView);

        
        
        
        
        self.tableView.register(LoanProcessCell.classForCoder(), forCellReuseIdentifier: "LoanProcessCell");
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        self.tableView.register(LoanDetailsTableViewCell.classForCoder(), forCellReuseIdentifier: "LoanDetailsTableViewCell");
        self.tableView.register(LoanReviewCell.classForCoder(), forCellReuseIdentifier: "LoanReviewCell");
        
        self.setUpWebView();

       
        
        self.applyCommitService = LoanApplyCommitService(delegate:self);
        self.productDetailService = ProductService(delegate:self);
        self.reviewListService = UserReviewService(delegate: self);
        self.reviewListLoadMoreService = UserReviewLoadMoreService(delegate: self);
        
        //添加swipe手势
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipAciton));
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left;
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipAction));
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right;
        
        self.tableView.addGestureRecognizer(leftSwipe);
        self.tableView.addGestureRecognizer(rightSwipe);
        

        ViewUtil.showProgressToast();
        self.productDetailService.applyProductDetail(productId: self.productId);


        

    }
    
   
    
    func leftSwipAciton(){
        if self.loanDetailSwithView?.firstBtn?.isSelected == true {
            self.switchCommentListView();
        }else if self.loanDetailSwithView?.secondBtn?.isSelected == true {
            if self.product.strategyLink != nil && self.product.strategyLink != ""{
                self.switchWebView();
            }
        }
    }
    
    func rightSwipAction(){
        if self.loanDetailSwithView?.secondBtn?.isSelected == true {
            self.switchProductDetail();
        }else if self.loanDetailSwithView?.thirdBtn?.isSelected == true {
            self.switchCommentListView();
        }
        
    }
    
    func setUpWebView(){
        
        self.webView = WKWebView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - self.tableHeaderView.height() - 55));
        self.webView?.navigationDelegate = self;
        self.webView?.scrollView.isScrollEnabled = false;
        self.webView?.scrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil);
        self.webCellScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 1));
        self.webCellScrollView?.addSubview(self.webView!);
        if self.product != nil && self.product.strategyLink != nil && self.product.strategyLink != "" {
            
            let requst = URLRequest(url: CommonUtil.getURL(self.product.strategyLink)!);
//            let requst = URLRequest(url: CommonUtil.getURL("http://192.168.1.130:8000/loan.html#/m/strategy/detail?strategyId=162")!);

            self.webView?.load(requst);
        }
       
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            let scrollView = object as! UIScrollView;
            let height = scrollView.contentSize.height;
            if self.webHeight != height{
                self.webHeight = height;
                self.reloadWebHeight();
            }
            
            
        }
    }
    deinit {
        self.webView?.scrollView.removeObserver(self, forKeyPath: "contentSize");
    }
    
    func configureLoanSwitchView(){
        for view in (self.loanDetailSwithBgView?.subviews)! {
            view.removeFromSuperview();
        }
        if self.product != nil && self.product.strategyLink != nil && self.product.strategyLink != "" {
              self.loanDetailSwithView = LoanDetailSwitchView.init(arrStr: ["贷款详情","用户评价","贷款攻略"], count: 3, frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 55));
        }else{
            self.loanDetailSwithView = LoanDetailSwitchView.init(arrStr: ["贷款详情","用户评价"], count: 2, frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 55));
        }
      
        self.loanDetailSwithView?.firstBtn?.addTarget(self, action: #selector(switchProductDetail), for: .touchUpInside);
        self.loanDetailSwithView?.secondBtn?.addTarget(self, action: #selector(switchCommentListView), for: .touchUpInside);
        self.loanDetailSwithView?.thirdBtn?.addTarget(self, action: #selector(switchWebView), for: .touchUpInside);
        
        self.loanDetailSwithBgView?.addSubview(self.loanDetailSwithView!);

        

    }
    
    override func headerRefresh() {
        if self.loanDetailSwithView?.firstBtn?.isSelected == true {
            self.productDetailService.applyProductDetail(productId: self.productId);
        }else{
            self.reviewListService.getCommanList(productId: self.productId);
        }
    }
    
    func switchProductDetail(){
        self.productDetailService.applyProductDetail(productId: self.productId);
    }
    
    func switchCommentListView(){
        self.reviewListService.getCommanList(productId: self.productId);
    }
    
    func switchWebView(){
        self.tableView.mj_footer.isHidden = true;
        self.tableView.mj_header.isHidden = true;
        self.hasNoMoreData = true;
        self.loanDetailSwithView?.setBtnSelected(index: 2);
        self.loadSuccess();
        self.tableView.reloadData();
        
    }
    
    override func footerRefresh() {
        if self.paginitor?.hasNextPage == false {
            ViewUtil.showToast(text: "没有更多数据");
            self.tableView.mj_footer.endRefreshing();
            return;
        }
        self.reviewListLoadMoreService.getCommenListLoadMore(nextPage: self.paginitor?.nextPage, limit: self.paginitor?.limit, productId: self.productId);
    }
    
    func applyCommit(action : UIButton){
        if LotteryUtil.isLogin() == false {
            LotteryUtil.shouldLogin();
            return;
        }
        self.applyCommitService.applyCommit(token: LotteryUtil.token(), productId: String(describing: self.product.productId!),status: "1");
    }
    
    func modalToCommentsViewController(){
        if LotteryUtil.isLogin() == false {
            LotteryUtil.shouldLogin();
            return;
        }
        
//        let vc = CommentsViewController();
//        vc.productId = self.productId;
//
//        let navc = CommonBaseNavigationController(rootViewController:vc);
//        ViewUtil.keyViewController().present(navc, animated: true, completion: nil);
        let vc = LoanActivityPreViewController();
        
        self.pushViewController(viewController: vc);
        
       

    }
    //领取优惠券
    func applyCouponAction(action : UIButton) {
        if LotteryUtil.isLogin() == false {
            LotteryUtil.shouldLogin();
            return;
        }
        self.couponInfoView = LoanCouponInfoView(frame: self.view.bounds);
        self.couponInfoView?.titleLabel.text = "获得\(self.product.productName ?? "")赠送的免息券1张";
        self.couponInfoView?.button.addTarget(self, action: #selector(makeSureReceiveAction), for: .touchUpInside);
        UIApplication.shared.keyWindow?.addSubview(self.couponInfoView!);
        
    }
    
    func makeSureReceiveAction(){
        self.couponInfoView?.removeFromSuperview();
        guard let productId = self.product.productId else {
            return;
        }
        UserDefaults.standard.set(true, forKey: "haveReceiveCoupon\(productId)");
        UserDefaults.standard.synchronize();
        self.loanApplyCouponView.applicationBtn.setTitle("已领取", for: .normal);
        self.loanApplyCouponView.applicationBtn.isEnabled = false;
    }
    //客服VC
    func pushToIMVC(){
        
        if LotteryUtil.isLogin() == false {
            LotteryUtil.shouldLogin();
            return;
        }
        let vc = LoanIMViewController();
        vc.productId = self.productId;

        self.pushViewController(viewController: vc);
        
       
    }
    
    override func onCompleteSuccess(service: BaseService) {
        if service.isKind(of: applyCommitService.classForCoder) {
            if (product.applyInterface == nil || product.applyInterface == "" ) {
                self.loanApplicationView.applicationBtn.setTitle("已申请", for: .normal);
                self.loanApplicationView.applicationBtn.backgroundColor = COLOR_BROWN;
                return;
            }
                        let vc = ProductApplyViewController();
                        vc.productId = self.productId;
                        vc.urlContent = product.applyInterface;
                        self.pushViewController(viewController: vc);
          

            
        }else if service.isKind(of: ProductService.classForCoder()) {
            ViewUtil.dismissToast();
            self.tableView.mj_header.isHidden = false;
            self.tableView.mj_footer.isHidden = true;
            self.hasNoMoreData = true;
            self.loanDetailSwithView?.setBtnSelected(index: 0);
            if self.productDetailService.product != nil{
                //当攻略有刷新的时候，加载webView
                if self.product != nil && self.productDetailService.product?.strategyLink != nil && self.productDetailService.product?.strategyLink != "" && self.productDetailService.product?.strategyLink != self.product.strategyLink{
                   
                    let requst = URLRequest(url: CommonUtil.getURL(self.productDetailService.product?.strategyLink)!);
//                    let requst = URLRequest(url: CommonUtil.getURL("http://192.168.1.130:8000/loan.html#/m/strategy/detail?strategyId=162")!);

                    self.webView?.load(requst);
                }
                if self.product == nil && self.productDetailService.product?.strategyLink != "" && self.productDetailService.product?.strategyLink != nil{
                 
                    let requst = URLRequest(url: CommonUtil.getURL(self.productDetailService.product?.strategyLink)!);
//                    let requst = URLRequest(url: CommonUtil.getURL("http://192.168.1.130:8000/loan.html#/m/strategy/detail?strategyId=162")!);

                    self.webView?.load(requst);
                }

                
                self.product = self.productDetailService.product;
                if (product.applyInterface == nil || product.applyInterface == "" ) {
                    self.loanApplyCouponView.isHidden = false;
                    guard let productId = self.product.productId else{
                        return;
                    }
                    if UserDefaults.standard.bool(forKey: "haveReceiveCoupon\(productId)") == true{
                        self.loanApplyCouponView.applicationBtn.setTitle("已领取", for: .normal);
                        self.loanApplyCouponView.applicationBtn.isEnabled = false;
                    }
                }else{
                    self.loanApplyCouponView.isHidden = true;
                }
//                self.configureLoanSwitchView();

                self.title = self.product.productName ?? "";
                //刷新页面
                self.userHeaderView.reloadArr(conditionArr: self.product.authorizeTagsList ?? [], descArr: self.product.featureTagsList ?? [], imageUrl: product.productLogo ?? "", title: product.productName ?? "");
                self.userFilterView.reloadViewWithParameter(product: self.product);
                self.reduceProductForTableData(product: self.product);
                self.tableView.reloadData();
                self.loadSuccess();
            }
        }else if service.isKind(of: UserReviewService.classForCoder()){
            ViewUtil.dismissToast();
            self.tableView.mj_header.isHidden = false;
            self.tableView.mj_footer.isHidden = false;
            self.hasNoMoreData = false;
            self.loanDetailSwithView?.setBtnSelected(index: 1);
            if self.reviewListService.commentList != nil {
                self.commenList = self.reviewListService.commentList!;
            }
            
            self.loanReviewInfoView.reloadLoanInfo(favaRate: self.reviewListService.positiveRate ?? 100, rateFavaLevel: self.reviewListService.rateSatisfaction ?? 5, loanFavaLevel: self.reviewListService.loanSatisfaction ?? 0, processFavaLevel: self.reviewListService.processSatisfaction ?? 5);
            if self.reviewListService.paginator != nil {
                self.paginitor = self.reviewListService.paginator;
            }
                
            
            self.tableView.reloadData();
            self.loadSuccess();

            
        }else if service.isKind(of: UserReviewLoadMoreService.classForCoder()){
            ViewUtil.dismissToast();
            if self.reviewListLoadMoreService.commentList != nil {
                self.commenList.append(contentsOf: self.reviewListLoadMoreService.commentList!);
            }
            
            self.loanReviewInfoView.reloadLoanInfo(favaRate: self.reviewListLoadMoreService.positiveRate ?? 100, rateFavaLevel: self.reviewListLoadMoreService.rateSatisfaction ?? 5, loanFavaLevel: self.reviewListLoadMoreService.loanSatisfaction ?? 0, processFavaLevel: self.reviewListLoadMoreService.processSatisfaction ?? 5);
            
            if self.reviewListLoadMoreService.paginator != nil {
                self.paginitor = self.reviewListLoadMoreService.paginator;
            }
            
            self.tableView.reloadData();
            self.loadSuccess();




        }
    }
    
    func reduceProductForTableData(product:Product){
        self.tableViewArr.removeAll();
        if self.product.requirements != nil && ((self.product.requirements)!as NSString).length > 0{
            let proComponent = ProductDetailComponent();
            proComponent.titleStr = "申请条件&要点";
            proComponent.contentStr = self.product.requirements!;
            proComponent.type = 0;
            self.tableViewArr.append(proComponent);
        }
        if self.product.auditDetail != nil && ((self.product.auditDetail)!as NSString).length > 0{
            let proComponent = ProductDetailComponent();
            proComponent.titleStr = "借款审核细节";
            proComponent.contentStr = self.product.auditDetail!;
            proComponent.type = 0;

            self.tableViewArr.append(proComponent);

        }
        if self.product.guide != nil && ((self.product.guide)!as NSString).length > 0{
            let proComponent = ProductDetailComponent();
            proComponent.titleStr = "新手引导";
            proComponent.contentStr = self.product.guide!;
            proComponent.type = 0;

            self.tableViewArr.append(proComponent);
            
        }
        if self.product.advantage != nil && ((self.product.advantage)!as NSString).length > 0{
            let proComponent = ProductDetailComponent();
            proComponent.titleStr = "产品优势";
            proComponent.contentStr = self.product.advantage!;
            proComponent.type = 0;

            self.tableViewArr.append(proComponent);
            
        }
        if self.product.applyFlowTagsList != nil {
            let proComponent = ProductDetailComponent();
            proComponent.titleStr = "流程&材料";
            proComponent.applyFlowTagsList = self.product.applyFlowTagsList;
            proComponent.type = 1;

            self.tableViewArr.insert(proComponent, at: 1);
        }
        
    }
    
    func viewForFirstSwitchViewHeader(section:Int) -> UIView? {
        let headerBgView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 150.5));
        headerBgView.addSubview(self.userHeaderView);
        let header = ViewforHeaderInLoan(frame: CGRect(x: 0, y: 105.5, width: SCREEN_WIDTH, height: 45));
        headerBgView.addSubview(header);
        header.verLineView.backgroundColor = COLOR_BLUE;
        let proCompnentModel = self.tableViewArr[section];
        header.titleLabel.text = proCompnentModel.titleStr!;
        return headerBgView;
    }
    
    func viewForSecondSwitchViewHeader(section:Int) -> UIView? {
        let headerBgView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 162));
        headerBgView.addSubview(self.loanReviewInfoView);
        let header = ViewforHeaderInLoan(frame: CGRect(x: 0, y: 117, width: SCREEN_WIDTH, height: 45));
        headerBgView.addSubview(header);
        header.verLineView.backgroundColor = COLOR_BLUE;
        header.titleLabel.text = "用户评价（\(self.paginitor?.totalCount ?? 0)）";
        return headerBgView;
    }
    
    func viewForThirdSwithViewHeader(section:Int) -> UIView? {
        let headerBgView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 55));
        headerBgView.backgroundColor = COLOR_GROUND;
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: DIMEN_BORDER));
        lineView.backgroundColor = COLOR_BORDER;
        let header = ViewforHeaderInLoan(frame: CGRect(x: 0, y: 10, width: SCREEN_WIDTH, height: 45));
        //        headerBgView.addSubview(lineView);
        headerBgView.addSubview(header);
        header.verLineView.backgroundColor = COLOR_BLUE;
        header.titleLabel.text = "攻略";
        return headerBgView;
    }

    
    func viewForNormalHeader(section:Int) -> UIView? {
        let headerBgView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 55));
        headerBgView.backgroundColor = COLOR_GROUND;
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: DIMEN_BORDER));
        lineView.backgroundColor = COLOR_BORDER;
        let header = ViewforHeaderInLoan(frame: CGRect(x: 0, y: 10, width: SCREEN_WIDTH, height: 45));
        //        headerBgView.addSubview(lineView);
        headerBgView.addSubview(header);
        header.verLineView.backgroundColor = COLOR_BLUE;
        let proCompnentModel = self.tableViewArr[section];
        header.titleLabel.text = proCompnentModel.titleStr!;
        return headerBgView;
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.loanDetailSwithView?.firstBtn?.isSelected == true {
            if section == 0 {
                return viewForFirstSwitchViewHeader(section: section);
            }
            return viewForNormalHeader(section: section);
            
        }else if self.loanDetailSwithView?.secondBtn?.isSelected == true{
            if section == 0 {
                return viewForSecondSwitchViewHeader(section: section);
            }
            return viewForNormalHeader(section: section);
        }else{
           
            return viewForThirdSwithViewHeader(section: section);
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.loanDetailSwithView?.firstBtn?.isSelected == true {
            if section == 0 {
                return 150.5;
            }
            return 55;
            
        }else if self.loanDetailSwithView?.secondBtn?.isSelected == true{
            if section == 0 {
                return 162;
            }
            return 55;
        }else{
            
            return 55;
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.loanDetailSwithView?.firstBtn?.isSelected == true {
            let proComponetModel = self.tableViewArr[indexPath.section];
            if proComponetModel.type == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LoanDetailsTableViewCell")as!LoanDetailsTableViewCell;
                let str = proComponetModel.contentStr!;
                cell.reloadCell(textStr: str);
                cell.selectionStyle = .none;
                return cell;
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "LoanProcessCell", for: indexPath)as!LoanProcessCell;
                cell.reloadCellWithPrameter(dataArr: proComponetModel.applyFlowTagsList!);
                cell.selectionStyle = .none;
                return cell;
                
            }
            
        }else if self.loanDetailSwithView?.secondBtn?.isSelected == true{
            let commenModel = self.commenList[indexPath.row];
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoanReviewCell")as! LoanReviewCell;
         
            cell.reloadCellWithData(commentModel: commenModel);
            
            cell.selectionStyle = .none;

            return cell;
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!;
            if self.webCellScrollView != nil {
                cell.contentView.addSubview(self.webCellScrollView!);
            }
            cell.selectionStyle = .none;

            return cell;
          
            
        }
        
        
       
        
        
       
        
        
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.loanDetailSwithView?.firstBtn?.isSelected == true {
            return 1;
        }else if self.loanDetailSwithView?.secondBtn?.isSelected == true{
            return self.commenList.count;
        }else{
            return 1;
        }

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.loanDetailSwithView?.firstBtn?.isSelected == true {
            return self.tableViewArr.count;
        }else if self.loanDetailSwithView?.secondBtn?.isSelected == true{
            return 1;
        }else{
            return 1;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.loanDetailSwithView?.firstBtn?.isSelected == true {
            if indexPath.section == 1 {
                return 84 * RATIO;
                
            }else{
                let cell = self.tableView(tableView, cellForRowAt: indexPath)as! LoanDetailsTableViewCell;
                return cell.height();
            }
        }else if self.loanDetailSwithView?.secondBtn?.isSelected == true{
            let cell = self.tableView(tableView, cellForRowAt: indexPath)as! LoanReviewCell;
            return cell.height();
        }else{
            return  self.webView!.frame.size.height;

        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        MXNavigationBarManager.changeAlpha(withCurrentOffset: scrollView.contentOffset.y);
        let offsetY = scrollView.contentOffset.y
        
        if (offsetY > SCREEN_WIDTH/750*375)
        {
            let alpha = (offsetY - SCREEN_WIDTH/750*375) / CGFloat(64)
            navBarBackgroundAlpha = alpha
            navBarTintColor = COLOR_WHITE.withAlphaComponent(alpha)
            navBarTitleColor = COLOR_WHITE.withAlphaComponent(alpha)
            statusBarStyle = .default
        }
        else
        {
            navBarBackgroundAlpha = 0
            navBarTintColor = .white
            navBarTitleColor = .white
            statusBarStyle = .lightContent
        }
    }
    
    
   
    
    func reloadWebHeight(){
        self.webView?.evaluateJavaScript("document.body.offsetHeight") { (resulta, error) in
            guard let resultHeight = resulta else{
                return;
            }
            
            let result = (resultHeight as! CGFloat) + 80;
           
            self.webCellScrollView?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: result);
            self.webCellScrollView?.contentSize = CGSize.init(width: SCREEN_WIDTH, height: result);
            self.webView?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: result);
            self.tableView.reloadData();
        }
    }
    
   
    
    func StringToFloat(str:String)->(CGFloat){
        let string = str
        var cgFloat: CGFloat = 0
        
        if let doubleValue = Double(string)
        {
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
    
 
    
    
    
    
    override func setEmptyButton(isSuccess: Bool) {
        
        if (isSuccess == true) {
            self.emptyButton.isUserInteractionEnabled = false;
            self.emptyButton.descriptionLabel.text = self.emptyButton.descriptionText;
        } else {
            self.emptyButton.isUserInteractionEnabled = true;
            self.emptyButton.descriptionLabel.text = "点击重新加载";
        }
        
        var numberOfCells = 0;
        
        if (self.tableView.numberOfSections == 1) {
            numberOfCells = self.tableView.numberOfRows(inSection: 0);
        } else {
            numberOfCells = self.tableView.numberOfSections;
        }
        
        if (numberOfCells == 0) {
            var tableHeaderViewHeight = self.tableView.tableHeaderView?.frame.height;
            if (tableHeaderViewHeight == nil) {
                tableHeaderViewHeight = 0;
            }
            self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height-tableHeaderViewHeight!-64 + self.loanApplicationView.height()));
            self.tableView.tableFooterView?.addSubview(self.emptyButton);
        } else {
            self.tableView.tableFooterView = UIView();
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
