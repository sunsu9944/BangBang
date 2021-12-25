//
//  File.swift
//  BangBang
//
//  Created by 고준혁 on 2021/11/30.
//

import UIKit

struct JusoResponse: Codable {
    
    struct results: Codable {
        
        struct common: Codable {
            var totalCount: String?
        }
        
        struct juso: Codable {
            var roadAddrPart1 : String?
            var admCd: String?
            var rnMgtSn: String?
            var udrtYn: String?
            var buldMnnm: String?
            var buldSlno: String?
        }
        
        var juso: [juso]
        var common: common
    }
    
    var results: results
  
}

struct parsingjuso {
    var road: String?
    var admCd: String?
    var rnMgtSn: String?
    var udrtYn: String?
    var buldMnnm: String?
    var buldSlno: String?
}


struct GPSJUSO: Codable {
    
    struct addresses : Codable {
        
        var x: String
        var y: String
    }
    
    var addresses:[addresses]
    
}

struct parsingGPS {
    
    var x: String
    var y: String
    
}
