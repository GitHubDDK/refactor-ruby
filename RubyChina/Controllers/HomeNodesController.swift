//
//  HomeNodesController.swift
//  RubyChina
//
//  Created by 沈玉丽(YuLi Shen)-顺丰科技 on 2018/6/4.
//  Copyright © 2018年 Jianqiu Xiao. All rights reserved.
//

import UIKit
import SnapKit
import AFNetworking
import SwiftyJSON


let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


class HomeNodesController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var failureView = FailureView()
    var loadingView = LoadingView()
    var nodes: JSON = []
    var collectionView : UICollectionView?
    
    let headerHeight : CGFloat = 30
    let cellHeight:CGFloat = 40
    let headerIdentifier : String = "headView"
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "主节点"
        view.backgroundColor = Helper.backgroundColor
        
        initView()
        failureView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loadData)))
        view.addSubview(failureView)
        view.addSubview(loadingView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if nodes.count == 0 { loadData() }
        Helper.trackView(self)
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
    
    func loadData() {
        if loadingView.refreshing { return }
        failureView.hide()
        loadingView.show()
        let path = "/nodes/grouped.json"
        AFHTTPSessionManager(baseURL: Helper.baseURL).get(path, parameters: nil, progress: nil, success: { task, responseObject in
            self.loadingView.hide()
            self.nodes = self.topicsController() != nil ? [["title": "全部", "nodes": [["name": "社区"]]]] : []
            self.nodes = JSON(self.nodes.arrayValue + JSON(responseObject).arrayValue)
            self.collectionView?.reloadData()
            for i in 0 ..< self.nodes.count {
                for j in 0 ..< self.nodes[i]["nodes"].count {
                    let nodeId = self.nodes[i]["nodes"][j]["id"].intValue
                    if nodeId == self.topicsController()?.parameters["node_id"].intValue || nodeId == self.composeController()?.topic["node_id"].intValue{
                        self.collectionView?.scrollToItem(at: IndexPath(row: j, section: i), at: .top, animated: false)
                    }
                }
            }
        }) { task, error in
            self.loadingView.hide()
            self.failureView.show()
        }
    }
    
    //返回多少个组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return nodes.count
    }
    
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nodes[section]["nodes"].count
    }
    
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! HomeNodeCell
        let node = nodes[indexPath.section]["nodes"][indexPath.row]
        let title: String? = node["name"].string
        cell.titleLabel?.text = title
        return cell
        
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
            header.titleLabel?.text = nodes[indexPath.section]["title"].string
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
    

    func topicsController() -> TopicsController? {
        return navigationController?.viewControllers.filter { ($0 as? TopicsController) != nil }.last as? TopicsController
    }
    
    func composeController() -> ComposeController? {
        return navigationController?.viewControllers.filter { ($0 as? ComposeController) != nil }.last as? ComposeController
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
