//
//  ProfileViewController.swift
//  UINavigationController
//
//  Created by HongXiangWen on 2018/12/18.
//  Copyright © 2018年 WHX. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController: VGViewController,UITableViewDataSource,UITableViewDelegate {
    
    lazy var headerView : UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width * 0.75))
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage.init(named: "sunset")
        return imgView
    }()
    
    lazy var tableView : UITableView = {
        let table = UITableView(frame: view.bounds, style: UITableView.Style.plain)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.estimatedRowHeight = 0
        table.estimatedSectionHeaderHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.contentInsetAdjustmentBehavior = .never
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - UI Component
    override func addAllSubviews() {
        view.addSubview(self.headerView)
        view.addSubview(self.tableView)
        tableView.contentInset = UIEdgeInsets(top: view.bounds.width * 0.75, left: 0, bottom: 0, right: 0)
        customRightBarButtonItem(with: "PopToRoot")
    }
    
    override func addAllConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    private func adjustHeaderFrame() {
        let offsetY = tableView.contentOffset.y
        var originFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width * 0.75)
        if (offsetY + originFrame.height) <= 0 {
            let headHeight = -offsetY
            let headWidth = headHeight / 0.75
            let headOriginX =  -0.5 * (headWidth - view.bounds.width)
            originFrame = CGRect(x: headOriginX, y: 0, width: headWidth, height: headHeight)
        }
        headerView.frame = originFrame
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idfCell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let cell = (idfCell ?? (UITableViewCell.init(style: .subtitle, reuseIdentifier: "UITableViewCell")))
        cell.textLabel?.text = "个人中心 \(indexPath.row + 1)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let barHiddenVC = ViewController()
        navigationController?.pushViewController(barHiddenVC, animated: true)
    }

    // MARK: - Main Method
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        adjustHeaderFrame()
    }
    
    override func navigationBarRightAction() {
        navigationController?.popToRootViewController(animated: true)
    }

}
