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
    @IBOutlet var buttonMenu: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!
    
    //MARK: further class varibales
    var slider: HorizontalItemList!
    var isMenuOpen = false
    var items:[Int] = [5, 6, 7]
    
    //MARK: class methods
    @IBAction func actionToggleMenu(_ sender: AnyObject) {
        for con in titleLabel.superview!.constraints {
            print("--> \(con.description)")
        }
        
        isMenuOpen = !isMenuOpen
        for constraint in titleLabel.superview!.constraints {
            if constraint.firstItem as? NSObject == titleLabel && constraint.firstAttribute == .centerX {
                constraint.constant = isMenuOpen ? -100.0 : 0.0
                continue
            }
            
            if constraint.identifier == "TitleCenterY" {
                constraint.isActive = false
                
                //add new constraint
                let newConstraint = NSLayoutConstraint(
                    item: titleLabel,
                    attribute: .centerY,
                    relatedBy: .equal,
                    toItem: titleLabel.superview!,
                    attribute: .centerY,
                    multiplier: isMenuOpen ? 0.67 : 1.0,
                    constant: 5.0)
                
                newConstraint.identifier = "TitleCenterY"
                newConstraint.isActive = true
                continue
            }
        }
            
        menuHeightConstraint.constant = isMenuOpen ? 200.0 : 60.0
        titleLabel.text  = isMenuOpen ? "Select Item" : "Packing List"
            
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10.0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
                
                let angel = self.isMenuOpen ? CGFloat(Double.pi/4) : 0.0
                self.buttonMenu.transform = CGAffineTransform(rotationAngle: angel)
                
            }, completion: nil)
            
        if isMenuOpen {
            slider = HorizontalItemList(inView: view)
            slider.didSelectItem = {index  in
                print("add\(index)")
                self.items.append(index)
                self.tableView.reloadData()
                self.actionToggleMenu(self)
            }
            self.titleLabel.superview!.addSubview(slider)
        } else {
            slider.removeFromSuperview()
        }
    }
        
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
}

let itemTitle = ["Icecream money", "Great weather", "Beach ball", "Swim suit for him", "Swim suit for her", "Beach games", "Ironing board", "Cocktail mood", "Sunglasses", "Flip flops"]

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: LifeCycle
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
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
        showItem(items[indexPath.row])
    }
    
    
    
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    
}


