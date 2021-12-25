//
//  sendDataType.swift.swift
//  BangBang
//
//  Created by 고준혁 on 2021/12/07.
//

import UIKit

struct sendData: Codable {
    
    
    struct data: Codable {
        
        var lat : String
        var lng : String
        var dist : String
        var isDog : String
        var isBlind : String
        var isNursing_room : String
        var isStroller : String
        var isHandi : String
        var ten : String
        var twenty : String
        var thirty : String
        var forty : String
        var fifty : String
        var sixty : String
    }
    
    let data: data
}

struct tourlist: Codable {
    
    struct data: Codable {
        
        var t_name: String?
        var addr: String?
        var type: String?
        var wheelchair: Int?
        var dog : Int?
        var guide: Int?
        var stroller: Int?
        var nursing_room: Int?
        var latitude: Double?
        var longitude: Double?
        var firstimage: String?
    }
    
    var data: [data]
    
}

struct tour {
    var tname: String?
    var addr: String?
    var type: String?
    var wheelchair: Int?
    var dog: Int?
    var guide: Int?
    var stroller: Int?
    var nursing_room: Int?
    var latitude: Double?
    var longitude: Double?
    var imgPath: String?
}


