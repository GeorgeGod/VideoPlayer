//
//  VideoPlayerViewController.swift
//  VideoPlayer
//
//  Created by 虞嘉伟 on 2018/1/14.
//  Copyright © 2018年 虞嘉伟. All rights reserved.
//

import UIKit

class VideoPlayerViewController: UIViewController {

    var path:String!
    var videoView:VideoView!
    
//    convenience init(_ path: String) {
//        super.init()
//        self.path = path
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder)没有实现")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        videoView = VideoView()
        videoView.backgroundColor = UIColor.lightGray
//        let urlstr = "https://d2.xia12345.com/down/2017/9/11001/17960036.mp4"
        
        let urlstr = self.path!
        
        videoView.makeVideoView(urlstr)
        self.view.addSubview(videoView)
        videoView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
//            self.videoView.play()
//        }
        
    }
}
