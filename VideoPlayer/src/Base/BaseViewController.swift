//
//  BaseViewController.swift
//  VideoPlayer
//
//  Created by admin on 2018/1/15.
//  Copyright © 2018年 george. All rights reserved.
//

import UIKit

protocol MakeTableViewProtocol {
    func makeTableView(_ superView:UIView) -> Void
}
protocol MakeCollectionViewProtocol {
    func makeCollectionView(_ superView:UIView) -> Void
}

extension MakeTableViewProtocol {
    func makeTableView(_ ctrl:UIViewController) -> UITableView! {
        let tb = UITableView(frame: CGRect(), style: .grouped)
        tb.delegate = ctrl as? UITableViewDelegate
        tb.dataSource = ctrl as? UITableViewDataSource
        ctrl.view.addSubview(tb)
        tb.snp_makeConstraints({ (m) in
            m.edges.equalToSuperview()
        })
        return tb
    }
}



class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
    }
}
