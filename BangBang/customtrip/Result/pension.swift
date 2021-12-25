//
//  pension.swift
//  BangBang
//
//  Created by 고준혁 on 2021/12/13.
//

import Foundation
import Alamofire

struct parsingPensionData: Codable {
    
    struct data:Codable {
        var p_name: String?
        var firstimage: String?
        var addr: String?
        var longitude: Double?
        var latitude: Double?
        var type: String?
        var dog: Int
    }
    
    var data :[data]
}

struct PensionData {
    
    var p_name: String?
    var firstimage: String?
    var addr: String?
    var longitude: Double?
    var latitude: Double?
    var type: String?
    var dog: Int
    
}



class pensionData {
    
    static let shared = pensionData()
    private init() {}
    
    var pension = [PensionData]()
    
    let url = "http://soonyoung.myds.me:38561/show-pension"
    
    let apiQueue = DispatchQueue(label: "ApiQueue", attributes: .concurrent )

    let group = DispatchGroup()
    
    func fetch(completion: @escaping () -> ()) {
        
        group.enter()
        apiQueue.async {
            self.fetch(url: self.url) { (result)  in
                switch result {
                case .success(let list):
                    self.pension = list.data.map {
                        
                        let p_name = $0.p_name
                        let firstimage = $0.firstimage
                        let addr =  $0.addr
                        let lng = $0.longitude
                        let latitude = $0.latitude
                        let type = $0.type
                        let dog = $0.dog


                        return PensionData(p_name: p_name, firstimage: firstimage, addr: addr, longitude: longtitude, latitude: latitude, type: type, dog: dog)
                    }
                    
                default:
                    self.pension = []
                    print("default")
                }
                self.group.leave()
            }
        }

        group.notify(queue: .main) {

            completion()
        }


    }
     
}


extension pensionData {
    
    private func fetch(url: String, completion: @escaping (Result<parsingPensionData,Error>) ->()) {
        
        let parameters: Parameters = [
           "addr": addr,
           "isDog": isDog,
            ]
            
            AF.request(url,method: .post,parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success(let jsonData):
                    do {
                        let usedata = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                        let result = try JSONDecoder().decode(parsingPensionData.self, from: usedata)
                        completion(.success(result))
                        
                    } catch (let error) {
                        print(error.localizedDescription)
                        print(String(describing: error))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
 
}
