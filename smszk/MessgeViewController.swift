//
//  MessgeViewController.swift
//  smszk
//
//  Created by LeonJing on 2019/2/18.
//  Copyright © 2019 LeonJing. All rights reserved.
//

import UIKit
import HandyJSON

class MessgeViewController: UITableViewController {
    
    private var data:MessageModel?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    private var parms:[String:Any?]?
    
    private var phone:String?{
        get{
            return parms?["phone"] as? String
        }
    }
    
    convenience init(parms:[String:Any?]?) {
        self.init()
        self.parms = parms
    }

    override func loadView() {
        super.loadView()
        tableView.tableFooterView = UIView()
        navigationItem.title = phone
        
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(refreshValueChange), for: .valueChanged)
        tableView.refreshControl = rc
        
        reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @objc func refreshValueChange() {
        reloadData()
    }
    
    private func reloadData() {
        let phone = self.phone ?? ""
        let second  = Date().timeIntervalSince1970
        let url = "http://www.smszk.com/smslist/list.php?num=" + phone
        let body = "_search=false&rows=20&page=1&sidx=id&sord=desc" + "&nd=\(second*1000)"
        var req = URLRequest(url: URL(string: url)!)
        req.httpMethod = "POST"
        req.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: req, completionHandler: { (data, resp, error) in
            guard let data = data else {return}
            self.data = MessageModel.deserialize(from: String(data: data, encoding: .utf8))
        }).resume()
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.rows?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "UITableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: .value1, reuseIdentifier: identifier)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = data?.rows?[indexPath.row].nr

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}
