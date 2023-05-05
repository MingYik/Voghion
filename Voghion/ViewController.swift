//
//  ViewController.swift
//  Voghion
//
//  Created by apple on 2021/12/11.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: VGViewController {
    
    lazy var gifImgView : UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .lightGray
        return imgView
    }()
    lazy var webPImgView : UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .lightGray
        return imgView
    }()
    lazy var popImgView : UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .lightGray
        return imgView
    }()
    
    lazy var backBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitle("Back To Last", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    lazy var nextBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitle("Push To Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        return button
    }()
    
    lazy var mainView: UIView = {
        let mainV = UIView.init(frame: view.bounds)
        return mainV
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView.init(frame: view.bounds)
        scrollV.contentSize = CGSize.init(width: view.bounds.width, height: (view.bounds.height*2))
        scrollV.contentInsetAdjustmentBehavior = .never
        return scrollV
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vg_prefersNavigationBarHidden = true
        addSubviews()
    }
 
    override func viewDidAppear(_ animated: Bool) {
     super.viewDidAppear(animated) //https://wcnft.mypinata.cloud/ipfs/QmWUNNdJreL7mYmXoSSyFFV9N5b7z4sUUGujwhwfHuda25
        gifImgView.kf.setImage(with: URL(string:"http://i.imgur.com/uoBwCLj.gif"))
        
        webPImgView.kf.setImage(with: URL(string:"http://littlesvr.ca/apng/images/Contact.webp"))

        popImgView.kf.setImage(with: URL(string:"https://images.voghion.com/productImages/90d3daf83cd24329b516d511f8d6bd89.png"))
        
        guard let idfaStr = VGKeyChain.keyChainReadData(identifier: "IDFA") else {
            return
        }
        NSLog("This is idfa of Thorgroup: " + idfaStr)
    }

    
    func addSubviews() {
        view.backgroundColor = .lightGray
        view.addSubview(self.scrollView)
        scrollView.addSubview(self.mainView)
        mainView.addSubview(self.gifImgView)
        mainView.addSubview(self.webPImgView)
        mainView.addSubview(self.popImgView)
        mainView.addSubview(self.backBtn)
        mainView.addSubview(self.nextBtn)
        
        gifImgView.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.left.right.equalTo(0)
            make.height.equalTo(150)
        }
        
        webPImgView.snp.makeConstraints { make in
            make.top.equalTo(gifImgView.snp.bottom).offset(15)
            make.left.right.equalTo(0)
            make.height.equalTo(150)
        }
        
        popImgView.snp.makeConstraints { make in
            make.top.equalTo(webPImgView.snp.bottom).offset(15)
            make.left.right.equalTo(0)
            make.height.equalTo(150)
        }
        
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(popImgView.snp.bottom).offset(15)
            make.left.right.equalTo(0)
            make.height.equalTo(40)
        }
        
        nextBtn.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom).offset(15)
            make.left.right.equalTo(0)
            make.height.equalTo(40)
        }
    }
    
    //MARK: - Main Method
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }

    @objc func nextAction() {
        let demoVC = VGPageVC()
        navigationController?.pushViewController(demoVC, animated: true)
    }
    
}

