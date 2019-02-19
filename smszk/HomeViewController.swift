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
                CATransaction.begin()
                CATransaction.setCompletionBlock({
                    self.tableView.reloadData()
                })
                self.tableView.refreshControl?.endRefreshing()
                CATransaction.commit()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        tableView.tableFooterView = UIView()
        navigationItem.title = "号码库"
        
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
            let data = data ?? Data()
            self.dataList = try? HTMLDocument(data: data).css(".down-content").map { [$0.firstChild(css: "h4")?.stringValue,$0.firstChild(css: "span")?.stringValue] }
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
        guard let phone = dataList?[indexPath.row][0] else {
            return
        }
        UIPasteboard.general.string = phone
        navigationController?.pushViewController(MessgeViewController(parms: ["phone": phone]), animated: true)
    }
}

