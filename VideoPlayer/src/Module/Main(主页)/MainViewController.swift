//
//  MainViewController.swift
//  VideoPlayer
//
//  Created by admin on 2018/1/15.
//  Copyright © 2018年 george. All rights reserved.
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

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView: UICollectionView!
    var data:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "视频"
        
        makeCollectionView()
        addSwipeGesture()
        addLongPressGesture()
        findPicture()
        
        data = AVResouces.getLocalAVRes()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkDownloadURL()
    }
    
    func checkDownloadURL() -> Void {
        //系统级别
        let pasteboard:UIPasteboard = UIPasteboard.general
        print("复制板中的数据是:\(pasteboard.string ?? "")")
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
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath)
        
        return cell
    }
    
    func findPicture() -> String {
        var picName : String!
        
        let bundlePath = Bundle.main.bundlePath
        
        //        var path = bundlePath.components(separatedBy: "/randomPics/")
        let path = bundlePath+"/randomPics/"
        let enumerator = FileManager.default.enumerator(atPath: path)
        for fileName in enumerator! {
            print("文件名:\(fileName)")
            picName = fileName as! String
        }
        return picName
    }
    
    
    //添加左右手势
    func addSwipeGesture() -> Void {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(doSwipeGestureResponse(_:)))
        gesture.direction = .right
        self.view.addGestureRecognizer(gesture)
    }
    @objc func doSwipeGestureResponse(_ sender : UISwipeGestureRecognizer) -> Void {
        print("----")
    }
    //添加长按手势
    func addLongPressGesture() -> Void {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(doLongPressGesture(_:)))
        gesture.numberOfTouchesRequired = 1 //两指
        gesture.minimumPressDuration = 2 //两秒
        self.view.addGestureRecognizer(gesture)
    }
    @objc func doLongPressGesture(_ sender : UILongPressGestureRecognizer) -> Void {
        print("长按了")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ctrl = VideoPlayerViewController()
        ctrl.path = data[indexPath.row]
        self.navigationController?.pushViewController(ctrl, animated: true)
//        self.present(VideoPlayerViewController(), animated: true, completion: nil)
    }

}
