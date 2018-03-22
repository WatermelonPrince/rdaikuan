//
//  InformationFieldVo.swift
//  Jubaodai
//
//  Created by zhaohuan on 2017/12/7.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class TagsFieldVo: BaseModel {
    var name: String?
    var value: String?
    var description: String?
    var referenceList: Array<InformationFieldVo>?
    var tagsId: Int?
    
    
    
}

class InformationFieldVo: BaseModel {
    var fieldName: String?
    var name: String?
    var placeholder: String?
    var required: Int?
    var tagsType: Int?
    var type: Int?
    var valueFieldTags: Array<TagsFieldVo>?
    var referenceList: Array<InformationFieldVo>?
    var hasSelected: Bool?
    var selectedTagsId: Int?
    var value: String?

  
}
