//
//  CurrentGpsViewController.swift
//  BangBang
//
//  Created by 고준혁 on 2021/11/30.
//

import UIKit
import SnapKit
import Alamofire
import CoreLocation

var datas = [parsingjuso]()
var gps = [parsingGPS]()

var longx:Double? =  0
var laty:Double? = 0


class CurrentGpsViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    
    var count = 0
    static var index = 0
    
    let apiQueue = DispatchQueue(label: "ApiQueue", attributes: .concurrent )
    let group = DispatchGroup()

    let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "도로명 주소"
        tf.layer.borderColor = UIColor.systemGray5.cgColor
        tf.layer.borderWidth = 1
        tf.addleftpadding()
      
        return tf
    }()
    
    let currentGPS: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("현재 위치로 주소 찾기", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        
        return bt
    }()
    
    let addressTableView: UITableView = {
        let tv = UITableView()
        
        tv.rowHeight = 50
        tv.register(addressTableViewCell.self, forCellReuseIdentifier: addressTableViewCell.identifier)
        tv.layer.borderWidth = 2
        tv.layer.borderColor = UIColor.black.cgColor
        tv.layer.cornerRadius = 15
        
        return tv
    }()
    
    func addview() {
        view.addSubview(textField)
        view.addSubview(currentGPS)
        view.addSubview(addressTableView)
    }
    
    func autolayout() {
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(-10)
            make.height.equalTo(view.frame.height/20)
            
        }
        
        currentGPS.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.height/20)
        }
        
        addressTableView.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(-10)
            make.top.equalTo(currentGPS.snp.bottom).offset(20)
            make.bottom.equalTo(view.snp.bottom).offset(-50)
        }
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addview()
        autolayout()
        
        view.backgroundColor = .white
        navigationItem.titleView =  navigationGPStitle()
        addressTableView.dataSource = self
        addressTableView.delegate = self
        addressTableView.isUserInteractionEnabled = false
        
        textField.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        
        currentGPS.addTarget(self, action: #selector(pushCurrentGps(_:)), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func pushCurrentGps(_ sender: UIButton) {
        
        GPSViewController.status = 0
        getgps = 0
        startupdategps {
            
        
            let vc = GPSViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func startupdategps(completion: @escaping () -> ()) {
        self.locationManager.startUpdatingLocation()
        print("start gps location")
        longtitude = location?.coordinate.longitude //위도
        latitude = location?.coordinate.latitude //경도
        print(longtitude, latitude)
        completion()
        }
    
    
    @objc func Search() {
        fetch {
            self.addressTableView.reloadData()
            self.addressTableView.isUserInteractionEnabled = true
        }
        
    }
    
    func fetch(completion: @escaping () -> ()) {
        
        guard let keyword = textField.text else {return}
        group.enter()
        apiQueue.async {
            self.findAddress(keyword: keyword) { (result) in
                switch result {
                case .success(let list):
                    datas = list.results.juso.map {
                        
                        let road = $0.roadAddrPart1
                        let admCd1 = $0.admCd
                        let rnMgtSn1 = $0.rnMgtSn
                        let udrtYn1 =  $0.udrtYn
                        let buldMnnm1 = $0.buldMnnm
                        let buldSlno1 =  $0.buldSlno
                        return parsingjuso(road: road, admCd: admCd1, rnMgtSn: rnMgtSn1, udrtYn: udrtYn1, buldMnnm: buldMnnm1, buldSlno: buldSlno1)
                    }

                default:
                    datas = []
                    return
                }
                self.group.leave()
            }
        }

        group.notify(queue: .main) {

            completion()
        }
    }
    
    func fetchGPS(completion: @escaping () -> ()) {
        guard let keyword = datas[CurrentGpsViewController.index].road else {return}
        group.enter()
        apiQueue.async {
            self.findGPS(keyword: keyword) { result in
                switch result {
                case .success(let list):
                    gps = list.addresses.map {
                        
                        let x = $0.x
                        let y = $0.y
          
                        return parsingGPS(x: x, y: y)
                    }
            default:
                gps = []
                return
                }
            self.group.leave()
            }
            
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    
    
    private func findAddress(keyword: String, completion: @escaping (Result<JusoResponse, Error>) -> ()){
        let url = "https://www.juso.go.kr/addrlink/addrLinkApi.do"
        
        let parameters: [String: Any] = ["confmKey": "devU01TX0FVVEgyMDIxMTEzMDAwNDQyNzExMTk2NzQ=",
                                                    "currentPage": "1",
                                                    "countPerPage":"30",
                                                    "keyword": keyword,
                                                    "resultType": "json"]
                    
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let jsonData):
                print(jsonData)
                do {
                    let usedata = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                    let result = try JSONDecoder().decode(JusoResponse.self, from: usedata)
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
    
    private func findGPS(keyword: String, completion: @escaping (Result<GPSJUSO, Error>) -> ()){
        let url = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode"
        
        let parameters: [String: Any] = ["query": keyword]
        let headers: HTTPHeaders = ["X-NCP-APIGW-API-KEY-ID" : "jp5oo9eniv",
                                    "X-NCP-APIGW-API-KEY" : "qKD3MsLpGLsDN9jQcntEQ9hRMudmZmTpOSWQNbPb"]
                    
        AF.request(url, method: .get, parameters: parameters,headers: headers).responseJSON { response in
            switch response.result {
            case .success(let jsonData):
                print(jsonData)
                do {
                    let usedata = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                    let result = try JSONDecoder().decode(GPSJUSO.self, from: usedata)
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


extension CurrentGpsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        CurrentGpsViewController.index = indexPath.row
        print("index",index)
        GPSViewController.status = 1
        fetchGPS {
            longx =  Double(gps[0].x)
            laty = Double(gps[0].y)
            tableView.deselectRow(at: indexPath, animated: true)
            
            
            let vc = GPSViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }}

extension CurrentGpsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let index = datas.count
        
        if index == 0 {
            
            return 1
            
        }

        
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: addressTableViewCell.identifier, for: indexPath) as! addressTableViewCell
        
        if datas.count == 0 {
            return cell
        }
        
        
        cell.address.text = datas[indexPath.row].road
        
        return cell
    }
    
}

extension CurrentGpsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        Search()
        
        return true
    }
    
}
