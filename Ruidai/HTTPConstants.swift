//
//  HTTPConstants.swift
//  Lottery
//
//  Created by DTY on 2017/4/21.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class HTTPConstants: NSObject {
    
    /**   
     * Host
     */
//    static let HOST = "https://www.xingdk.com";
    
    /**
     * TestHost
     */
    static let HOST = "http://192.168.1.109:8080";
    
    /**
     * Test
     */
//    static let HOST = "http://test.xingdk.com";
    
    
    
    /**
     * Dev
     */
//    static let HOST = "http://con.xingdk.com";

    /**
     * WapHost
     */
    static let WAP_HOST = HOST + "/m";
    
    
    /**
     * HELP
     */
    static let HELP = "/help";
    static let HELP_GAME = WAP_HOST + HELP + "/game";
    static let HELP_DANTUO = WAP_HOST + HELP + "/dantuo";
    static let HELP_BANKCARD = WAP_HOST + HELP + "/bankCard";
    
    /**
     * Agreement/About
     */
    static let AGREEMENT = WAP_HOST + "/agreement";
    static let ABOUT = HOST + "/r" + "/about";
    static let ARTICLE = WAP_HOST + "/article/detail?articleId="
    
    /**
     * ApiHost
     */
    static let API_HOST = HOST + "/i";
    
    /**
     * APP
     */
    static let INITIAL = API_HOST + "/common/initial";

    /**
     * User
     */
    static let SEND_SMS = API_HOST + "/sms/send";
    static let SEND_VOICE_SMS = API_HOST + "/sms/voiceSend";
    static let LOGIN = API_HOST + "/user/login";
    static let LOGIN_BY_TOKEN = API_HOST + "/user/tokenLogin";
    static let LOGIN_BY_SMS = API_HOST + "/user/smsLogin";
    static let FORGET_PASSWORD = API_HOST + "/user/password/forget";
    static let CHANGE_PASSWORD = API_HOST + "/user/password/change";
    static let GET_TEMP_TOKEN = API_HOST + "/user/getTempToken";
    static let WX_LOGIN = API_HOST + "/user/weixinLogin";
    static let AVATAR_COMMIT = API_HOST + "/user/avatar";
    static let COMMIT_INFO = API_HOST + "/user/commitInfo";
    static let RESET_AVATAR = API_HOST + "/user/avatar";
    
    /**
     * Splash
     */
    static let SPLASH = API_HOST + "/index/splash";
    
    /**
     * Home
     */
    static let HOME = API_HOST + "/index/home";
    
    //applySucAd
    static let APPLYSUCAD = API_HOST + "/product/getPromotionAd";
    
    //ProductDetail
    
    static let PRODUCTDETAIL = API_HOST + "/product/detail";
    //simpleCommentInfo
    static let COMMENTPRE = API_HOST + "/comment/pre";
    //commitCommentInfo
    static let COMMENTCOMMIT = API_HOST + "/comment/commit";
    //filterconstants
    static let ACCURATEMATCHINFO = API_HOST + "/filter/constants";
    //loanMarket
    //FilterInfo
    static let FILTERINFO = API_HOST + "/filter/condition";
    static let FILTERLIST = API_HOST + "/product/list";
    
    //ActitvityPre
    static let ACTIVITYPRE = API_HOST + "/activity/pre";

    /**
     * Fuli
     */
    static let FULI = API_HOST + "/welfare/index";
    static let FULILIST = API_HOST + "/welfare/list";
    //commenList
    static let COMMENLIST = API_HOST + "/comment/list";
    ///apply/list
    /**
     * 申请列表
     */
    static let APPLYLIST = API_HOST + "/apply/list";
    static let APPLYCOMMIT = API_HOST + "/apply/commit";
    //统计
    static let APPSTATISTICS = API_HOST + "/statistics/app";
    static let PRODUCTSTATIS = API_HOST + "/product/detail/addClickCount";
    
    //幸运借贷列表
    
    static let LUCKLIST = API_HOST + "/apply/getLuckList";




    
    /**
     * News
     */
    static let NEWS = HOST + "/article/list.do"
    /**
     * Notice
     */
    static let NOTICE = API_HOST + "/index/notice";
    
    /**
     * Periods
     */
    static let PERIODS = API_HOST + "/index/periods";
    
    /**
     * BET
     */
    static let BET = API_HOST + "/bet";
    
    /**
     * ORDER
     */
    static let ORDER_ADD = API_HOST + "/order/add";
    static let ORDER_LIST = API_HOST + "/order/list";
    static let ORDER_DETAIL = API_HOST + "/order/detail";
    static let ORDER_CONTINUE_PAY = API_HOST + "/order/continueToPay";
    static let ORDER_CHECK_ORDER_PAY = API_HOST + "/order/checkOrderPay";
    
    /**
     * TICKET
     */
    static let TICKET_DETAIL = API_HOST + "/ticket/detail";
    
    /**
     * FOLLOW
     */
    static let FOLLOW_BUY = API_HOST + "/follow/followBuy";
    static let FOLLOW_LIST = API_HOST + "/follow/list";
    static let FOLLOW_DETAIL = API_HOST + "/follow/detail";
    
    /**
     * ACCOUNT
     */
    static let BALANCE = API_HOST + "/account/balance";
    static let BILL_LIST = API_HOST + "/account/billList";
    static let QUERY_BANK_CARD = API_HOST + "/account/queryBankCard";
    static let BIND_BANK_CARD = API_HOST + "/account/bindBankCard";
    static let QUERY_IDENTITY = API_HOST + "/account/queryIdentity";
    static let VERIFY_IDENTITY = API_HOST + "/account/verifyIdentity";
    static let WITHDRAW = API_HOST + "/account/withdraw";
    static let RED_PACKET_LIST = API_HOST + "/account/redPacketList";
    static let CHARGE = API_HOST + "/account/charge";
    static let CHECK_CHARGE_PAY = API_HOST + "/account/checkChargePay";
    static let FEEDBACK = API_HOST + "/common/feedback/commit";
    
    /**
     * PAY
     */
    static let PREPAY = API_HOST + "/pay/prepay";
}
