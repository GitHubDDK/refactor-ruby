//
//  HomeNodesController.swift
//  RubyChina
//
//  Created by 沈玉丽(YuLi Shen)-顺丰科技 on 2018/6/4.
//  Copyright © 2018年 Jianqiu Xiao. All rights reserved.
//

import UIKit
import SnapKit
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


class HomeNodesController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var collectionView : UICollectionView?
    var dataArr = NSMutableArray()//数据源
    var headerArr = NSMutableArray()//分组标题
    let headerHeight : CGFloat = 30
    let cellHeight:CGFloat = 40
    let headerIdentifier : String = "headView"
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Helper.backgroundColor
        
        initView()
        initData()
    }
    
    func initView(){
        let layout = UICollectionViewFlowLayout()
        self.view.backgroundColor = UIColor.white
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10.0 //设置行间距
        layout.itemSize = CGSize(width: (SCREEN_WIDTH - 50)/4, height: 40)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), collectionViewLayout: layout)
        //注册一个cell
        collectionView?.register(HomeNodeCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.backgroundColor = UIColor.white
        //设置每一个cell的宽高
        self.view.addSubview(collectionView!)
        //注册header
        collectionView?.register(HomeNodeHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
    }
    
    func initData(){
        initHeaderData()
        initSelectionData()
        self.collectionView?.reloadData()
    }
    
    //返回多少个组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return headerArr.count
    }
    
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 8
        case 1: return 2
        case 2: return 2
        default: return 0
        }

       // return dataArr.count
    }
    
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! HomeNodeCell
        let title = dataArr[indexPath.row]
        cell.titleLabel?.text = title as? String
        return cell
        
    }
    
    func initHeaderData() {
        
        headerArr.add("社区")
        headerArr.add("其他语言")
        headerArr.add("社交")
        
    }
    
    func initSelectionData() {
        
        dataArr.add("Ruby China")
        dataArr.add("Back-End")
        dataArr.add("Front-End")
        dataArr.add("活动")
        dataArr.add("其他语言")
        dataArr.add("图片")
        dataArr.add("娱乐")
        dataArr.add("科技")
        dataArr.add("selection 9")
        dataArr.add("selection 10")
        dataArr.add("selection 11")
        dataArr.add("selection 12")
        
    }
    
    //设置HeadView的宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: SCREEN_WIDTH, height: headerHeight)
    }
    
    //返回自定义HeadView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        var header = HomeNodeHeader()
        if kind == UICollectionElementKindSectionHeader{
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath as IndexPath) as! HomeNodeHeader
            let title:String = headerArr[indexPath.section] as! String
            header.titleLabel?.text = title
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath)
        cell!.layer.cornerRadius = 4
        cell?.backgroundColor = UIColor.yellow
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath)
        cell!.layer.cornerRadius = 4
        cell?.backgroundColor = UIColor.white
    }
    

    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
