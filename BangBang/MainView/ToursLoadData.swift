//
//  withdogData.swift.swift
//  BangBang
//
//  Created by 고준혁 on 2021/12/13.
//

import UIKit
import Alamofire

struct TourData: Codable {
    
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

struct customtour {
    
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
    var image: String?
      
}




class ToursLoadData {
    
    static let shared = ToursLoadData()
    private init() {}
    
    var dogtourlist = [tour]()
    var oldtourlist = [tour]()
    var babytourlist = [tour]()
    
    let apiQueue = DispatchQueue(label: "ApiQueue", attributes: .concurrent)
    
    let group = DispatchGroup()
    
    let Dogurl = "http://soonyoung.myds.me:38561/with/dog"
    let babyurl = "http://soonyoung.myds.me:38561/with/baby"
    let oldurl = "http://soonyoung.myds.me:38561/with/old"
     
    func Dogfetch(completion: @escaping () -> ()) {
        
        group.enter()
        apiQueue.async {
            self.fetch(url: self.Dogurl) { (result) in
                switch result {
                case .success(let list):
                    local = list.data.map {
                        
                        let name = $0.t_name
                        let addr = $0.addr
                        let type = $0.type
                        let lat = $0.latitude
                        let lng = $0.longitude
                        let image = $0.firstimage
                        let dog = $0.dog
                        let guide = $0.guide
                        let stroller = $0.stroller
                        let nursingroom = $0.nursing_room
                        let wheelchair = $0.wheelchair
                        
                        return tour(tname: name, addr: addr, type: type, wheelchair: wheelchair, dog: dog, guide: guide, stroller: stroller, nursing_room: nursingroom, latitude: lat, longitude: lng, imgPath: image )
                    }
                default:
                    self.dogtourlist = []
                    print("dog non data")
                }
                self.group.leave()
            }
        }
        group.notify(queue: .main) {
            completion()
        }
    }
    
    func Oldfetch(completion: @escaping () -> ()) {
        
        group.enter()
        apiQueue.async {
            self.fetch(url: self.oldurl) { (result) in
                switch result {
                case .success(let list):
                    local = list.data.map {
                        
                        let name = $0.t_name
                        let addr = $0.addr
                        let type = $0.type
                        let lat = $0.latitude
                        let lng = $0.longitude
                        let image = $0.firstimage
                        let dog = $0.dog
                        let guide = $0.guide
                        let stroller = $0.stroller
                        let nursingroom = $0.nursing_room
                        let wheelchair = $0.wheelchair
                        
                        return tour(tname: name, addr: addr, type: type, wheelchair: wheelchair, dog: dog, guide: guide, stroller: stroller, nursing_room: nursingroom, latitude: lat, longitude: lng, imgPath: image )
                    }
                default:
                    self.dogtourlist = []
                    print("dog non data")
                }
                self.group.leave()
            }
        }
        group.notify(queue: .main) {
            completion()
        }
    }
    
    func Babyfetch(completion: @escaping () -> ()) {
        
        group.enter()
        apiQueue.async {
            self.fetch(url: self.Dogurl) { (result) in
                switch result {
                case .success(let list):
                    local = list.data.map {
                        
                        let name = $0.t_name
                        let addr = $0.addr
                        let type = $0.type
                        let lat = $0.latitude
                        let lng = $0.longitude
                        let image = $0.firstimage
                        let dog = $0.dog
                        let guide = $0.guide
                        let stroller = $0.stroller
                        let nursingroom = $0.nursing_room
                        let wheelchair = $0.wheelchair
                        
                        return tour(tname: name, addr: addr, type: type, wheelchair: wheelchair, dog: dog, guide: guide, stroller: stroller, nursing_room: nursingroom, latitude: lat, longitude: lng, imgPath: image )
                    }
                default:
                    self.dogtourlist = []
                    print("dog non data")
                }
                self.group.leave()
            }
        }
        group.notify(queue: .main) {
            completion()
        }
    }
    
    func picnicfetch(completion: @escaping () -> ()) {
        
        group.enter()
        apiQueue.async {
            self.fetch(url: self.oldurl) { (result) in
                switch result {
                case .success(let list):
                    local = list.data.map {
                        
                        let name = $0.t_name
                        let addr = $0.addr
                        let type = $0.type
                        let lat = $0.latitude
                        let lng = $0.longitude
                        let image = $0.firstimage
                        let dog = $0.dog
                        let guide = $0.guide
                        let stroller = $0.stroller
                        let nursingroom = $0.nursing_room
                        let wheelchair = $0.wheelchair
                        
                        return tour(tname: name, addr: addr, type: type, wheelchair: wheelchair, dog: dog, guide: guide, stroller: stroller, nursing_room: nursingroom, latitude: lat, longitude: lng, imgPath: image )
                    }
                default:
                    self.dogtourlist = []
                    print("dog non data")
                }
                self.group.leave()
            }
        }
        group.notify(queue: .main) {
            completion()
        }
    }
    
 
}


extension ToursLoadData {
    
    private func fetch(url: String, completion: @escaping (Result<TourData,Error>) ->()) {
        
        let parameters: Parameters = [
            "data" : ["lat": latitude,
                      "lng": longtitude,
                     ]
            ]
            
            AF.request(url,method: .post,parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success(let jsonData):
                    do {
                        let usedata = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                        let result = try JSONDecoder().decode(TourData.self, from: usedata)
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
