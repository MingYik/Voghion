//
//  VGPageVC.swift
//  Voghion
//
//  Created by apple on 2022/6/22.
//

import UIKit
import Kingfisher

class VGPageVC: VGViewController {
    typealias ColorClosure = (UIColor) -> Void
    
    lazy var barColorBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitle("Bar Color", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(barColorBtnClicked), for: .touchUpInside)
        return button
    }()

    lazy var barImageBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitle("Hello World !", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(barImageSwitchChanged), for: .touchUpInside)
        return button
    }()
    
    lazy var barStyleBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitle("Check CRC16", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(blackBarStyleSwitchChanged), for: .touchUpInside)
        return button
    }()
    
    lazy var barShadowBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitle("Start BlueTooth", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(shadowHiddenSwitchChanged), for: .touchUpInside)
        return button
    }()
    
    lazy var barAlphaLab: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        label.text = "Bar Alpha: 1.00"
        return label
    }()
    
    lazy var barAlphaSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 1
        slider.addTarget(self, action: #selector(barAlphaSliderChanged), for: .valueChanged)
        return slider
    }()
    
    lazy var barTintBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitle("Tint Color", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(tintColorBtnClicked), for: .touchUpInside)
        return button
    }()
    
    
    lazy var barTitleBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitle("Title Color", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(titleColorBtnClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var pushBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitle("Push To Next", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(pushToNext), for: .touchUpInside)
        return button
    }()
    
    
    lazy var presentBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(present(sender:)), for: .touchUpInside)
        return button
    }()
    
    
    lazy var dismissBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(dismiss(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var gifImgView: UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.init(x: 30, y: 120, width: 45, height: 30))
        let path = Bundle.main.path(forResource:"referral", ofType:"gif")
        if let gifPath = path {
            let gifUrl = URL(fileURLWithPath: gifPath)
            let provider = LocalFileImageDataProvider(fileURL: gifUrl)
            imageView.kf.setImage(with: provider)
        }
        return imageView
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
        title = "首页\(navigationController!.viewControllers.count)"
        if navigationController!.viewControllers.count % 2 == 0 {
            view.backgroundColor = .white
        } else {
            view.backgroundColor = .green
        }
    }
    
    //MARK: - UI Component
    override func addAllSubviews() {
        view.addSubview(self.scrollView)
        scrollView.addSubview(self.mainView)
        mainView.addSubview(self.barColorBtn)
        mainView.addSubview(self.barImageBtn)
        mainView.addSubview(self.barStyleBtn)
        mainView.addSubview(self.barShadowBtn)
        mainView.addSubview(self.barAlphaLab)
        mainView.addSubview(self.barAlphaSlider)
        mainView.addSubview(self.barTintBtn)
        mainView.addSubview(self.barTitleBtn)
        mainView.addSubview(self.gifImgView)
        mainView.addSubview(self.pushBtn)
        mainView.addSubview(self.presentBtn)
        mainView.addSubview(self.dismissBtn)
        customRightBarButtonItem(with: "Profile")
    }
    
    override func addAllConstraints() {
        barColorBtn.snp.makeConstraints { make in
            make.top.equalTo(130)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(42)
        }
        
        barImageBtn.snp.makeConstraints { make in
            make.top.equalTo(barColorBtn.snp.bottom).offset(10)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(42)
        }
        
        barStyleBtn.snp.makeConstraints { make in
            make.top.equalTo(barImageBtn.snp.bottom).offset(10)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(42)
        }
        
        barShadowBtn.snp.makeConstraints { make in
            make.top.equalTo(barStyleBtn.snp.bottom).offset(10)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(42)
        }
        
        barAlphaLab.snp.makeConstraints { make in
            make.top.equalTo(barShadowBtn.snp.bottom).offset(10)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(32)
        }
        
        barAlphaSlider.snp.makeConstraints { make in
            make.top.equalTo(barAlphaLab.snp.bottom)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(20)
        }
        
        barTintBtn.snp.makeConstraints { make in
            make.top.equalTo(barAlphaSlider.snp.bottom).offset(15)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(42)
        }
        
        barTitleBtn.snp.makeConstraints { make in
            make.top.equalTo(barTintBtn.snp.bottom).offset(10)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(42)
        }
        
        pushBtn.snp.makeConstraints { make in
            make.top.equalTo(barTitleBtn.snp.bottom).offset(10)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(42)
        }
        
        presentBtn.snp.makeConstraints { make in
            make.top.equalTo(pushBtn.snp.bottom).offset(10)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(42)
        }
        
        dismissBtn.snp.makeConstraints { make in
            make.top.equalTo(presentBtn.snp.bottom).offset(10)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(42)
        }
    }
    
    //MARK: - Main Method
    func showColorSheet(_ title:String, _ handler:@escaping ColorClosure) {
        
        let showAlert = UIAlertController.init(title: title, message: .none, preferredStyle: .actionSheet)
          
        let redAction = UIAlertAction.init(title: "Red", style: .default) { UIAlertAction in
            handler(.red)
        }
        let greenAction = UIAlertAction.init(title: "Green", style: .default) { UIAlertAction in
            handler(.green)
        }
        let blueAction = UIAlertAction.init(title: "Blue", style: .default) { UIAlertAction in
            handler(.blue)
        }
        let yellowAction = UIAlertAction.init(title: "Yellow", style: .default) { UIAlertAction in
            handler(.yellow)
        }
        let blackAction = UIAlertAction.init(title: "Black", style: .default) { UIAlertAction in
            handler(.black)
        }
        let whiteAction = UIAlertAction.init(title: "White", style: .default) { UIAlertAction in
            handler(.white)
        }
        let cancelAction = UIAlertAction.init(title: "cancel", style: .destructive)
        showAlert.addAction(redAction)
        showAlert.addAction(greenAction)
        showAlert.addAction(blueAction)
        showAlert.addAction(yellowAction)
        showAlert.addAction(blackAction)
        showAlert.addAction(whiteAction)
        showAlert.addAction(cancelAction)
        present(showAlert, animated: true, completion: nil)
    }
    
    func showSwitchSheet(_ title:String, _ handler:@escaping (Bool) -> Void) {
        
        let showAlert = UIAlertController.init(title: title, message: .none, preferredStyle: .actionSheet)
          
        let yesAction = UIAlertAction.init(title: "YES", style: .default) { UIAlertAction in
            handler(true)
        }
        let noAction = UIAlertAction.init(title: "NO", style: .default) { UIAlertAction in
            handler(false)
        }
        let cancelAction = UIAlertAction.init(title: "cancel", style: .destructive)

        showAlert.addAction(yesAction)
        showAlert.addAction(noAction)
        showAlert.addAction(cancelAction)
        present(showAlert, animated: true, completion: nil)
    }
    
    @objc func barColorBtnClicked(_ sender: UIButton) {
        showColorSheet("BarColor") { color in
            sender.backgroundColor = color
        }
    }
    
    @objc func barImageSwitchChanged(_ sender: UISwitch) {

    }
    
    @objc func blackBarStyleSwitchChanged(_ sender: UISwitch) {
    }
    
    @objc func shadowHiddenSwitchChanged(_ sender: UISwitch) {
    }
    
    @objc func barAlphaSliderChanged(_ sender: UISlider) {
        barAlphaLab.text = String(format: "%.2f", sender.value)
    }
    
    @objc func tintColorBtnClicked(_ sender: UIButton) {
        showColorSheet("TintColor") { color in
            sender.backgroundColor = color
        }
    }
    
    @objc func titleColorBtnClicked(_ sender: UIButton) {
        showColorSheet("TitleColor") { color in
            sender.backgroundColor = color
        }
    }
    
    @objc func pushToNext(_ sender: Any) {
        let demoVC = VGPageVC()
        navigationController?.pushViewController(demoVC, animated: true)
    }
    
    @objc func present(sender: Any) {
        let demoVC = VGPageVC()
        let nav = UINavigationController.init(rootViewController: demoVC)
        present(nav, animated: true, completion: nil)
    }
    
    @objc func dismiss(sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func navigationBarRightAction() {
        let demoVC = ProfileViewController()
        navigationController?.pushViewController(demoVC, animated: true)
    }

}

