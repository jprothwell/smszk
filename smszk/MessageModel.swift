//
//  MessageModel.swift
//  smszk
//
//  Created by LeonJing on 2019/2/18.
//  Copyright © 2019 LeonJing. All rights reserved.
//

import HandyJSON

class MessageModel: HandyJSON {
    class Row: HandyJSON {
        var id: String?
        var phonenum: String?
        var nr: String?
        var time: String?
        var model: String?
        var thisnum: String?
        
        
        required init() {
            
        }
    }
    
    var page: String?
    var total: String?
    var records: String?
    var rows: [Row]?
    
    required init() {
        
    }
}
