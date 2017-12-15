//
//  ViewController.swift
//  Animation03
//
//  Created by Winn on 2017/5/11.
//  Copyright © 2017年 Winn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: IB outlets
    @IBOutlet var tableView: UITableView!
    
    //MARK: further class varibales
    var items:[Int] = [5, 6, 7]
    var dataArray: NSMutableArray = []
    
    //MARK: class methods
    func showItem(_ index: Int) {
        print("tapped item \(index)")
        
        let imageView = UIImageView(image: UIImage(named: "summericons_100px_0\(index).png"))
        imageView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        
        let conX = imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let conBottom = imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: imageView.frame.height)
        let conWidth = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33, constant: -50.0)
        let conHeight = imageView.heightAnchor.constraint(
            equalTo: imageView.widthAnchor)
        NSLayoutConstraint.activate([conX, conBottom, conWidth, conHeight])
        view.layoutIfNeeded()
        
        
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
            conBottom.constant = -imageView.frame.size.height/2
            conWidth.constant = 0.0
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.8, delay: 1.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
            conBottom.constant = imageView.frame.size.height
            conWidth.constant = -50.0
            self.view.layoutIfNeeded()
        }, completion: {_ in
            imageView.removeFromSuperview()
        })
    }
    
    func addNav() {
        self.title = "Packing List"
    }
    func addData() {
        let sport = SportDetailModel()
        sport.sportDetailTitle = "Beach games"
        sport.sportDetailURL = "https://baike.baidu.com/item/%E6%B2%99%E6%BB%A9%E5%9F%8E%E5%A0%A1"
        dataArray.add(sport)
        
        let sport1 = SportDetailModel()
        sport1.sportDetailTitle = "Ironing board"
        sport1.sportDetailURL = "https://baike.baidu.com/item/%E6%B2%99%E6%BB%A9%E6%8E%92%E7%90%83/28225?fr=aladdin"
        dataArray.add(sport1)
        
        let sport2 = SportDetailModel()
        sport2.sportDetailTitle = "Cocktail mood"
        sport2.sportDetailURL = "https://baike.baidu.com/item/%E5%86%B7%E9%A5%AE"
        dataArray.add(sport2)
    }
}

let itemTitle = ["Icecream money", "Great weather", "Beach ball", "Swim suit for him", "Swim suit for her", "Beach games", "Ironing board", "Cocktail mood", "Sunglasses", "Flip flops"]

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: LifeCycle
    override func viewDidLoad() {
            super.viewDidLoad()
            addData()
            addNav()
            self.tableView?.rowHeight = 54.0
        }
    
    
    //MARK: TableViewMethods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.accessoryType = .none
        cell.textLabel?.text = itemTitle[items[indexPath.row]]
        cell.imageView?.image = UIImage(named: "summericons_100px_0\(items[indexPath.row]).png")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //showItem(items[indexPath.row])
        
        let detail = SportDetailViewController()
        detail.detailModel = dataArray[indexPath.row] as! SportDetailModel
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
}


