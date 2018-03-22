//
//  config.swift
//  Lottery
//
//  Created by DTY on 17/1/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import Foundation
import UIKit

let APPLYSUCNOTI = "applySucNotification"


let KEY_WINDOW = UIApplication.shared.keyWindow!;
let SCREEN_WIDTH = UIScreen.main.bounds.size.width;
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height;
let K_FONT_SIZE:CGFloat = (SCREEN_WIDTH <= 320) ? 13 : 14;
let BANNER_HEIGHT = SCREEN_WIDTH/1080*400;
let BALL_WIDTH = SCREEN_WIDTH/(7+8*0.3);
let RATIO = SCREEN_WIDTH<375 ? (SCREEN_WIDTH/375) : 1;
let NAVIHEIGHT = CGFloat(SCREEN_HEIGHT < 812 ? 64 : 88);
let TABBARHEIGHT = CGFloat(SCREEN_HEIGHT < 812 ? 49 : 83);
let FOOTERSAFEHEIGHT = CGFloat(SCREEN_HEIGHT < 812 ? 0 : 34);


let COLOR_WHITE = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
//let COLOR_BLUE = UIColor(colorLiteralRed: 40/255, green: 130/255, blue: 214/255, alpha: 1);
let COLOR_BLUE = HexColorTransform().transformFromJSON("#01b09a");
let COLOR_BLUE_BUTTON = HexColorTransform().transformFromJSON("#01b09a");
let COLOR_BLUE_NAV = HexColorTransform().transformFromJSON("#01b09a");
let COLOR_ORANGE = HexColorTransform().transformFromJSON("#eb6100");
let COLOR_ORANGEGROUND = HexColorTransform().transformFromJSON("#f6b600");

let COLOR_BLACK = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.09803921569, alpha: 1);
let COLOR_RED = #colorLiteral(red: 1, green: 0.3490196078, blue: 0.3490196078, alpha: 1);
let COLOR_YELLOW = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.3450980392, alpha: 1);
let COLOR_LIGHT_YELLOW = #colorLiteral(red: 0.9882352941, green: 0.9843137255, blue: 0.831372549, alpha: 1);
let COLOR_BROWN = UIColor.brown;
let COLOR_GROUND = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9764705882, alpha: 1);
let COLOR_FITERGROUD = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03921568627, alpha: 1)
let COLOR_FONT_HEAD = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1);
let COLOR_FONT_TEXT = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1);
let COLOR_FONT_SECONDARY = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1);
let COLOR_BORDER = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1);
let COLOR_SECONDARY_BORDER = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1);
let COLOR_MASK = UIColor(white: 0.0, alpha: 0.3);
let COLOR_WECHAT = #colorLiteral(red: 0.2352941176, green: 0.6901960784, blue: 0.2039215686, alpha: 1);

let COLOR_TAG_BLUE = #colorLiteral(red: 0.4784313725, green: 0.7411764706, blue: 0.9529411765, alpha: 1);
let COLOR_TAGGROUND_BLUE = #colorLiteral(red: 0.9137254902, green: 0.9607843137, blue: 1, alpha: 1);
let COLOR_TAGTEXT_YELLOW = #colorLiteral(red: 0.9568627451, green: 0.7490196078, blue: 0.5254901961, alpha: 1);
let COLOR_TAGBORDER_YELLOW = #colorLiteral(red: 1, green: 0.8705882353, blue: 0.7333333333, alpha: 1);
let COLOR_TAGGROUND_YELLOW = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.9137254902, alpha: 1);
let COLOR_TAGGROUNG = HexColorTransform().transformFromJSON("#dae1e4");

let COLOR_BUTTON_GROUND = HexColorTransform().transformFromJSON("#e7f6f4");

let COLOR_LIGHT_GREEN = HexColorTransform().transformFromJSON("#effffd");

//HexColorTransform().transformFromJSON("#fff9e9")

let NOTICE_STATE = "noticeState";

let DIMEN_BORDER:CGFloat = 0.5;

let DOTS_SYMBOL:String = "•••";

let WECHAT_ID = "wx2204a1a488ff5325";
let GROWINGIO_ID = "bd46af1b14c2b9d4";
let BUGLY_ID = "20b7b3dbc6";

//getui正式
let kGtAppId:String = "zLO5RizGGn6qMgSdyWfVd1"
let kGtAppSecret:String = "4DV2Tz2WgeAkQPS1weHNG6"
let kGtAppKey:String = "BTUH5HHB6Q9CwO8GChcrC7"
//友盟key
//测试
//let uMengKey:String = ""
//正式
let uMengKey:String = "59a7e0c81061d21a0100026c"







struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}
