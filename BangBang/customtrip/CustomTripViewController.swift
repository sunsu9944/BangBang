//
//  CustomTripViewController.swift
//  BangBang
//
//  Created by 고준혁 on 2021/12/05.
//

import UIKit
import Alamofire

var isDog = "0"
var isBlind = "0"
var isNursing_room = "0"
var isStorller = "0"
var isHandi = "0"
var ten = "0"
var twenty = "0"
var thirty = "0"
var forty = "0"
var fifty = "0"
var sixty = "0"

var local = [tour]()

class CustomTripViewController: UIViewController {

    
    
    var select: [customTripButton] = []
    var titlename = ["강아지","거동불편자","수유실","유모차","시각장애인","10세","20세","30세","40세","50세","60세"]
    
    let apiQueue = DispatchQueue(label: "ApiQueue", attributes: .concurrent )
    let group = DispatchGroup()
    
    let titlelabel: UILabel = {
        let label = UILabel()
        
        label.text = "무장애 여행 검색"
        label.font = UIFont(name: customfont.잉크링퀴드.rawValue, size: 30)
        
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        
        label.text = "가족 구성원 나이 검색"
        label.font = UIFont(name: customfont.잉크링퀴드.rawValue, size: 30)
        
        return label
    }()
    
    let sendbt: UIButton = {
        let bt = UIButton()
        bt.setTitle("검색", for: .normal)
        bt.backgroundColor = .systemGray5
        bt.setTitleColor(UIColor.black, for: .normal)
        
        bt.layer.borderColor = UIColor.black.cgColor
        bt.layer.borderWidth = 1
        bt.layer.cornerRadius = 15
        
        
        return bt
    }()
    
    
    
    
    
    func addselectbt() {
        
        for i in 0..<5 {
            select.append(customTripButton())
            select[i].title.text = titlename[i]
            select[i].check = .notchecked
            
            view.addSubview(select[i])
        }
        
        for i in 5..<11 {
            select.append(customTripButton())
            select[i].title.text = titlename[i]
            select[i].check = .notchecked
            
            view.addSubview(select[i])
        }
 
    }
    
    
    
    
    
    func autolayout() {
        
        for i in 0..<5 {
            if i % 2 == 0 {
                select[i].snp.makeConstraints { make in
                    make.leading.equalTo(view).offset(30)
                    make.trailing.equalTo(view.snp.centerX).offset(-10)
                }
            } else {
                
                select[i].snp.makeConstraints { make in
                    make.leading.equalTo(view.snp.centerX).offset(10)
                    make.trailing.equalTo(view).offset(-30)
                }
            }
            
            if i <= 1 {
                select[i].snp.makeConstraints { make in
                    make.top.equalTo(titlelabel.snp.bottom).offset(30)
                }
            } else if i <= 3 {
                select[i].snp.makeConstraints { make in
                    make.top.equalTo(select[1].snp.bottom).offset(10)
                }
            } else {
                select[i].snp.makeConstraints { make in
                    make.top.equalTo(select[3].snp.bottom).offset(10)
                }
            }
            
            select[i].snp.makeConstraints { make in
                make.height.equalTo(view.frame.height/20)
            }
        }
        
        for i in 5..<11 {
            if i % 2 == 1 {
                select[i].snp.makeConstraints { make in
                    make.leading.equalTo(view).offset(30)
                    make.trailing.equalTo(view.snp.centerX).offset(-10)
                }
            } else {
                
                select[i].snp.makeConstraints { make in
                    make.leading.equalTo(view.snp.centerX).offset(10)
                    make.trailing.equalTo(view).offset(-30)
                }
            }
            
            if i <= 6 {
                select[i].snp.makeConstraints { make in
                    make.top.equalTo(ageLabel.snp.bottom).offset(30)
                }
            } else if i <= 8 {
                select[i].snp.makeConstraints { make in
                    make.top.equalTo(select[6].snp.bottom).offset(10)
                }
            } else {
                select[i].snp.makeConstraints { make in
                    make.top.equalTo(select[8].snp.bottom).offset(10)
                }
            }
            
            select[i].snp.makeConstraints { make in
                make.height.equalTo(view.frame.height/20)
            }
        }
        
        titlelabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalTo(view).offset(50)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(select[4].snp.bottom).offset(50)
            make.leading.equalTo(titlelabel)
        }
        sendbt.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(select[10].snp.bottom).offset(50)
            make.height.equalTo(view.frame.width/7)
            make.width.equalTo(view.frame.width/2)
        }
        
        
        
        
    }
    
    
    func addview() {
        
        addselectbt()
        view.addSubview(titlelabel)
        view.addSubview(ageLabel)
        view.addSubview(sendbt)
        
    }
    
    @objc func selected(_ sender: UIButton) {
        
        let bt = sender as! customTripButton
    
        if bt.check == .notchecked{
            bt.check = .checked
            bt.checkbt.setImage(UIImage.init(systemName: "checkmark.diamond"), for: .normal)
        } else {
            bt.check = .notchecked
            bt.checkbt.setImage(UIImage.init(systemName: "diamond"), for: .normal)
        }
    }
    
    @objc func pressbt(_ sender: UIButton) {
        type = .tourlist
        
        for i in 5..<11 {
            
            if select[i].check == .checked {
                print("checked")
                break;
            } else if i == 10 && select[i].check == .notchecked {
                let alert = UIAlertController(title: "오류", message: "가족 구성원중 하나라도 체크해주세요", preferredStyle: .alert)
                let alertaction = UIAlertAction(title: "확인", style: .default) { action in
                }
                alert.addAction(alertaction)
                present(alert, animated: true, completion: nil)
                return
            }
        }
        
        
       
        
        if select[0].check == .checked { isDog = "1" } else { isDog = "0"}
        if select[1].check == .checked { isHandi = "1" } else { isHandi = "0"}
        if select[2].check == .checked { isNursing_room = "1" } else { isNursing_room = "0"}
        if select[3].check == .checked { isStorller = "1" } else { isStorller = "0"}
        if select[4].check == .checked { isBlind = "1" } else { isBlind = "0"}
        if select[5].check == .checked { ten = "1" } else { ten = "0"}
        if select[6].check == .checked { twenty = "1" } else { twenty = "0"}
        if select[7].check == .checked { thirty = "1" } else { thirty = "0"}
        if select[8].check == .checked { forty = "1" } else { forty = "0"}
        if select[9].check == .checked { fifty = "1" } else { fifty = "0"}
        if select[10].check == .checked { sixty = "1" } else { sixty = "0"}
        
        self.sendbt.isUserInteractionEnabled = false
        fetchtour {
            self.sendbt.isUserInteractionEnabled = true
            
            let vc = resultViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .white
        addview()
        autolayout()
        
        for i in 0..<11 {
            select[i].addTarget(self, action: #selector(selected(_:)), for: .touchUpInside)
        }
        
        navigationItem.titleView = navigationCustomtitle()
        
        sendbt.addTarget(self, action: #selector(pressbt(_:)), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    
    func fetchtour(completion: @escaping () -> ()) {
        
        guard let lat = latitude else { return }
        guard let lng = longtitude else { return }
        
        group.enter()
        apiQueue.async {
            self.findtour(lat: String(lat), lng: String(lng), dist: String(dist), isDog: isDog, isBlind: isBlind, isNursing_room: isNursing_room, isStroller: isStorller, isHandi: isHandi, ten: ten, twenty: twenty, thirty: thirty, forty: forty, fifty: fifty, sixty: sixty) { result in
                switch result {
                case .success(let list):
                    local = list.data.map {
                        let tname = $0.t_name
                        let addr = $0.addr
                        let wheelchair = $0.wheelchair
                        let dog = $0.dog
                        let guide = $0.guide
                        let stroller = $0.stroller
                        let nursing = $0.nursing_room
                        let latitude = $0.latitude
                        let longtitude = $0.longitude
                        let type = $0.type
                        let path = $0.firstimage
                        
                        return tour(tname: tname, addr: addr,type: type ,wheelchair: wheelchair, dog: dog, guide: guide, stroller: stroller, nursing_room: nursing, latitude: latitude, longitude: longtitude, imgPath: path)
                    }
            default:
                    local = []
                return
                }
            self.group.leave()
            }
            
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    private func findtour(lat: String,lng: String, dist: String, isDog: String, isBlind: String, isNursing_room:String, isStroller: String, isHandi: String, ten: String, twenty: String, thirty: String,
                          forty: String, fifty:String, sixty:String, completion: @escaping (Result<tourlist, Error>) -> ()){
        let url = "http://soonyoung.myds.me:38561/near-city"
        
        let parameters: Parameters = [
            "data" : ["lat": lat,
                      "lng": lng,
                      "dist": dist,
                      "isDog": isDog,
                      "isBlind": isBlind,
                      "isNursing_room": isNursing_room,
                      "isStroller": isStroller,
                      "isHandi": isHandi,
                      "ten": ten,
                      "twenty": twenty,
                      "thirty": thirty,
                      "forty": forty,
                      "fifty": fifty,
                      "sixty": sixty
                     ]
            ]
        
        AF.request(url,method: .post,parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let jsonData):
                print(jsonData)
                do {
                    let usedata = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                    let result = try JSONDecoder().decode(tourlist.self, from: usedata)
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
