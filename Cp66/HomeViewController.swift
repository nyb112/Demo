//
//  HomeViewController.swift
//  Cp66
//
//  Created by NiYuanBo on 17/7/10.
//  Copyright © 2017年 HMKJ. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    var isLeft:Bool = false
    var centx:CGFloat = 0
    var coverView:UIView?
    var collection:UICollectionView?
    let titleArr:NSArray = NSArray.init(array: ["存取款","投注记录","优惠活动","在线客服"])
    let titleColor:NSArray = NSArray.init(array: [UIColor.init(valueStr: "ea986c"),UIColor.init(valueStr: "1296db"),UIColor.init(valueStr: "d81e06"),UIColor.init(valueStr: "1afa29")])
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "首页"
       
        let item:UIBarButtonItem = UIBarButtonItem.init(title: "22", style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickLeft(item:)))
        self.navigationItem.leftBarButtonItem = item
        centx = self.view.center.x
        let navViewWidth = self.navigationController?.view.bounds.size.width
        let navViewHeight = self.navigationController?.view.bounds.size.height
        coverView = UIView.init(frame: CGRect.init(x: 0, y: 64, width: navViewWidth!, height: navViewHeight! - 64))
        coverView?.backgroundColor = UIColor.lightGray
        coverView?.alpha = 0.3
        coverView?.isHidden = true
        let tapCover:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapCover(tap:)))
        coverView?.addGestureRecognizer(tapCover)
        self.navigationController?.view.addSubview(coverView!)
        
        
        
        self.navigationController?.view.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.view.layer.shadowOffset = CGSize.init(width: -1, height: -1)
        self.navigationController?.view.layer.shadowOpacity = 0.8
        
        let LayOut:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        
        
        
        collection = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), collectionViewLayout: LayOut)
        collection?.delegate = self
        collection?.dataSource = self
        collection?.register(UINib.init(nibName: "HomeHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collection?.register(UINib.init(nibName: "HotHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "hotheader")
        collection?.register(UINib.init(nibName: "HomeCenterCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collection?.register(UINib.init(nibName: "HomeTypeCell", bundle: nil), forCellWithReuseIdentifier: "typecell")
        collection?.backgroundColor = UIColor.init(red: 243/255, green: 244/255, blue: 246/255, alpha: 1)
        self.view.addSubview(self.collection!)
        
    }

   //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return titleArr.count
        }
        return 8
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell:HomeCenterCell = collection?.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCenterCell
            cell.tImage.image = UIImage.init(named: titleArr.object(at: indexPath.row) as! String )
            cell.name.text = titleArr.object(at: indexPath.row) as? String
            cell.name.textColor = titleColor.object(at: indexPath.row) as? UIColor
            cell.backgroundColor = UIColor.white
            return cell
        }else{
            let cell:HomeTypeCell = collection?.dequeueReusableCell(withReuseIdentifier: "typecell", for: indexPath) as! HomeTypeCell
            cell.backgroundColor = UIColor.white
            return cell
        }
        
        
    }
    //UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let header:HomeHeader = collection?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! HomeHeader
            return header
            
        }else{
            let header:HotHeader = collection?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "hotheader", for: indexPath) as! HotHeader
            return header
        }
    }
    
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3.5)
        }else{
            return CGSize.init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/20)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize.init(width: (UIScreen.main.bounds.size.width - 3)/4, height: (UIScreen.main.bounds.size.width - 3)/4*0.7)
        }else{
            return CGSize.init(width: (UIScreen.main.bounds.size.width - 1)/2, height: (UIScreen.main.bounds.size.width - 1)/4)
        }
    }
    //点击弹出抽屉效果
    
    func clickLeft(item:UIBarButtonItem) -> Void {
        self.isLeft = !self.isLeft
        var mx:CGFloat = 0
        
        if self.isLeft {
            mx = self.view.center.x + UIScreen.main.bounds.size.width*0.3
            UIView.animate(withDuration: 0.2) {
                self.navigationController?.view.center = CGPoint.init(x: mx, y: self.view.center.y)
                self.navigationController?.view.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
                
                self.coverView?.isHidden = false
            }
            
        }else{
            mx = centx
            
            UIView.animate(withDuration: 0.2) {
                self.navigationController?.view.center = CGPoint.init(x: mx, y: self.view.center.y)
                self.navigationController?.view.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.coverView?.isHidden = true
            }
            
        }
        

    }
    
    //点击蒙板
    func tapCover(tap:UITapGestureRecognizer) -> Void {
        self.clickLeft(item: UIBarButtonItem())
    }
    
    
    
}
