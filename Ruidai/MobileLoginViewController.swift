//
//  MobileLoginViewController.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//
//手机号验证登录
import UIKit
class MobileBaseBottomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.setTitleColor(COLOR_BLUE, for: .normal);
        self.setTitleColor(CommonUtil.colorWithAlpha(color: COLOR_BLUE!, alpha: 0.5), for: .highlighted);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MobileLoginViewController: CommonBaseScrollViewController, ServiceDelegate,UITextFieldDelegate {
    var mobileView: MobileTextFieldView!;
    var passwordView: PasswordTextFieldView!;
    var loginButton: CommonBaseButton!;
    var registerButton: MobileBaseBottomButton!;
    var forgetButton: MobileBaseBottomButton!;
    
    var userService: UserService!;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "手机号登录";
        
        
        
        //手机号
        self.mobileView = MobileTextFieldView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: CommonBaseTextFieldView.baseHeight));
        self.scrollView.addSubview(self.mobileView);
        self.mobileView.iconImage.image = UIImage.init(named: "icon_loginphone");
        self.mobileView.textField.clearButtonMode = .whileEditing;
        self.mobileView.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged);
        
        //密码
        self.passwordView = PasswordTextFieldView(frame: CGRect(x: 0, y: self.mobileView.frame.maxY, width: self.view.frame.width, height: self.mobileView.frame.height));
        self.scrollView.addSubview(self.passwordView);
        self.passwordView.iconImage.image = UIImage.init(named: "icon_loginver");
        self.passwordView.codeInputStyleBtn.addTarget(self, action: #selector(showOrHiddenCodeAction), for: .touchUpInside);
        self.passwordView.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged);
        
        //登陆
        self.loginButton = CommonBaseButton(frame: CGRect(x: 20, y: self.passwordView.frame.maxY + 20, width: self.view.frame.width-20*2, height: self.mobileView.frame.height));
        self.loginButton.setTitle("登录", for: .normal);
        self.scrollView.addSubview(self.loginButton);
        self.loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside);
        self.loginButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_BORDER), for: .normal);
        self.loginButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_BLUE!), for: .selected);
        self.loginButton.isEnabled = self.loginButton.isSelected;
        
        //现在注册
        self.registerButton = MobileBaseBottomButton(frame: CGRect(x: self.loginButton.frame.minX, y: self.loginButton.frame.maxY + 20, width: 100, height: self.mobileView.frame.height - 10));
        self.registerButton.setTitle("现在注册>>", for: .normal);
//        self.scrollView.addSubview(self.registerButton);
        self.registerButton.addTarget(self, action: #selector(registerAction), for: .touchUpInside);
        
        //忘记密码
        self.forgetButton = MobileBaseBottomButton(frame: CGRect(x: self.view.frame.width - self.registerButton.frame.minX - self.registerButton.frame.width, y: self.registerButton.frame.minY, width: self.registerButton.frame.width, height: self.registerButton.frame.height));
        self.forgetButton.setTitle("忘记密码?", for: .normal);
        self.scrollView.addSubview(self.forgetButton);
        self.forgetButton.addTarget(self, action: #selector(forgetAction), for: .touchUpInside);
        
        self.userService = UserService(delegate: self);
        self.view.backgroundColor = COLOR_WHITE;
        


    }
    
    func textFieldDidChange(textField : UITextField) {
        if ((self.mobileView.textField.text! as NSString).length > 11) {
            ViewUtil.showToast(text: "请输入11位手机号码");
            let reduceStr = (self.mobileView.textField.text! as NSString).substring(to: 11);
            self.mobileView.textField.text = reduceStr;
        }
        if ((self.mobileView.textField.text! as NSString).length == 11) && ((self.passwordView.textField.text! as NSString).length > 0) {
            self.loginButton.isSelected = true;
            self.loginButton.isEnabled = true;
        }else{
            self.loginButton.isSelected = false;
            self.loginButton.isEnabled = false;
        }
    }
    
    
    
    func showOrHiddenCodeAction(action:UIButton){
        self.passwordView.codeInputStyleBtn.isSelected = !action.isSelected;
        self.passwordView.textField.isSecureTextEntry = !action.isSelected;

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onCompleteSuccess(service: BaseService) {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: LoanMineTableViewController.userStatusChangeNotificationName), object: self, userInfo: nil));
        self.dismiss(animated: true, completion: nil);
        LotteryUtil.saveIsWechatLogin(isWechatLogin: false);
    }
//登录/user/login
    func loginAction() {
        if (self.mobileView.textField.text == "") {
            ViewUtil.showToast(text: "请输入您的手机号");
        } else if (self.passwordView.textField.text == ""){
            ViewUtil.showToast(text: "请输入密码");
        } else {
            self.userService.login(mobile: self.mobileView.textField.text!, password: self.passwordView.textField.text!);
            self.mobileView.textField.resignFirstResponder();
            self.passwordView.textField.resignFirstResponder();
        }
    }
    
    
    //注册本版本去掉功能
    func registerAction() {
        let vc = LoanVerifyLoginViewController();
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    func forgetAction() {
        let vc = ForgetPasswordViewController();
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
}
