//
//  FeedbackViewController.swift
//  Lottery
//
//  Created by zhaohuan on 2017/8/7.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class FeedbackViewController: BaseViewController, ServiceDelegate ,UITextViewDelegate{
    var phoneTextField : UITextField?;
    var mailAddressTextField : UITextField?;
    var phoneLabel : UILabel?;
   
    var adviceTextView : CommonBaseTextView?;
    var feedbackService : FeedbackService!
    var actionButton: CommonBaseButton!;


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "用户反馈";
        self.phoneLabel = UILabel();
        self.phoneLabel?.textColor = COLOR_FONT_HEAD;
        self.phoneLabel?.frame = CGRect(x: 10, y: 10, width: self.view.frame.size.width/7, height: 24);
        self.phoneLabel?.text = "手机号:";
        self.phoneLabel?.textColor = COLOR_FONT_TEXT;
        self.phoneLabel?.font = UIFont.systemFont(ofSize: K_FONT_SIZE);
        self.phoneTextField = UITextField(frame: CGRect(x: ((self.phoneLabel?.frame.maxX)!
            + 25), y: 5, width: self.view.frame.size.width - (self.phoneLabel?.frame.maxX)! - 25, height: 39));
        self.phoneTextField?.placeholder = "请填写您的手机号，以便我们及时联系你";
        self.phoneTextField?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged);
//        [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        self.phoneTextField?.setValue(UIFont.systemFont(ofSize: 14), forKeyPath: "_placeholderLabel.font");
        self.phoneTextField?.keyboardType = .phonePad;
        
        let lineview = UIView(frame: CGRect(x: 0, y: 44, width: self.view.frame.size.width, height: 0.5));
        lineview.backgroundColor = COLOR_BORDER;
        


        
        let bgView = UIView(frame: CGRect(x: 0, y: 210, width: self.view.frame.size.width, height: 44.5));
        bgView.backgroundColor = COLOR_WHITE;
        bgView .addSubview(self.phoneLabel!);
        bgView.addSubview(self.phoneTextField!);
        bgView.addSubview(lineview);
       
        
        
        
        self.adviceTextView = CommonBaseTextView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200));
        self.adviceTextView?.placeholder = "您的问题描述越详细，我们就能越快解决哦！";
        self.adviceTextView?.placeholderFont = UIFont.systemFont(ofSize: 14);
        self.adviceTextView?.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10);
        self.adviceTextView?.backgroundColor = COLOR_WHITE;
        self.adviceTextView?.layer.borderWidth = 0.5;
        self.adviceTextView?.layer.borderColor = COLOR_BORDER.cgColor;
        self.adviceTextView?.layer.masksToBounds = true;
        self.adviceTextView?.delegate = self;
        
        self.view.addSubview(self.adviceTextView!);
        self.view.addSubview(bgView);
        
        
        self.actionButton = CommonBaseButton(frame: CGRect(x: 20, y: bgView.frame.maxY + 20, width: self.view.frame.width-20*2, height: 50));
        self.actionButton.setTitle("提交", for: .normal);
        self.actionButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside);
        
        self.actionButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_BORDER), for: .normal);
        self.actionButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_BLUE!), for: .selected);
        self.actionButton.isEnabled = self.actionButton.isSelected;
        self.view.addSubview(self.actionButton);
        self.feedbackService = FeedbackService(delegate: self);

    }
    
    func hahaha(){
        
    }
    
    
    func textFieldDidChange(textField : UITextField) {
        if ((self.phoneTextField!.text! as NSString).length > 11) {
            ViewUtil.showToast(text: "请输入11位手机号码");
            let reduceStr = (self.phoneTextField!.text! as NSString).substring(to: 11);
            self.phoneTextField?.text = reduceStr;
        }
        if ((self.phoneTextField!.text! as NSString).length == 11)  &&  ((self.adviceTextView!.text! as NSString).length > 0){
            self.actionButton.isSelected = true;
            self.actionButton.isEnabled = true;
        }else{
            self.actionButton.isSelected = false;
            self.actionButton.isEnabled = false;
        }
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        if ((self.phoneTextField!.text! as NSString).length > 11) {
            ViewUtil.showToast(text: "请输入11位手机号码");
            let reduceStr = (self.phoneTextField!.text! as NSString).substring(to: 11);
            self.phoneTextField?.text = reduceStr;
        }
        if ((self.phoneTextField!.text! as NSString).length == 11)  &&  ((self.adviceTextView!.text! as NSString).length > 0){
            self.actionButton.isSelected = true;
            self.actionButton.isEnabled = true;
        }else{
            self.actionButton.isSelected = false;
            self.actionButton.isEnabled = false;
        }
    }
    
    func submitAction(){
        if (self.adviceTextView?.text == nil || (self.adviceTextView?.text)! == "") {
            ViewUtil.showToast(text: "请填写你的建议");
            return;
        }
        self.feedbackService.commitFeedback(userId: (LotteryUtil.user()?.userId) ?? nil, mobile: self.phoneTextField?.text, name: nil, email: nil, message: (self.adviceTextView?.text)!);
    }
    
    func onCompleteSuccess(service: BaseService) {
        self.navigationController?.popViewController(animated: true);
        ViewUtil.showToast(text: "修改成功");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
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
