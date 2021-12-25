//
//  festivalData.swift.swift
//  BangBang
//
//  Created by 고준혁 on 2021/12/13.
//

import UIKit
import Alamofire

struct festivalData: Codable {
    
    struct data: Codable {
        var f_name: String?
        var addr: String?
        var start: String?
        var end: String?
        var firstimage: String?
    }
    var data:[data]
}

struct festival {
    
    var fname:String?
    var addr:String?
    var start:String?
    var end: String?
    var imagepath:String?

}



class LoadFestivalData {
    
    static let shared = LoadFestivalData()
    private init() {}
    
    var festivaltour = [festival]()
    
    let url = "http://soonyoung.myds.me:38561/get-festi"
    
    let apiQueue = DispatchQueue(label: "ApiQueue", attributes: .concurrent )

    let group = DispatchGroup()
    
    func fetch(completion: @escaping () -> ()) {
        
        group.enter()
        apiQueue.async {
            self.fetch(url: self.url) { (result)  in
                switch result {
                case .success(let list):
                    self.festivaltour = list.data.map {
                        
                        let fname = $0.f_name
                        let addr = $0.addr
                        let start = $0.start
                        let end = $0.end
                        let image = $0.firstimage

                        return festival(fname: fname, addr: addr, start: start, end: end, imagepath: image)
                    }
                    
                default:
                    self.festivaltour = []
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

extension LoadFestivalData {
    
    private func fetch(url: String, complete: @escaping (Result<festivalData,Error>) -> ()) {
        
        AF.request(url, method: .get).responseJSON{ response in
            
            switch response.result {
            case .success(let jsonData):
                do {
                    let usedata = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                    let result = try JSONDecoder().decode(festivalData.self, from: usedata)
                    complete(.success(result))
                    
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
