//
//  FuliTableViewController.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/24.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class FuliTableViewController: CommonRefreshTableViewController, ServiceDelegate,SDCycleScrollViewDelegate{
    var cycleScrollView: SDCycleScrollView!;
    var tableHeaderView: UIView!
    var fcousBgView : UIView!;
    
    var fuliService : FuliService!;
    var fuliObject = FuliObject();
    var popupAd : Advertisement?
    var connerAd : Advertisement?
    var fuliAdView : HomeAdView!
    var adRedPacketView : WelfareAdRedpacket!



    override func viewDidLoad() {
        super.viewDidLoad()
//        let nav = self.tabBarController?.viewControllers![1] as! CommonBaseNavigationController;
//        nav.tabBarItem.title = "哈哈哈";
        self.navigationItem.title = "福利"
        self.tableView.register(FuliTableViewCell.classForCoder(), forCellReuseIdentifier: "FuliTableViewCell");
        self.tableView.register(FuliScrollViewTableViewCell.classForCoder(), forCellReuseIdentifier: "FuliScrollViewTableViewCell");
        self.tableView.frame = CGRect(x: self.tableView.left(), y: self.tableView.top(), width: self.tableView.width(), height: self.tableView.height() - 49);
        self.setUpTableHeaderView();
        self.tableView.backgroundColor = COLOR_GROUND;

        if #available(iOS 11.0, *) {
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }else{
            self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        }
        tableView.scrollIndicatorInsets = tableView.contentInset;
        self.fuliService = FuliService(delegate: self);
        ViewUtil.showProgressToast();
        self.headerRefresh();
        self.tableView.mj_footer.isHidden = false;
        self.hasNoMoreData = false;
        
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        AppConfigure.shareAppConfigure.upDateUMClickEvent(event: "welfare");


    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
        if self.fuliAdView != nil {
            self.fuliAdView.removeFromSuperview();
        }
        if self.adRedPacketView != nil {
            self.adRedPacketView.removeFromSuperview();
        }
    }
    
    override func headerRefresh() {
        self.fuliService.getFuli();
    }
    
    override func footerRefresh() {
        ViewUtil.showToast(text: "没有更多数据");
        self.tableView.mj_footer.endRefreshing();
    }
    
    override func onCompleteSuccess(service: BaseService) {
        ViewUtil.dismissToast();
        if service.isKind(of: FuliService.classForCoder()){
            if self.fuliService.fuliObject != nil {
                self.fuliObject = self.fuliService.fuliObject;
                self.reloadTableHeaderView();
                self.tableView.reloadData();
                if self.fuliObject.popupAd != nil {
                    self.popupAd = self.fuliObject.popupAd;
                    if AppConfigure.shareAppConfigure.advertisementShowOrHidden(adModel: self.popupAd ?? nil) == true {
                        self.perform(#selector(showPopupAdView), with: nil, afterDelay: 1.5);
                    }
                }
                if self.fuliObject.connerAd != nil {
                    self.connerAd = self.fuliObject.connerAd;
                    if AppConfigure.shareAppConfigure.advertisementShowOrHidden(adModel: self.connerAd ?? nil) == true {
                        self.perform(#selector(showConnerAdView), with: nil, afterDelay: 1.5);
                    }
                }
            }
        }
        self.loadSuccess();
    }
    
    
    func showPopupAdView(){
        if self.fuliAdView != nil {
            self.fuliAdView.removeFromSuperview();
        }
        if ViewUtil.keyViewController() == self {
            self.fuliAdView = HomeAdView(frame: self.view.bounds);
            self.fuliAdView.adverImageView.sd_setImage(with: CommonUtil.getURL(self.popupAd?.imageUrl ?? ""));
            self.fuliAdView.tapGesture?.addTarget(self, action: #selector(fuliAdLinkAction));
            
            UIApplication.shared.keyWindow?.addSubview(self.fuliAdView);
        }
        
    }
    
    func showConnerAdView(){
        if self.adRedPacketView != nil {
            self.adRedPacketView.removeFromSuperview();
        }
        if ViewUtil.keyViewController() == self {
            self.adRedPacketView = WelfareAdRedpacket(frame:CGRect(x: SCREEN_WIDTH - 75 - 30, y: SCREEN_HEIGHT - TABBARHEIGHT - 15 - 60, width: 60, height: 60));
            self.adRedPacketView.adModel = self.connerAd;
            self.view.addSubview(self.adRedPacketView);
        }
      
    }
    
    func fuliAdLinkAction(){
        self.fuliAdView.removeFromSuperview();

        guard self.popupAd?.link != nil else {
            return;
        }
        //广告统计
        AppConfigure.shareAppConfigure.upDateUMClickEvent(event: "welfare_advertisement");
        LoanRoutes.routeURLString((self.popupAd?.link!)!);
    }
    
    func setUpTableHeaderView(){
        self.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: SCREEN_WIDTH/750*375+10));
        tableHeaderView.backgroundColor = COLOR_GROUND;
        
        //Banner
        self.cycleScrollView = CommonCycleScrollView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: SCREEN_WIDTH/750*375), delegate: self, placeholderImage: nil);
        tableHeaderView.addSubview(self.cycleScrollView);
        self.cycleScrollView.delegate = self;
//        self.setBannerImageUrl();
        self.fcousBgView = UIView();
        self.fcousBgView.frame = CGRect(x: 0, y: self.cycleScrollView.bottom(), width: SCREEN_WIDTH, height: 167/2);
        
       
        self.tableHeaderView.addSubview(self.fcousBgView);
        self.tableHeaderView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.fcousBgView.bottom() + 15);
        
        self.tableView.tableHeaderView = tableHeaderView;
    }
    
    func pushToCatagoryList(action:UIButton){
        let model = self.fuliService.fuliObject.tagsList[action.tag - 1000];
        if model.link != nil {
            LoanRoutes.routeURLString(model.link!);

        }else{
            let alertController = UIAlertController(title: "敬请期待", message: nil, preferredStyle: .alert);
            alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
            alertController.show();
        }
        
    }
    
    func reloadTableHeaderView(){
        self.setBannerImageUrl();
        self.tableHeaderView.backgroundColor = COLOR_WHITE;
        for view in self.fcousBgView.subviews {
            view.removeFromSuperview();
        }
        if self.fuliService.fuliObject.tagsList != nil {
            
            while self.fuliService.fuliObject.tagsList.count > 4 {
                self.fuliService.fuliObject.tagsList.removeLast();
            }
            
            let count = self.fuliService.fuliObject.tagsList.count;
            let width = CGFloat(70.0);
            let height = CGFloat(60);
            let spaceWith = (SCREEN_WIDTH - 70 * CGFloat(count))/CGFloat(count);
            
            for i in 0..<count  {
                let fcousView = FcousView(frame: CGRect(x: spaceWith/2 + (width + spaceWith)*CGFloat(i), y: 15, width: width, height: height));
                fcousView.fcousButton.tag = 1000 + i;
                fcousView.fcousButton.addTarget(self, action: #selector(pushToCatagoryList), for: .touchUpInside);
                let model = self.fuliService.fuliObject.tagsList[i];
                fcousView.fcousButton.sd_setImage(with: CommonUtil.getURL(model.imageUrl!), for: .normal);
                fcousView.fcousLabel.text = model.title;
                
                self.fcousBgView.addSubview(fcousView);
            }
        }
    }
    
    
    func setBannerImageUrl() {
        let bannerList = self.fuliService.fuliObject.bannerList;
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
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
         let adverObj = self.fuliObject.bannerList[index];
        if (adverObj.link != nil){
            AppConfigure.shareAppConfigure.upDateUMClickEvent(event: "welfare_banner");

            LoanRoutes.routeURLString(adverObj.link ?? "");
        }else{
            let alertController = UIAlertController(title: "敬请期待", message: nil, preferredStyle: .alert);
            alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
            alertController.show();
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.fuliObject.categoryList != nil {
            if self.fuliObject.categoryList[section].type == 1 {
                return 1;
            }else{
                return self.fuliObject.categoryList[section].advertisements.count;
            }
            
        }
        return 0;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = self.fuliObject.categoryList[indexPath.section];
        if category.type == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FuliScrollViewTableViewCell")as! FuliScrollViewTableViewCell;
            cell.reloadCellWithData(arrData: category.advertisements);
            cell.clickAdViewHanlder = {
                (index: Int) in
                let advertiseMent = category.advertisements[index];
                if advertiseMent.link != nil {
                    LoanRoutes.routeURLString(advertiseMent.link!);
                    
                }
            }
            return cell;
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FuliTableViewCell")as!FuliTableViewCell;
            let fuliProduct = category.advertisements[indexPath.row];
            cell.setData(model: fuliProduct);
            cell.patiButton.addTarget(self, action: #selector(cellButtonAction), for: .touchUpInside);
            return cell;
        }

       
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
        let category = self.fuliObject.categoryList[indexPath.section];
        if category.type == 1 {
            return 150;
        }
        return 100.0;
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let category = self.fuliObject.categoryList[section];
        let headerBgView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 55));
        let headerView = WelfareHeaderView(frame: CGRect(x: 0, y: 10, width: SCREEN_WIDTH, height: 45));
        headerView.titleLabel?.text = category.name;
        headerView.iconImageView?.sd_setImage(with: CommonUtil.getURL(category.image ?? ""));
        headerView.backgroundColor = COLOR_WHITE;
        headerBgView.addSubview(headerView);
        headerBgView.backgroundColor = COLOR_GROUND;

        return headerBgView;
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.fuliObject.categoryList != nil {
            return self.fuliObject.categoryList.count;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false);
        let category = self.fuliObject.categoryList[indexPath.section];
        let fuliProduct = category.advertisements[indexPath.row];
        if fuliProduct.link != nil {
            LoanRoutes.routeURLString(fuliProduct.link ?? "");
        }else{
            let alertController = UIAlertController(title: "敬请期待", message: nil, preferredStyle: .alert);
            alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
            alertController.show();
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
