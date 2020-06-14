//
//  MainViewController.swift
//  FirebaseExample
//
//  Created by 이가영 on 2020/06/11.
//  Copyright © 2020 이가영. All rights reserved.
//

import UIKit
import Firebase
import SnapKit

class PeopleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var array: [UserModel] = []
    var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (m) in
            m.top.equalTo(view).offset(0)
            m.bottom.left.right.equalTo(view)
             
        }
        
        Database.database().reference().child("users").observe(DataEventType.value) { (snapshot) in
            self.array.removeAll()
            
            for child in snapshot.children{
                let fchild = child as! DataSnapshot
                let userModel = UserModel()
                
                UserModel.setValuesForKeys(fchild.value as! [String : Any])
                self.array.append(userModel)
            }
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let imageview = UIImageView()
        cell.addSubview(imageview)
        imageview.snp.makeConstraints { (m) in
            m.centerY.equalTo(cell)
            m.left.equalTo(cell)
            m.height.width.equalTo(50)
        }
        
        URLSession.shared.dataTask(with: URL(string: array[indexPath.row].profileImageUrl!)!) { (data, response, err) in
            DispatchQueue.main.async {
                imageview.image = UIImage(data: data!)
                imageview.layer.cornerRadius = imageview.frame.size.width/2
                imageview.clipsToBounds = true
                
            }
        }.resume()
        
        let label = UILabel()
        cell.addSubview(label)
        label.snp.makeConstraints { (m) in
            m.centerY.equalTo(cell)
            m.left.equalTo(imageview.snp.right).offset(30)
        }
        
        label.text = array[indexPath.row].userName
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    


}
