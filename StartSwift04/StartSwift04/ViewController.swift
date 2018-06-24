//
//  ViewController.swift
//  StartSwift04
//
//  Created by Winn on 2017/12/18.
//  Copyright © 2017年 Winn. All rights reserved.
//

import UIKit
import Alamofire


struct MovieDetailModel: Decodable {
    var category : String
    var group_url : String
    var image_url : String
    var objectId : String
    var thumb_url : String
    var title: String
}

struct MovieStore: Decodable {
    var category:String
    var page: Int
    var results: [MovieDetailModel]
}

enum SSError: Error {
    case message(String)
}
struct SSDecoder {
    //TODO:转换模型
    static func decode<T>(_ type: T.Type, param: [String:Any]) throws -> T where T: Decodable{
        guard let jsonData = self.getJsonData(with: param) else {
            throw SSError.message("转换data失败")
        }
        guard let model = try? JSONDecoder().decode(type, from: jsonData) else {
            throw SSError.message("转换模型失败")
        }
        return model
    }
    static func getJsonData(with param: Any)->Data?{
        if !JSONSerialization.isValidJSONObject(param) {
            return nil
        }
        guard let data = try? JSONSerialization.data(withJSONObject: param, options: []) else {
            return nil
        }
        return data
    }
}


class ViewController: UIViewController {
    var dataArray: NSMutableArray = []

    func addNav() {
        title = "Picture Show"
    }
    
    lazy var detailTableView: UITableView = {
        let table = UITableView(frame: CGRect(x:0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .plain)
        
        table.delegate = self
        table.dataSource = self
        table.register(MoviePreviewCell.self, forCellReuseIdentifier: "MoviePreviewCell")
        return table
    }()

}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addNav()
        view.addSubview(detailTableView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.hud.showLoading("加载中")
        Alamofire.request("https://meizi.leanapp.cn/category/QingXin/page/1").responseJSON { response in
            
            self.view.hud.dismiss()
            switch response.result.isSuccess {
                
            case true:
                
                if let dic = response.result.value as? [String: AnyObject],

                    //遍历数组得到每一个字典模型
                    let items = dic["results"] as? [[String: AnyObject]] {
                    print("items --is %@",items)

                    for dict in items {
                        let model = try? SSDecoder.decode(MovieDetailModel.self, param:dict)
                        print("dict --is %@",dict)
                        self.dataArray.add(model)
                    }
                    self.detailTableView.reloadData()
                }
                
            case false:
                
                print(response.result.error)
                
            }
            
        }
    }

    
    
    //MARK: TableViewMethods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.width+30
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviePreviewCell", for: indexPath) as! MoviePreviewCell
        
        let model = dataArray[indexPath.row]

        cell.album = model as? MovieDetailModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = MovieDetailController()
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

