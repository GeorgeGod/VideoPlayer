//
//  DB.swift
//  VideoPlayer
//
//  Created by 虞嘉伟 on 2018/1/14.
//  Copyright © 2018年 虞嘉伟. All rights reserved.
//

import UIKit
import SQLite

class DB: NSObject {

    var tbname:String!
    
    var table:Table!
    var db:Connection!
    
    var id:Expression<Int64>! //索引
    var url:Expression<String>!//视频链接
    var name:Expression<String>! //视频名称
    var isDownload:Expression<Bool>! //是否已经下载
    var isDelete:Expression<Bool>! //是否已经删除
    var size:Expression<Int>! //视频大小
    var date:Expression<Date>! //添加时间
    var score:Expression<Int>! //评分
    
    required init(_ tbname: String="video") {
        super.init()
        self.tbname = tbname
    }
    
    //初始化数据库
    public func initDB() -> Void {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print("数据库路径:\(path)/db.sqlite3")
        
        //建数据库
        db = try? Connection("\(path)/db.sqlite3")
        
        //建表
        table = Table(tbname)
        
        //建列
        id = Expression<Int64>("id") //索引
        url = Expression<String>("url") //视频链接
        name = Expression<String>("name") //视频名称
        isDownload = Expression<Bool>("isDownload") //是否已经下载
        isDelete = Expression<Bool>("isDelete") //是否已经删除
        size = Expression<Int>("size") //视频大小
        date = Expression<Date>("date") //添加时间
        score = Expression<Int>("score") //评分
        
        _ = try? db.run(table.create(block: { (t) in
            t.column(id, primaryKey: true)
            t.column(url)
            t.column(name)
            t.column(isDownload)
            t.column(isDelete)
            t.column(size)
            t.column(date)
            t.column(score)
        }))
        
    }
    //增
    public func insert() -> Int64 {

        //将世界时间转换成中国时间
        let dt = Date()
        let timeZone = NSTimeZone.system
        let interval = timeZone.secondsFromGMT(for: dt)
        let localDate:Date = dt.addingTimeInterval(TimeInterval(interval))
        
        let insert = table.insert(
            url <- "https://d2.xia12345.com/down/2017/9/11001/17960036.mp4",
            name <- "17960036.mp4",
            isDownload <- false,
            isDelete <- false,
            size <- 0,
            date <- localDate,
            score <- 0
            )
        let rowId = try? db.run(insert)
        return rowId!
    }
    //删
    public func delete(_ rowId: Int64) -> Bool {
        let video = table.filter(id == rowId)
        
        let row:Int = try! db.run(video.delete())
        
        return row != 0
    }
    //改
    public func update(_ rowId: Int64) -> Bool {
        let video = table.filter(id == rowId)
        
        let row:Int = try! db.run(video.update(name <- name.replace("新名称", with:"123名称")))
        return row != 0
    }
    //查
    public func selectWithId(_ value: Int64) -> [Row] {
        var result:[Row] = [Row]()
        for item in try! db.prepare(table.filter(id == value)) {
            result.append(item)
        }
        return result
    }
}
