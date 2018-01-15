//
//  RandomPicture.swift
//  VideoPlayer
//
//  Created by admin on 2018/1/13.
//  Copyright © 2018年 虞嘉伟. All rights reserved.
//

import UIKit

class RandomPicture: NSObject {

    open static func obtainRandomPicture() -> String {
        var picName : String!
        
        let bundlePath = Bundle.main.bundlePath
        let componse = "randomPics/"
        
        let path = bundlePath+"/"+componse
        let enumerator = FileManager.default.enumerator(atPath: path)
        
        var count = 0
        var array : [String] = [String]()
        
        for fileName in enumerator! {
            count=count+1
            array.append(componse + (fileName as! String))
        }
        
        let rand = random(0,count)
        picName = array[rand]
        return picName
    }
    
    private static func random(_ a:Int = 0, _ b:Int) -> Int {
        var num = arc4random_uniform(UInt32(b))
        if num < a {
            num = UInt32(random(a, b))
        }
        return Int(num)
    }
}
