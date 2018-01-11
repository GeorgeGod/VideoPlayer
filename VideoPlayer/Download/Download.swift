//
//  Download.swift
//  VideoPlayer
//
//  Created by 虞嘉伟 on 2018/1/11.
//  Copyright © 2018年 虞嘉伟. All rights reserved.
//

import UIKit
import Alamofire


class Download: NSObject {

    var videoUrl:String = "https://d2.xia12345.com/down/2017/9/11001/17960036.mp4"
    
    var cancelledData:Data? //停止下载时保存已下载的部分
    
    var downloadRequest:DownloadRequest!
    
    let destination:DownloadRequest.DownloadFileDestination = {
        _, response in
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        print(documentURL)
        let fileURL = documentURL?.appendingPathComponent(response.suggestedFilename!)
        return (fileURL!, [.removePreviousFile, .createIntermediateDirectories])
    }
    
    func downloadProgress(progress:Progress){
//        self.progress.setProgress(Float(progress.fractionCompleted), animated: true)
        print("当前进度:\(progress.fractionCompleted*100)%")
    }
    
    func downloadResponse(response:DownloadResponse<Data>){
        switch response.result {
        case .success(let _):
            //下载完成
            DispatchQueue.main.async {
                print("路径:\(response.destinationURL?.path)")
//                let item = AVPlayerItem(url:URL(fileURLWithPath: (response.destinationURL?.path)!))
//                let play = AVPlayer(playerItem:item)
//                let playController = AVPlayerViewController()
//                playController.player = play
//                self.present(playController, animated: true, completion: {
//
//                })
            }
        case .failure(error:):
            self.cancelledData = response.resumeData //意外中止的话把已下载的数据存起来
            break
        }
    }
    
    //开始下载
    func beginDownload() -> Void {
        if let cancelledData = self.cancelledData {
            //续传
            self.downloadRequest = Alamofire.download(resumingWith: cancelledData, to: self.destination)
            self.downloadRequest.downloadProgress(closure: downloadProgress)
            self.downloadRequest.responseData(completionHandler: downloadResponse)
        } else {
            self.downloadRequest = Alamofire.download(self.videoUrl, to: self.destination)
            self.downloadRequest.downloadProgress(closure: downloadProgress)
            self.downloadRequest.responseData(completionHandler: downloadResponse)
        }
    }
    
    //取消下载
    func pauseDownload() -> Void {
        self.downloadRequest.cancel()
    }
}
