//
//  LoanActivityPreViewController.swift
//  Jubaodai
//
//  Created by zhaohuan on 2017/12/7.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanActivityPreViewController: CommonRefreshTableViewController,ServiceDelegate {
    var loanActivityPreService : LoanActivityPreService!
    var activityStepList: Array<ActivityStep>?
    var currentStep: Int = 1;
    var currentTableList: Array<InformationFieldVo>?
    var filterPickerView : MarketSecondFilterView?
    var leftBarItem : UIBarButtonItem!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftBarItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(backItemAction));
        self.navigationItem.backBarButtonItem = self.leftBarItem;
        self.tableView.mj_header.isHidden = true;
        self.tableView.mj_footer.isHidden = true;
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        self.loanActivityPreService = LoanActivityPreService(delegate: self);
        self.loanActivityPreService.getActivityPre(activityKey: "test_loan", client: "1");

        // Do any additional setup after loading the view.
    }
    
    //返回item动作事件
    func backItemAction(){
        if currentStep == 1 {
            self.navigationController?.popViewController(animated: true);
        }else{
            currentStep = currentStep - 1;
            let stepObj = self.activityStepList![self.currentStep - 1];
            guard let arr = stepObj.informationFieldVoList else{
                return
            }
            self.currentTableList = arr;
            self.tableView.reloadData();
        }
    }
    
 
    
    override func onCompleteSuccess(service: BaseService) {
        if service.isKind(of: LoanActivityPreService.classForCoder()) == true {
            guard let activityPreArr = self.loanActivityPreService.activityStepList else{
                return;
            }
            self.activityStepList = activityPreArr;
            self.reloadTableListWithCurrentStep(currntStep: self.currentStep);
        }
    }
    
    func reloadTableListWithCurrentStep(currntStep:Int){
        if self.activityStepList!.count > 0 {
            let stepObj = self.activityStepList![self.currentStep - 1];
            guard let arr = stepObj.informationFieldVoList else{
                return
            }
            self.currentTableList = arr;
            self.tableView.reloadData();
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.currentTableList?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = LoanActivityPreHeaderView(frame:CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44));
        view.seciton = section;
        view.clickHanlder = {
            (index) in
            let infoVo = self.currentTableList![index];
            var arrNames = Array<Tags>();
            guard let arr = infoVo.valueFieldTags else{
                return;
            }
            for value in arr{
                let obj  = value as TagsFieldVo;
                let tag = Tags();
                tag.tagsId = obj.tagsId;
                tag.name = obj.name;
                arrNames.append(tag);
            }
            if arrNames.count > 0 {
                self.filterPickerView = MarketSecondFilterView(frame: CGRect(x: 0, y: NAVIHEIGHT , width: SCREEN_WIDTH, height: SCREEN_HEIGHT - TABBARHEIGHT));
                self.filterPickerView?.reloadPickerViewWithArr(arr: arrNames);
                self.filterPickerView?.selectedAmountHanlder = {
                    (index,title) in
                    self.filterPickerView?.removeFromSuperview();
                    let tag = arr[index];
                    infoVo.selectedTagsId = tag.tagsId;
                    infoVo.hasSelected = true;
                    infoVo.value = title;
                    self.tableView.reloadData();
                    
                }
                
                self.showOrHiddenPickerView();
            }
          
            

            
        }
        view.backgroundColor = COLOR_RED;
        return view;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44;
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let infoVo = self.currentTableList![section];
        if infoVo.tagsType == 1 {
            if infoVo.hasSelected == true{
                guard let arr = infoVo.valueFieldTags else{
                    return 0 ;
                }
                for value in arr {
                    let obj = value as TagsFieldVo;
                    if obj.tagsId == infoVo.selectedTagsId{
                           guard let arr = obj.referenceList else{
                            return 0 ;
                        }
                        return arr.count;
                    }
                    
                }
            }else{
                return 0 ;
            }
        }else{
            return 0 ;
        }
        
        return 0;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        cell?.textLabel?.text = String(indexPath.row);
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44;
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showOrHiddenPickerView(){
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let parameters = self.getFilledParameters();
        let requirdKeys = self.getRequirdFieldKeys();
        let filledLabelText = self.getFilledLabelText();
        for item in requirdKeys {
            let key = item as String;
            if parameters[key] == nil || parameters[key] == ""{
                if filledLabelText[key] != nil {
                    ViewUtil.showToast(text: filledLabelText[key]! + "未填写！");
                    return;
                }
            }
        }
    }
    //获取必传parameter的key值数组集合
    func getRequirdFieldKeys() -> Array<String>{
        var requirdFieldKeys = Array<String>();
        for item in self.currentTableList! {
            let obj = item as InformationFieldVo;
            if obj.required! == 1{
                if obj.fieldName != nil && obj.fieldName != ""{
                    requirdFieldKeys.append(obj.fieldName!);
                }
            }
            if obj.tagsType == 1  && obj.hasSelected == true{
                
                guard let arr = obj.valueFieldTags else{
                    return requirdFieldKeys;
                }
                for value in arr {
                    let tag = value as TagsFieldVo;
                    if tag.tagsId == obj.selectedTagsId{
                        guard let arrRef = tag.referenceList else{
                            return requirdFieldKeys;
                        }
                        
                        for item in arrRef{
                            let reInfo = item as InformationFieldVo;
                            if reInfo.required! == 1{
                                if reInfo.fieldName != nil && reInfo.fieldName != ""{
                                    requirdFieldKeys.append(reInfo.fieldName!);
                                }
                            }
                        }
                    }
                }
                
                
            }else{
                
            }
        }
        return requirdFieldKeys;
    }
    
    //获取所有已填表单的parameter字典
    func getFilledParameters() ->  Dictionary<String, String>{
        var parameters = Dictionary<String, String>();
        for item in self.currentTableList! {
            let obj = item as InformationFieldVo;
            if obj.fieldName != nil && obj.value != nil && obj.value != ""{
                parameters[obj.fieldName!] = obj.value;
            }
            if obj.tagsType == 1  && obj.hasSelected == true{
                
                guard let arr = obj.valueFieldTags else{
                    return parameters;
                }
                for value in arr {
                    let tag = value as TagsFieldVo;
                    if tag.tagsId == obj.selectedTagsId{
                        guard let arrRef = tag.referenceList else{
                            return parameters;
                        }
                        
                        for item in arrRef{
                            let reInfo = item as InformationFieldVo;
                            if reInfo.fieldName != nil && reInfo.value != nil && reInfo.value != ""{
                                parameters[reInfo.fieldName!] = reInfo.value;
                            }
                        }
                    }
                }
                
                
            }else{
                
            }
        }
        return parameters;
    }
    
    func getFilledLabelText() ->  Dictionary<String, String>{
        var parameters = Dictionary<String, String>();
        for item in self.currentTableList! {
            let obj = item as InformationFieldVo;
            if obj.fieldName != nil && obj.name != nil && obj.name != ""{
                parameters[obj.fieldName!] = obj.name;
            }
            if obj.tagsType == 1  && obj.hasSelected == true{
                
                guard let arr = obj.valueFieldTags else{
                    return parameters;
                }
                for value in arr {
                    let tag = value as TagsFieldVo;
                    if tag.tagsId == obj.selectedTagsId{
                        guard let arrRef = tag.referenceList else{
                            return parameters;
                        }
                        
                        for item in arrRef{
                            let reInfo = item as InformationFieldVo;
                            if reInfo.fieldName != nil && reInfo.name != nil && reInfo.name != ""{
                                parameters[reInfo.fieldName!] = reInfo.name;
                            }
                        }
                    }
                }
                
                
            }else{
                
            }
        }
        return parameters;
    }
    
    // 获取parameter的key值对应的label提示文字
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
