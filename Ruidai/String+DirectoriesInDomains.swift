//
//  String+DirectoriesInDomains.swift
//  Loan
//
//  Created by zhaohuan on 2017/9/12.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import Foundation



extension String{
    
    /**
     将当前字符串拼接到cache目录后面
     */
    func cacheDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        return (path as NSString).appendingPathComponent((self as NSString).lastPathComponent)
    }
    
    /**
     将当前字符串拼接到doc目录后面
     */
    func docDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        return (path as NSString).appendingPathComponent((self as NSString).lastPathComponent)
    }
    
    /**
     将当前字符串拼接到tmp目录后面
     */
    func tmpDir() -> String{
        let path = NSTemporaryDirectory() as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
}
