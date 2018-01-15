//
//  VideoView.swift
//  VideoPlayer
//
//  Created by 虞嘉伟 on 2018/1/14.
//  Copyright © 2018年 虞嘉伟. All rights reserved.
//

import UIKit
import AVKit

class VideoView: UIView {

    var playerItem:AVPlayerItem!
    var avplayer:AVPlayer!
    var playerLayer:AVPlayerLayer!
    
    //定时器
    var link:CADisplayLink!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = self.bounds
    }
    
    func makeVideoView(_ url:String) -> Void {
        let Url = URL(string: url)
        playerItem = AVPlayerItem(url: Url!)
        
        playerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        playerItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        avplayer = AVPlayer(playerItem: playerItem)
        
        playerLayer = AVPlayerLayer(player: avplayer)
        playerLayer.videoGravity = .resizeAspect
        playerLayer.contentsScale = UIScreen.main.scale
        self.layer.insertSublayer(playerLayer, at: 0)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let playerItem = object as! AVPlayerItem
        if keyPath == "loadedTimeRanges" {
            //缓冲进度
            // 通过监听AVPlayerItem的"loadedTimeRanges"，可以实时知道当前视频的进度缓冲
            let loadedTime = avalableDurationWithplayerItem()
            let totalTime = CMTimeGetSeconds(playerItem.duration)
            let percent = loadedTime/totalTime // 计算出比例
            print("缓冲进度：\(percent)")
            
        } else if keyPath == "status" {
            
            switch playerItem.status {
                case  .readyToPlay:
                    print("readyToPlay")
                    break
                case .unknown:
                    print("unknown")
                    break
                case .failed:
                    print("failed")
                    break
            }
            if playerItem.status == AVPlayerItemStatus.readyToPlay {
                self.avplayer.play()
                makeDisplayLink()
            } else {
                print("加载异常")
            }
        }
    }
    
    public func play() -> Void {
        avplayer.play()
    }
    
    func avalableDurationWithplayerItem()->TimeInterval{
        let timeRange = avplayer.currentItem?.loadedTimeRanges.first?.timeRangeValue
        let startSeconds = CMTimeGetSeconds((timeRange?.start)!)
        let durationSecound = CMTimeGetSeconds((timeRange?.duration)!)
        let result = startSeconds + durationSecound
        return result
    }
    
    func makeDisplayLink() -> Void {
        link = CADisplayLink(target: self, selector: #selector(displayCallback(_:)))
        link.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
    }
    @objc func displayCallback(_ link : CADisplayLink) -> Void {
        //当前播放时间
        let currentTime = CMTimeGetSeconds(avplayer.currentTime())
        
        //播放总时间；timescale表示压缩比例
        let totalTime = TimeInterval(playerItem.duration.value) / TimeInterval(playerItem.duration.timescale)
        let timeStr = "\(formatPlayTime(currentTime))/\(formatPlayTime(totalTime))"
        print(timeStr)
    }
    func formatPlayTime(_ secounds:TimeInterval) -> String {
        if secounds.isNaN {
            return "00:00"
        }
        let min = Int(secounds / 60)
        let sec = Int(secounds.truncatingRemainder(dividingBy: 60))//Int(secounds%60)
        return String(format: "%02d:%02d", min, sec)
    }
    
    
    func seekToTime(_ time:Int) -> Void {
        if avplayer.status == AVPlayerStatus.readyToPlay {
            let duration = time
            let seekTime = CMTimeMake(Int64(duration), 1)
            //指定视频位置
            avplayer.seek(to: seekTime, completionHandler: { (b) in
                //滑动完成
                
            })
        }
    }
}
