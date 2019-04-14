//
//  PhotoPreviewViewController.swift
//  PhotoPicker
//
//  Created by liangqi on 16/3/12.
//  Copyright © 2016年 dailyios. All rights reserved.
//

import UIKit
import Photos

struct PhotoImageModel: Equatable {
    
    var data: PHAsset?
    var image: UIImage?
    
    init(data:PHAsset?){
        self.data = data
    }
    init(image: UIImage) {
        self.image = image
    }
}

class PhotoPreviewViewController: UIViewController, PhotoPreviewCellDelegate {
    
    //MARK: - 声明区域
    typealias Block = (PhotoImageModel) -> Void
    var block: Block?
    var selectImages: [PhotoImageModel]?
    var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configCollectionView()
        self.configNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView?.setContentOffset(CGPoint(x: CGFloat(self.currentPage) * self.view.bounds.width, y: 0), animated: false)
        self.updatePageTitle()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return !UIApplication.shared.isStatusBarHidden
    }
    
    //MARK: - 私有成员
    private var collectionView: UICollectionView?
    private let cellIdentifier = "cellIdentifier"
    fileprivate lazy var v_nav: UIView = UIView()
    fileprivate lazy var btn_nav_back: UIButton = {
        let btn = UIButton()
        btn.setTitle("返回", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return btn
    }()
    fileprivate lazy var btn_nav_del: UIButton = {
        let btn = UIButton()
        btn.setTitle("删除", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.isHidden = true
        return btn
    }()
    fileprivate lazy var labl_nav_title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
}

//MARK: - 初始化
extension PhotoPreviewViewController {
    
    private func configNavigationBar(){
        view.addSubview(v_nav)
        v_nav.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 0.8)
        v_nav.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(v_nav.heightAnchor.constraint(equalToConstant: 44))
        view.addConstraint(v_nav.topAnchor.constraint(equalTo: view.topAnchor, constant: UIApplication.shared.statusBarFrame.height))
        view.addConstraint(v_nav.leftAnchor.constraint(equalTo: view.leftAnchor))
        view.addConstraint(v_nav.rightAnchor.constraint(equalTo: view.rightAnchor))
        v_nav.isHidden = true
        v_nav.addSubview(labl_nav_title)
        labl_nav_title.translatesAutoresizingMaskIntoConstraints = false
        v_nav.addConstraint(labl_nav_title.centerXAnchor.constraint(equalTo: v_nav.centerXAnchor))
        v_nav.addConstraint(labl_nav_title.centerYAnchor.constraint(equalTo: v_nav.centerYAnchor))
        v_nav.addSubview(btn_nav_back)
        btn_nav_back.translatesAutoresizingMaskIntoConstraints = false
        v_nav.addConstraint(btn_nav_back.leftAnchor.constraint(equalTo: v_nav.leftAnchor, constant: 20))
        v_nav.addConstraint(btn_nav_back.centerYAnchor.constraint(equalTo: v_nav.centerYAnchor))
        btn_nav_back.addTarget(self, action: #selector(action_back), for: .touchUpInside)
        v_nav.addSubview(btn_nav_del)
        btn_nav_del.translatesAutoresizingMaskIntoConstraints = false
        v_nav.addConstraint(btn_nav_del.leftAnchor.constraint(equalTo: v_nav.leftAnchor, constant: 20))
        v_nav.addConstraint(btn_nav_del.centerYAnchor.constraint(equalTo: v_nav.centerYAnchor))
        btn_nav_del.addTarget(self, action: #selector(PhotoPreviewViewController.eventRemoveImage), for: .touchUpInside)
    }
    
    private func updatePageTitle(){
        self.labl_nav_title.text =  String(self.currentPage+1) + "/" + String(self.selectImages!.count)
    }
    
    func configCollectionView(){
        self.collectionView?.contentInsetAdjustmentBehavior = .never
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width:self.view.frame.width,height: self.view.frame.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView!.isPagingEnabled = true
        self.collectionView!.scrollsToTop = false
        self.collectionView!.showsHorizontalScrollIndicator = false
        self.collectionView!.contentOffset = CGPoint(x:0, y: 0)
        self.collectionView!.contentSize = CGSize(width: self.view.bounds.width * CGFloat(self.selectImages!.count), height: self.view.bounds.height)
        
        self.view.addSubview(self.collectionView!)
        self.collectionView!.register(PhotoPreviewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
    }
}

//MARK: - 点击事件
extension PhotoPreviewViewController {
    
    func onImageSingleTap() {
        let status = !UIApplication.shared.isStatusBarHidden
        self.setNeedsStatusBarAppearanceUpdate()
        self.v_nav.isHidden = status
    }

    @objc func eventRemoveImage(){
        let element = self.selectImages?.remove(at: self.currentPage)
        self.updatePageTitle()
        if let _element = element {
            self.block?(_element)
        }
        
        if (self.selectImages?.count)! > 0{
            self.collectionView?.reloadData()
        } else {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func action_back() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: -  UICollectionViewDataSource + UICollectionViewDelegate
extension PhotoPreviewViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectImages!.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! PhotoPreviewCell
        cell.delegate = self
        if let model = self.selectImages?[indexPath.row] {
            if let asset = model.data {
                cell.renderModel(asset: asset)
            } else if let image = model.image {
                cell.renderModel(image: image)
            }
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        self.currentPage = Int(offset.x / self.view.bounds.width)
        self.updatePageTitle()
    }
}
