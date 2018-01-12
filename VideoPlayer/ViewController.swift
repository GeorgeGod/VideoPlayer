//
//  ViewController.swift
//  VideoPlayer
//
//  Created by 虞嘉伟 on 2018/1/11.
//  Copyright © 2018年 虞嘉伟. All rights reserved.
//

import UIKit

extension UIColor {
    //创建随机色
    open static func randomColor() ->UIColor {
        let r = arc4random_uniform(255);
        let g = arc4random_uniform(255);
        let b = arc4random_uniform(255);
        return UIColor(displayP3Red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
    }
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let download = Download()
//        download.beginDownload()

        makeCollectionView()
    }
    
    func makeCollectionView() -> Void {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let screenWidth = UIScreen.main.bounds.size.width
        let itemWidth = screenWidth/2.0
        let itemHeight = 4/3*itemWidth
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        self.collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "ListCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath)
        
        
        
        return cell
    }
    
}

