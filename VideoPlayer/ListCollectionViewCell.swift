//
//  ListCollectionViewCell.swift
//  VideoPlayer
//
//  Created by 虞嘉伟 on 2018/1/12.
//  Copyright © 2018年 虞嘉伟. All rights reserved.
//

import UIKit
import SnapKit
import AVKit

class ListCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        self.contentView.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
//        let url = URL(string: "https://d2.xia12345.com/down/2017/9/11001/17960036.mp4")
//        
//        let image = getVideoImage(videoUrl: url!)
//        
//        imageView.image = image
        
        self.contentView.backgroundColor = UIColor.randomColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showImage() -> Void {
//        DispatchQueue.main
    }
    
    func getVideoImage(videoUrl: URL) -> UIImage {
        
        let avAsset = AVAsset.init(url: videoUrl)
        let generator = AVAssetImageGenerator.init(asset: avAsset)
        generator.appliesPreferredTrackTransform = true
        let time: CMTime = CMTimeMakeWithSeconds(0.0, 600) // 取第0秒， 一秒600帧
        var actualTime: CMTime = CMTimeMake(0, 0)
        let cgImage: CGImage = try! generator.copyCGImage(at: time, actualTime: &actualTime)
        
        return UIImage.init(cgImage: cgImage)
    }

}
