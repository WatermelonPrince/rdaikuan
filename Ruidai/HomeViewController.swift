//
//  HomeViewController.swift
//  Lottery
//
//  Created by DTY on 17/1/18.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit


class HomeViewController: CommonRefreshTableViewController, SDCycleScrollViewDelegate, ServiceDelegate ,UIGestureRecognizerDelegate,SGAdvertScrollViewDelegate{
    
    var cycleScrollView: SDCycleScrollView!;
    var productList = Array<Product>();
    var redPacketButton: UIButton!;
    var homeService: HomeService!;
    var homeLoadMoreService : HomeLoadMoreService!
    var applySucAdService : ApplySucAdService!

    var paginator = Paginator();
    var homeAd : HomeAdView!
    var applySucAdView: ApplySucAdView!
    var adRedPacketView : AdRedpacketView!
    var connerAd : Advertisement?
    var popupAd : Advertisement?
    var applySucAd: Advertisement!
    var tableHeaderView : UIView?
    var titleView : HomeNavTitleView?
    var matchActionView : UIImageView?
    var noticeView : HomeNoticeView?
    var noticeBgView : UIView?
    var cardBgView : UIView?
    var filterPickerView : MarketSecondFilterView?
    var loanAmountTags: Array<Tags>?

    
    
    
   
   
    override func viewDidLoad() {
        super.viewDidLoad();
        
        

        self.titleView = HomeNavTitleView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 30));
        self.titleView?.touchBtn?.addTarget(self, action: #selector(showOrHiddenPickerView), for: .touchUpInside);
        self.navigationItem.titleView = self.titleView;
        self.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: SCREEN_WIDTH/750*375 + 7));
        self.tableHeaderView?.backgroundColor = COLOR_GROUND;
        self.tableView.frame = CGRect(x: self.tableView.frame.origin.x, y: self.tableView.frame.origin.y, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height - 49);
        if #available(iOS 11.0, *) {
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }else{
            self.tableView.contentInset = UIEdgeInsetsMake(-NAVIHEIGHT, 0, 0, 0);
        }
        
        //Banner
        self.cycleScrollView = CommonCycleScrollView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: SCREEN_WIDTH/750*375), delegate: self, placeholderImage: nil);
        self.tableHeaderView?.addSubview(self.cycleScrollView);
        self.cycleScrollView.delegate = self;
        self.setBannerImageUrl();
        
        //matchImage
        self.matchActionView = UIImageView(frame: CGRect(x: 0, y: self.cycleScrollView.bottom() + 7, width: SCREEN_WIDTH, height: 70));
        self.matchActionView?.isUserInteractionEnabled = true;
        let tapImageAction = UITapGestureRecognizer(target: self, action: #selector(tapMatchImageAction));
        self.matchActionView?.addGestureRecognizer(tapImageAction);
        self.matchActionView?.image = #imageLiteral(resourceName: "icon_matchimage");
        
        //noticeVIew
        self.noticeBgView = UIView(frame: CGRect(x: 0, y: (self.matchActionView?.bottom())! + 7, width: SCREEN_WIDTH, height: 60));

        
        self.tableHeaderView?.addSubview(self.cycleScrollView);
        self.tableHeaderView?.addSubview(self.matchActionView!);
        self.tableHeaderView?.addSubview(self.noticeBgView!);
        
        self.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: (self.noticeBgView?.bottom())! + 7);
        self.tableView.tableHeaderView = tableHeaderView;

        
        //cardBgView
        self.cardBgView = UIView();
        self.cardBgView?.backgroundColor = COLOR_WHITE;
        
        
        
        //TableView
        self.tableView.register(HomeTableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        self.tableView.mj_footer.isHidden = false;
        self.hasNoMoreData = false
        if LotteryUtil.homeEntranceList() != nil {
            self.productList = LotteryUtil.homeEntranceList()!;
        }

        
        //redPacket
        let redPacketWidth = SCREEN_WIDTH*0.13;
        self.redPacketButton = UIButton(frame: CGRect(x: SCREEN_WIDTH-redPacketWidth-10, y: SCREEN_HEIGHT-redPacketWidth-100, width: redPacketWidth, height: redPacketWidth));
        self.redPacketButton.sd_setImage(with: CommonUtil.getURL(LotteryUtil.cornerBanner()?.imgUrl), for: .normal);
        self.redPacketButton.addTarget(self, action: #selector(cornerBannerAction), for: .touchUpInside);
        self.view.addSubview(self.redPacketButton);
        
        self.homeService = HomeService(delegate: self);
        self.homeLoadMoreService = HomeLoadMoreService(delegate:self);
        self.applySucAdService = ApplySucAdService(delegate: self);

        ViewUtil.showProgressToast();
        self.headerRefresh();
        
        //Observer
        NotificationCenter.default.addObserver(self, selector: #selector(headerRefresh), name: Notification.Name.UIApplicationWillEnterForeground, object: nil);
         NotificationCenter.default.addObserver(self, selector: #selector(getApplySucAdData), name: Notification.Name.init(APPLYSUCNOTI), object: nil);
        
        //PickerView
        self.filterPickerView = MarketSecondFilterView(frame: CGRect(x: 0, y: NAVIHEIGHT , width: SCREEN_WIDTH, height: SCREEN_HEIGHT - TABBARHEIGHT));
        self.filterPickerView?.selectedAmountHanlder = {
            (index,title) in
            self.filterPickerView?.removeFromSuperview();
            guard let tag = self.loanAmountTags?[index], let tagValue = tag.value else {
                return;
            }
           // self.loanAmount = String(describing: tagValue);
            let marketVC = PushLoanMarketViewController();
            marketVC.loanAmount = String(tagValue);
            self.pushViewController(viewController: marketVC);
            
        }
        

        
    }
    
    //申请成功回调方法
    func getApplySucAdData(notificaiton: Notification){
        guard let productId: String = notificaiton.userInfo!["productId"] as? String else {
            return;
        }
        self.applySucAdService.getPromotionAd(productId: productId, client: "1");
    }

    func showOrHiddenPickerView(action: UIButton){
        var isShow = false;
        for subview in (UIApplication.shared.keyWindow?.subviews)! {
            if subview == self.filterPickerView {
                isShow = true;
            }
        }
        if isShow == false {
            UIApplication.shared.keyWindow?.addSubview(self.filterPickerView!);
        }else{
            self.filterPickerView?.removeFromSuperview();
        }
        
        
    }
    
    func tapMatchImageAction(){
        self.pushViewController(viewController: AccurateMatchViewController());

    }
    //MatchImage跳转链接
    func reloadMatchImageUrl(){
        guard self.homeService.searchImageUrl != nil && self.homeService.searchImageUrl != "" else {
            self.matchActionView?.frame = CGRect(x: (self.matchActionView?.left())!, y: (self.matchActionView?.top())!, width: (self.matchActionView?.width())!, height: 0);
            self.noticeBgView?.frame = CGRect(x: 0, y: (self.matchActionView?.bottom())!, width: (self.noticeBgView?.width())!, height: (self.noticeBgView?.height())!);
            return;
        }
       
        self.matchActionView?.sd_setImage(with: CommonUtil.getURL(self.homeService.searchImageUrl));
        
    }
    
    func reloadNoticeView(){
        guard self.homeService.noticeList != nil && self.homeService.noticeList.count != 0 else {
            self.noticeView?.noticeView?.titleArray = [];
            self.noticeBgView?.frame = CGRect(x: 0, y: (self.matchActionView?.bottom())!, width: (self.noticeBgView?.width())!, height: 0);
            return;
        }
    
        var arr = Array<Any>();
        var imageArr = Array<Any>();
        for item in self.homeService.noticeList {
            let item = item;
            let attributeStr = SGHelperTool.sg_textAttachment(withImageName: "", imageSize: CGSize.zero, frontText: "\(item.productName ?? "")\n" , frontTextColor: COLOR_FONT_HEAD, behindText: "\(item.noticePrefix ?? "") 今日借款 \(item.loanAmount ?? "") 已到账", behindSecondPartText: item.loanAmount ?? "", behindTextColor: COLOR_FONT_SECONDARY, behindSecondPartTextColor: COLOR_ORANGE);
            arr.append(attributeStr!);
            imageArr.append(item.productLogo ?? "");

        }
        self.noticeView?.noticeView?.titleArray = arr;
        self.noticeView?.noticeView?.imageArr = imageArr;
        let attMutableStr = NSMutableAttributedString(string: "今日已有 ", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 11),NSForegroundColorAttributeName:COLOR_FONT_TEXT]);
        let finaAttmutableStr = NSMutableAttributedString(string: " 申请", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 11),NSForegroundColorAttributeName:COLOR_FONT_TEXT]);
        let secondAttStr = NSMutableAttributedString(string: String(self.homeService.applyCount ?? 11122), attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:COLOR_FONT_HEAD]);
        
        attMutableStr.append(secondAttStr);
        attMutableStr.append(finaAttmutableStr);
        
        self.noticeView?.applyCountLabel?.attributedText = attMutableStr;
        
        self.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: (self.noticeBgView?.bottom())! + 7);
        self.tableView.tableHeaderView = self.tableHeaderView;

        
    }
    
    //通知点击事件
    func advertScrollView(_ advertScrollView: SGAdvertScrollView!, didSelectedItemAt index: Int) {
        let item = self.homeService.noticeList[index];
        guard item.detailUrl != nil else {
            return;
        }
        LoanRoutes.routeURLString(item.detailUrl!);

    }
    
    func reloadCardView(){
//        let arr = [0,1,2,3];
        for item in (self.cardBgView?.subviews)! {
            item.removeFromSuperview();
        }
    
        let cardWidth = (SCREEN_WIDTH - 35)/2;
        let cardHeight = cardWidth/340*160;
        var totalHeight = CGFloat(0);
        for (index,item) in self.homeService.productCategorys.enumerated() {
            let cardImageView = UIImageView(frame: CGRect(x: 15 + (cardWidth + 5) * CGFloat(index%2), y: 15 + (cardHeight + 5) * CGFloat(index/2), width: cardWidth, height: cardHeight));
            cardImageView.layer.cornerRadius = 5;
            cardImageView.layer.masksToBounds = true;
            cardImageView.tag = 1000 + index;
            cardImageView.isUserInteractionEnabled = true;
            cardImageView.sd_setImage(with: CommonUtil.getURL(item.image ?? ""));
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapCardAction));
            cardImageView.addGestureRecognizer(tapGesture);
            self.cardBgView?.addSubview(cardImageView);
            if index == self.homeService.productCategorys.count - 1 {
                totalHeight = cardImageView.bottom();
            }
        }
        if self.homeService.productCategorys.count == 0 {
            self.cardBgView?.frame = CGRect(x: 0, y: (self.noticeBgView?.bottom())!, width: SCREEN_WIDTH, height: 0);
        }else{
            self.cardBgView?.frame = CGRect(x: 0, y: (self.noticeBgView?.bottom())! + 7, width: SCREEN_WIDTH, height: totalHeight + 15);
        }
        self.tableHeaderView?.addSubview(self.cardBgView!);
        self.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: (self.cardBgView?.bottom())! + 7);
        self.tableView.tableHeaderView = self.tableHeaderView;
        
        
        
    }
    
   
    
    
    func tapCardAction(action : UITapGestureRecognizer){
        let productCategory = self.homeService.productCategorys[(action.view?.tag)! - 1000];
        guard productCategory.link != nil else {
            return;
        }
        LoanRoutes.routeURLString(productCategory.link!);
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
//        self.initNaviBarManager();
        
        //友盟统计
        AppConfigure.shareAppConfigure.upDateUMClickEvent(event: "home");

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
        if self.homeAd != nil {
            self.homeAd.removeFromSuperview();
        }
        if self.adRedPacketView != nil {
            self.adRedPacketView.removeFromSuperview();
        }
        if self.applySucAdView != nil {
            self.applySucAdView.removeFromSuperview();
        }
    }
    
    
   
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    override func headerRefresh() {
        self.homeService.getHome();
    }
    
    override func footerRefresh() {
        if self.paginator.hasNextPage == false {
            ViewUtil.showToast(text: "没有更多数据");
            self.tableView.mj_footer.endRefreshing();
            return;
        }
        self.homeLoadMoreService.getHomeLoadMore(nextPage: self.paginator.nextPage, limit: self.paginator.limit);
    }
    
    override func onCompleteSuccess(service: BaseService) {
        ViewUtil.dismissToast();
        
        if (service.isKind(of: homeService.classForCoder)) {
            //Banner
            if (self.homeService.bannerList != nil) {
                LotteryUtil.saveBannerList(bannerList: self.homeService.bannerList);
            }
            self.setBannerImageUrl();
            
            if (self.homeService.cornerBanner != nil) {
                LotteryUtil.saveCornerBanner(banner: self.homeService.cornerBanner);
            }
            self.redPacketButton.sd_setImage(with: CommonUtil.getURL(LotteryUtil.cornerBanner()?.imgUrl), for: .normal);
            
            //ProductList
            if (self.homeService.productList != nil) {
                self.productList = self.homeService.productList;
                LotteryUtil.saveHomeEntranceList(entranceList: self.productList);
               
                self.tableView.reloadData();
            }
           
            
            //matchView
                self.reloadMatchImageUrl();
            
            //noticeList
           
                self.noticeView = HomeNoticeView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 60));
                self.noticeView?.noticeView?.advertScrollViewDelegate = self;
        
                self.reloadNoticeView();
                self.noticeBgView?.addSubview(self.noticeView!);
            
            
            //productCategorysList
            if self.homeService.productCategorys != nil {
                self.reloadCardView();
            }
            //loanAmountTags
            if self.homeService.loanAmountTags != nil {
                self.loanAmountTags = self.homeService.loanAmountTags;
                self.filterPickerView?.reloadPickerViewWithArr(arr: self.homeService.loanAmountTags!);

            }
            
            self.paginator = self.homeService.paginator;
            self.connerAd = self.homeService.connerAd;
            self.popupAd = self.homeService.popupAd;
            
            if AppConfigure.shareAppConfigure.advertisementShowOrHidden(adModel: self.popupAd ?? nil) == true {
                self.perform(#selector(showPopupAdView), with: nil, afterDelay: 1.5);

            }
            
            if AppConfigure.shareAppConfigure.advertisementShowOrHidden(adModel: self.connerAd ?? nil) == true {
                self.perform(#selector(showConnerAdView), with: nil, afterDelay: 1.5);
            }
            //修改tabBartitle
            if self.homeService.tabBarTitle != nil && self.homeService.tabBarTitle != "" {
                let nav = self.tabBarController?.viewControllers![1] as! CommonBaseNavigationController;
                nav.tabBarItem.title = self.homeService.tabBarTitle;
                UserDefaults.standard.set(self.homeService.tabBarTitle, forKey: "tabBarTitle");
                UserDefaults.standard.synchronize();
            }

        }else if(service.isKind(of: HomeLoadMoreService.classForCoder())){
            if (self.homeLoadMoreService.productList != nil) {
                self.productList.append(contentsOf: self.homeLoadMoreService.productList);
                self.tableView.reloadData();
            }
            self.paginator = self.homeLoadMoreService.paginator;
            self.connerAd = self.homeLoadMoreService.connerAd;
            self.popupAd = self.homeLoadMoreService.popupAd;
        }else if(service.isKind(of: ApplySucAdService.classForCoder())){
            if (self.applySucAdService.applySucAd != nil) {
                self.applySucAd = self.applySucAdService.applySucAd!;
                self.showApplySucAdView();
            }
            
        }
        
       
        
 
        self.loadSuccess();
        
        
    }
    
    func showPopupAdView(){
        if self.homeAd != nil {
            self.homeAd.removeFromSuperview();
        }
        if ViewUtil.keyViewController() == self {
            self.homeAd = HomeAdView(frame: self.view.bounds);
            self.homeAd.adverImageView.sd_setImage(with: CommonUtil.getURL(self.popupAd?.imageUrl ?? ""));
            self.homeAd.tapGesture?.addTarget(self, action: #selector(homeAdLinkAction));
            UIApplication.shared.keyWindow?.addSubview(self.homeAd);
        }
    }
    
    func showApplySucAdView(){
        if self.applySucAdView != nil {
            self.applySucAdView.removeFromSuperview();
        }
        
        if ViewUtil.keyViewController() == self {
            self.applySucAdView = ApplySucAdView(frame: self.view.bounds);
            self.applySucAdView.adverImageView.sd_setImage(with: CommonUtil.getURL(self.applySucAd?.imageUrl ?? nil));
            self.applySucAdView.tapGesture?.addTarget(self, action: #selector(applySucAdViewLinkAction));
            UIApplication.shared.keyWindow?.addSubview(self.applySucAdView);
        }
        
    }
    
    func showConnerAdView(){
        if self.adRedPacketView != nil {
            self.adRedPacketView.removeFromSuperview();
        }
        if ViewUtil.keyViewController() == self {
            self.adRedPacketView = AdRedpacketView(frame:CGRect(x: SCREEN_WIDTH - 75 - 30, y: SCREEN_HEIGHT - TABBARHEIGHT - 15 - 60, width: 60, height: 60));
            self.adRedPacketView.adModel = self.connerAd;
            self.view.addSubview(self.adRedPacketView);
        }
    }
    
    func homeAdLinkAction(){
        self.homeAd.removeFromSuperview();
        guard self.popupAd?.link != nil else {
            return;
        }
        //广告统计
        AppConfigure.shareAppConfigure.upDateUMClickEvent(event: "home_advertisement");
        LoanRoutes.routeURLString((self.popupAd?.link!)!);
    }
    
    func applySucAdViewLinkAction(){
        self.applySucAdView.removeFromSuperview();
        guard self.applySucAd?.link != nil else {
            return;
        }
        //广告统计
        AppConfigure.shareAppConfigure.upDateUMClickEvent(event: "success_advertisement");
        LoanRoutes.routeURLString((self.applySucAd?.link!)!);
    }
    
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        let urlContent = LotteryUtil.bannerList()?[index].link;
        if (urlContent != nil) {
            AppConfigure.shareAppConfigure.upDateUMClickEvent(event: "home_banner");
            LoanRoutes.routeURLString(urlContent!);
        }else{
            let alertController = UIAlertController(title: "敬请期待", message: nil, preferredStyle: .alert);
            alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
            alertController.show();
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productList.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 129.5;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell;
        cell.linkTapGesture?.addTarget(self, action: #selector(pushToWebViewController));
        cell.setData(product: self.productList[indexPath.row]);
        
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
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerBgView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40));
        headerBgView.backgroundColor = COLOR_WHITE;
        let headerImage = UIImageView(frame: CGRect(x: 15, y: 15, width: 25, height: 25));
        headerImage.image = #imageLiteral(resourceName: "icon_home_header");
        let titleLabel = UILabel(frame: CGRect(x: headerImage.right() + 5, y: 15, width: 120, height: 25));
        titleLabel.textColor = COLOR_FONT_TEXT;
        titleLabel.font = UIFont.systemFont(ofSize: 17);
        titleLabel.text = "最新上线";
        let moreBtn = UIButton(frame: CGRect(x: SCREEN_WIDTH - 40, y: 15, width: 25, height: 25));
        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12);
        moreBtn.setTitleColor(COLOR_FONT_TEXT, for: .normal);
        moreBtn.setTitle("更多", for: .normal);
        moreBtn.addTarget(self, action: #selector(pushToMarketController), for: .touchUpInside);
        headerBgView.addSubview(titleLabel);
        headerBgView.addSubview(headerImage);
        headerBgView.addSubview(moreBtn);
        return headerBgView;
    }
    
    func pushToMarketController(){
        ViewUtil.keyViewController();
        let vc = UIApplication.shared.keyWindow?.rootViewController as! LoanTabBarViewController;
        vc.selectedIndex = 1;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40;

        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        let product = self.productList[indexPath.row];
        let vc = LoanDetailViewController();
        vc.hidesBottomBarWhenPushed = true;
        vc.product = product;
        vc.productId = product.productId;
        AppContext().sendProductStatis(productId: product.productId);

        self.navigationController?.pushViewController(vc, animated: true);
//        self.showAdView();
        
    }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero;
        cell.layoutMargins = UIEdgeInsets.zero;
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        MXNavigationBarManager.changeAlpha(withCurrentOffset: scrollView.contentOffset.y);
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            self.navigationItem.titleView = nil;
        }else{
            self.navigationItem.titleView = self.titleView;
        }
        if (offsetY > SCREEN_WIDTH/750*375)
        {
            let alpha = (offsetY - SCREEN_WIDTH/750*375) / CGFloat(64)
            navBarBackgroundAlpha = alpha
            navBarTintColor = COLOR_WHITE.withAlphaComponent(alpha)
            navBarTitleColor = COLOR_WHITE.withAlphaComponent(alpha)
            statusBarStyle = .default
            self.titleView?.labelBgView?.backgroundColor = COLOR_WHITE;
            
        }
        else
        {
            navBarBackgroundAlpha = 0
            navBarTintColor = .white
            navBarTitleColor = .white
            statusBarStyle = .lightContent
            self.titleView?.labelBgView?.backgroundColor = COLOR_WHITE.withAlphaComponent(0.3);

        }
    }
    
    func navAction(_ button: HomeCellItemView) {
        // todo 进详情页
    }
    
    func setBannerImageUrl() {
        let bannerList = LotteryUtil.bannerList();
        var imageUrlList = Array<String>();
        if (bannerList != nil) {
            for banner in bannerList! {
                if (banner.imageUrl != nil) {
                    imageUrlList.append(banner.imageUrl!);
                }
            }
            self.cycleScrollView.imageURLStringsGroup = imageUrlList;
        }
    }
    
    func cornerBannerAction() {
        if (LotteryUtil.cornerBanner() != nil) {
            let urlContent = LotteryUtil.cornerBanner()?.detailUrl;
            if (urlContent != nil) {
               LoanRoutes.routeURLString(urlContent!);
            }
            
        }
    }
    
}
