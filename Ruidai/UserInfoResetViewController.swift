//
//  UserInfoResetViewController.swift
//  Loan
//
//  Created by zhaohuan on 2017/9/13.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
import Photos


class UserInfoResetViewController: CommonRefreshTableViewController,ServiceDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate{
    var userService : UserService!
    var sheet:UIAlertController!
    var sourceType = UIImagePickerControllerSourceType.photoLibrary

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人设置";
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        self.userService = UserService(delegate: self);
        self.tableView.mj_footer.isHidden = true;
        self.hasNoMoreData = true;
        
        //Observer
        NotificationCenter.default.addObserver(self, selector: #selector(beginRefreshing), name: NSNotification.Name(rawValue:LoanMineTableViewController.userStatusChangeNotificationName), object: nil);
    }
    
    
    override func headerRefresh() {
        if LotteryUtil.isLogin() == false {
            self.tableView.mj_header.endRefreshing();
            self.tableView.reloadData();
            LotteryUtil.shouldLogin();
            return;
        }
        self.userService.getUser();
    }
    
    override func onCompleteSuccess(service: BaseService) {
        self.loadSuccess();
        self.tableView.reloadData();
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        if indexPath.row == 0 {
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14);
            cell?.textLabel?.textColor = COLOR_FONT_HEAD;
            cell?.textLabel?.text = "修改头像";
            cell?.accessoryType  = .disclosureIndicator;
            let avatarImageView = UIImageView(frame:CGRect(x: SCREEN_WIDTH - 80, y: 20, width: 40, height: 40));
            avatarImageView.layer.cornerRadius = 20;
            avatarImageView.layer.masksToBounds = true;
            cell?.contentView.addSubview(avatarImageView);
            avatarImageView.sd_setImage(with: CommonUtil.getURL(LotteryUtil.user()?.avatar ?? ""), placeholderImage: #imageLiteral(resourceName: "icon_avatar"));
            
            
        }else{
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14);
            cell?.textLabel?.textColor = COLOR_FONT_HEAD;
            cell?.accessoryType  = .disclosureIndicator;
            cell?.textLabel?.text = LotteryUtil.user()?.name ?? "";
        }
        return cell!;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80;
        }else{
            return 50;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        if indexPath.row == 0 {
            self.showPicker();
        }else{
            let edictVC = EdictUserInfoViewController();
            self.pushViewController(viewController: edictVC);
        }
    }
    
    
    //打开相机及相册选择器；
    func showPicker(){
        //判断设置是否支持图片库和相机
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) && UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)){
            
            sheet = UIAlertController(title: nil, message: "选择获取头像方式", preferredStyle: .actionSheet)
            
            //取消
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {(action) in
                print("取消")
            })
            sheet.addAction(cancelAction)
            
            
            //相册
            let OKAction = UIAlertAction(title: "相册", style: .default, handler: {(action) in
                if(self.PhotoLibraryPermissions() == true){
                    self.sourceType = UIImagePickerControllerSourceType.photoLibrary
                    self.open()
                }else{
                    //弹出提示框
                    self.sheet = UIAlertController(title: nil, message: "请在设置中打开相册权限", preferredStyle: .alert)
                    
                    let tempAction = UIAlertAction(title: "确定", style: .cancel) { (action) in
                        UIApplication.shared.openURL(URL(string:"App-Prefs:root=Privacy")!);
                        
                    }
                    self.sheet.addAction(tempAction)
                    self.present(self.sheet, animated: true, completion: nil)
                }
            })
            sheet.addAction(OKAction)
            
            
            //摄像头
            let destroyAction = UIAlertAction(title: "摄像头", style: .default, handler: { (action) in
                if(self.cameraPermissions() == true){
                    self.sourceType = UIImagePickerControllerSourceType.camera
                    self.open()
                }else {
                    //弹出提示框
                    self.sheet = UIAlertController(title: nil, message: "请在设置中打开摄像头权限", preferredStyle: .alert)
                    
                    let tempAction = UIAlertAction(title: "确定", style: .cancel) { (action) in
                        UIApplication.shared.openURL(URL(string:"App-Prefs:root=Photos")!);
                    }
                    self.sheet.addAction(tempAction)
                    self.present(self.sheet, animated: true, completion: nil)
                }
            })
            sheet.addAction(destroyAction)
            
        }
        
        self.present(self.sheet, animated: true, completion: nil)

    }
    
    
    //    打开图库或相机
    func open(){
        
        let imagePickerController:UIImagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true//true为拍照、选择完进入图片编辑模式
        imagePickerController.sourceType = sourceType
        self.present(imagePickerController, animated: true, completion:{
            
        })
        
    }
    
    /**
     判断相机权限
     
     - returns: 有权限返回true，没权限返回false
     */
    func cameraPermissions() -> Bool{
        
        let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        
        if(authStatus == AVAuthorizationStatus.denied || authStatus == AVAuthorizationStatus.restricted) {
            return false
        }else {
            return true
        }
        
    }
    
    /**
     判断相册权限
     
     - returns: 有权限返回ture， 没权限返回false
     */
    
    func PhotoLibraryPermissions() -> Bool {
        
        let library:PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        if(library == PHAuthorizationStatus.denied || library == PHAuthorizationStatus.restricted){
            return false
        }else {
            return true
        }
    }
    
    
    //    取消图片选择操作
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    //    选择完图片操作
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
//        img.image = image
        let path = "icon_avadar".cacheDir();
        do{
            try UIImagePNGRepresentation(image)?.write(to: URL(fileURLWithPath: path));
        } catch{
            
        }
        
        self.userService.resetAvatarImage(file: image, filePath: "icon_avadar");

        
        self.dismiss(animated: true, completion: nil)
        
    }

    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
