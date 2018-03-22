//
//  CommentsViewController.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/16.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class CommentsViewController: CommonBaseScrollViewController,UITextViewDelegate,ServiceDelegate {
    var loanInforView : LoanSimpleInfoView!
    var statusBgView : UIView!
    var lineView : UIView!
    var rateBgView : UIView!
    
    var rateFavaLevelView: LoanTitleAndStarClickView?
    var loanFavaLevelView: LoanTitleAndStarClickView?
    var processFavaLevelView: LoanTitleAndStarClickView?
    
    var textView : CommonBaseTextView!
    var confirmCommentsBtn: UIButton!
    var tapGesture : UITapGestureRecognizer!
    var commentPreService : CommentsPreService!
    var commitCommentService :CommitCommentsService!
    var productId : String?
    var headerBgView : UIView!
    var selectedTagIndext  = -1;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "点评";
        self.scrollView.backgroundColor = COLOR_WHITE;
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "returnback_item"), style: .done, target: self, action: #selector(navBackAction));
        self.scrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT + (180/RATIO));
        if #available(iOS 11.0, *) {
            self.loanInforView = LoanSimpleInfoView(frame: CGRect(x: 0, y: NAVIHEIGHT, width: SCREEN_WIDTH, height: 70));

        }else{
            self.loanInforView = LoanSimpleInfoView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 70));

        }
        self.headerBgView = UIView(frame: CGRect(x: 0, y: self.loanInforView.bottom(), width: SCREEN_WIDTH, height: 55));
        let header = ViewforHeaderInLoan(frame: CGRect(x: 0, y: 10, width: SCREEN_WIDTH, height: 45));
        self.headerBgView.addSubview(header);
        self.headerBgView.backgroundColor = COLOR_GROUND;
        header.verLineView.backgroundColor = COLOR_BLUE;
        header.titleLabel.text = "选择贷款状态";
        
        self.statusBgView = UIView(frame: CGRect(x: 0, y: self.headerBgView.bottom(), width: SCREEN_WIDTH, height: 0));
        
        self.rateBgView = UIView(frame: CGRect(x: 15, y: self.statusBgView.bottom() + 10, width: SCREEN_WIDTH - 30, height: 0));
        
        self.rateFavaLevelView = LoanTitleAndStarClickView(frame: CGRect(x: 0, y: 0, width: 215, height: 16));
        self.rateFavaLevelView?.titleLabel?.text = "费率满意度:";
        
        self.loanFavaLevelView = LoanTitleAndStarClickView(frame: CGRect(x: 0, y: (self.rateFavaLevelView?.bottom())! + 10, width: 215, height: 16));
        self.loanFavaLevelView?.titleLabel?.text = "贷款满意度:";
        self.processFavaLevelView = LoanTitleAndStarClickView(frame: CGRect(x: 0, y: (self.loanFavaLevelView?.bottom())! + 10, width: 215, height: 16));
        self.processFavaLevelView?.titleLabel?.text = "流程满意度:";
        self.rateBgView?.addSubview(self.rateFavaLevelView!);
        self.rateBgView?.addSubview(self.loanFavaLevelView!);
        self.rateBgView?.addSubview(self.processFavaLevelView!);
//        self.rateBgView.backgroundColor = COLOR_RED;
        
        self.rateBgView.frame = CGRect(x: 0, y: self.statusBgView.bottom() + 10, width: SCREEN_WIDTH - 30, height: 68);
        
        self.textView = CommonBaseTextView(frame: CGRect(x: -1, y: self.rateBgView.bottom() + 20, width: SCREEN_WIDTH + 2, height: 210));
        self.textView?.placeholder = "说说你的贷款经验， 可以帮到其他小伙伴哦";
        self.textView?.layer.borderWidth = 0.5;
        self.textView?.layer.borderColor = COLOR_BORDER.cgColor;
        self.textView?.placeholderFont = UIFont.systemFont(ofSize: 14);
        self.textView?.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 10, right: 10);
        self.textView.delegate = self;
        self.confirmCommentsBtn = UIButton(frame: CGRect(x: 0, y: self.textView.bottom() + 20, width: SCREEN_WIDTH, height: 50));
        self.confirmCommentsBtn.setTitle("确认点评", for: .normal);
        self.confirmCommentsBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17);
        self.confirmCommentsBtn.backgroundColor = COLOR_BLUE;
        self.confirmCommentsBtn.addTarget(self, action: #selector(confirmCommentsAction), for: .touchUpInside);
        
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(resinResponserAction));
        
        self.scrollView.addSubview(self.loanInforView);
        self.scrollView.addSubview(headerBgView);
        self.scrollView.addSubview(self.rateBgView);
        self.scrollView.addSubview(self.textView);
        self.scrollView.addSubview(self.confirmCommentsBtn);
        self.scrollView.addGestureRecognizer(self.tapGesture);
        
        self.commentPreService = CommentsPreService(delegate: self);
        self.commentPreService.getSubmitCommentInfo(productId: self.productId ?? "");
        self.commitCommentService = CommitCommentsService(delegate: self);

        // Do any additional setup after loading the view.
    }
    
   
    func onCompleteSuccess(service: BaseService) {
        if service == self.commentPreService {
            if self.commentPreService.statusList != nil {
                self.reloadStatusView();
            }
            if self.commentPreService.product != nil {
                self.reloadLoanSimpleInfo();
            }
        }else{
            self.dismiss(animated: true, completion: nil);
        }
        
        
    }
    
    func reloadLoanSimpleInfo(){
        self.loanInforView.iconImage.sd_setImage(with: CommonUtil.getURL(self.commentPreService.product?.productLogo ?? ""));
        self.loanInforView.titleLable.text = self.commentPreService.product?.productName;
    }
    
    func reloadStatusView(){
        let spaceWidth = CGFloat(10);
        let itemWidth = CGFloat((SCREEN_WIDTH - 6 * 10 - 10)/5);
        let itemHeight = CGFloat(30);
        var totalHeight = CGFloat(0);
        for (index,item) in (self.commentPreService.statusList?.enumerated())! {
            let a = index%5;
            
            let b = index/5;
            
            let button = TagButton(frame: CGRect(x: spaceWidth + 5 + (itemWidth + spaceWidth)*CGFloat(a), y: 10 + (itemHeight + 10)*CGFloat(b), width: itemWidth, height: itemHeight));
            
            button.addTarget(self, action: #selector(selectTagAction), for: .touchUpInside);
            button.tag = 222 + index;
            button.setSelectedTrueOrFalse(isSelected: false);
            button.setTitle(item, for: .normal);

            
            totalHeight = button.bottom();
            self.statusBgView?.addSubview(button);
        }
        
        self.statusBgView.frame = CGRect(x: 0, y: self.headerBgView.bottom(), width: SCREEN_WIDTH, height: totalHeight + 10);
        self.rateBgView.frame = CGRect(x: 0, y: self.statusBgView.bottom() + 10, width: SCREEN_WIDTH - 30, height: 68);
        self.textView.frame = CGRect(x: -1, y: self.rateBgView.bottom() + 20, width: SCREEN_WIDTH + 2, height: 210);
        self.confirmCommentsBtn.frame = CGRect(x: 0, y: self.textView.bottom() + 10, width: SCREEN_WIDTH, height: 50);
        self.scrollView.addSubview(self.statusBgView);
        self.scrollView.addSubview(self.rateBgView);
        self.scrollView.addSubview(self.textView);
        self.scrollView.addSubview(self.confirmCommentsBtn);
        self.scrollView.addGestureRecognizer(self.tapGesture);
        
    }
    
    func selectTagAction(action: UIButton){
        let action = action as! TagButton;
        self.selectedTagIndext = action.tag - 222 + 1;
        action.setSelectedTrueOrFalse(isSelected: true);
        
        for view in self.statusBgView.subviews {
            let view = view as! TagButton;
            if view != action {
                view.setSelectedTrueOrFalse(isSelected: false);
            }
        }
    }
    
    func confirmCommentsAction(){
        if LotteryUtil.isLogin() == false {
            LotteryUtil.shouldLogin();
            return;
        }
        self.textView.resignFirstResponder();
        
        if self.selectedTagIndext == -1 {
            ViewUtil.showToast(text: "请选择贷款状态");
            return;
        }
        
        self.commitCommentService.commitCommentsInfo(productId: self.productId, applyStatus: self.selectedTagIndext, content: self.textView.text, rateSatisfaction: self.rateFavaLevelView?.reviewStarView?.selectedIndex, loanSatisfaction: self.loanFavaLevelView?.reviewStarView?.selectedIndex, processSatisfaction: self.processFavaLevelView?.reviewStarView?.selectedIndex);
        
    }
    
    func resinResponserAction(){
        self.textView.resignFirstResponder();
        
    }
    
    
    
    func navBackAction(){
        self.dismiss(animated: true, completion: nil);
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
