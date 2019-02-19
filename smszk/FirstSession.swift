//
//  FirstSession.swift
//  smszk
//
//  Created by LeonJing on 2019/2/18.
//  Copyright © 2019 LeonJing. All rights reserved.
//

import Foundation

class FirstSession {
    static let shared = FirstSession()
    private init(){}
    func start() {
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "http://www.baidu.com")!), completionHandler: { (data, resp, error) in
            //print(resp?.description ?? "First Session")
        }).resume()
    }
}
