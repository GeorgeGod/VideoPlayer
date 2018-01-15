//
//  Path.swift
//  VideoPlayer
//
//  Created by 虞嘉伟 on 2018/1/15.
//  Copyright © 2018年 george. All rights reserved.
//

import UIKit

class Path: NSObject {
    
    //根据路径获取所有文件
    public static func obtainResources(_ extraPath:String?) -> [String] {
        
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        var path:String! = documentPath
        if let extra = extraPath {
            path = documentPath+extra
        }
        
        let enumerator = FileManager.default.enumerator(atPath: path)
        
        var count = 0
        var array : [String] = [String]()
        
        for fileName in enumerator! {
            count=count+1
            array.append(path + (fileName as! String))
        }
        return array
    }
}
