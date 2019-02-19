//
//  ViewController.swift
//  smszk
//
//  Created by LeonJing on 2019/2/18.
//  Copyright © 2019 LeonJing. All rights reserved.
//

import UIKit
import Fuzi
import NetworkActivityIndicator

class HomeViewController: UITableViewController {
    
    private var dataList:[[String?]]? {
        didSet{
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        tableView.tableFooterView = UIView()
        navigationItem.title = "免费接收短信"
        
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(refreshValueChange), for: .valueChanged)
        tableView.refreshControl = rc
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @objc func refreshValueChange() {
        reloadData()
    }

    private func reloadData() {
        NetworkActivityIndicator.sharedIndicator.visible = true
        URLSession.shared.dataTask(with: URL(string: "http://www.smszk.com/")!, completionHandler: { (data, resp, error) in
            NetworkActivityIndicator.sharedIndicator.visible = false
            guard let data = data else {return}
            do {
                let html = try HTMLDocument(data: data)
                let sets = html.css(".down-content")
                var phones = [[String?]]()
                for set in sets {
                    let h4 = set.firstChild(css: "h4")?.stringValue
                    let span = set.firstChild(css: "span")?.stringValue
                    phones.append([h4,span])
                }
                self.dataList = phones
            } catch let error {
                print(error)
            }
        }).resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "UITableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: .value1, reuseIdentifier: identifier)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = dataList?[indexPath.row][0]
        cell.detailTextLabel?.text = dataList?[indexPath.row][1]
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        UIPasteboard.general.string = dataList?[indexPath.row][0]
        navigationController?.pushViewController(MessgeViewController(parms: ["phone":dataList?[indexPath.row][0]]), animated: true)
    }
}

