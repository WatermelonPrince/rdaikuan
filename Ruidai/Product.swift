//
//  Product.swift
//  Loan
//
//  Created by admin on 2017/8/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class Product: BaseModel {
    var productId: String?;
    var productName: String?;
    var productLogo: String?;
    var featureTagsList: Array<Tags>?;
    var recommendTagsList: Array<Tags>?;
    var authorizeTagsList: Array<Tags>?;
    
    var loanAmount: String?;
    var loanAmountTagsList: Array<Tags>?;
    var repayDays: String?;
    var repayDaysTagsList: Array<Tags>?;
    
    var monthRate: Double?;
    var dayRate: Double?;
    var averageAmount: String?;
    var requirements: String?;
    var applyFlowTagsList: Array<Tags>?;
    var auditDetail: String?;
    var guide: String?;
    var advantage: String?;
    var applyInterface : String?;
    var maxLoanAmount: String?;
    var positiveRate: String?;
    var productCount: String?;
    
    var strategyLink: String?
    var strategyImage: String?
    

}

class ProductDetailComponent : BaseModel{
    var titleStr : String?
    var contentStr : String?
    var applyFlowTagsList: Array<Tags>?;
    var type : Int?

}


