//
//  tourDetailViewController.swift
//  BangBang
//
//  Created by 고준혁 on 2021/12/09.
//

import UIKit
import NMapsMap
import SnapKit
import Alamofire

enum jjim {
    case check
    case notcheck
}

var addr: String?
var type:resulttype = .tourlist

class tourDetailViewController: UIViewController {
    
    
    var isjjim:jjim = .notcheck
    var index = resultViewController.selectrow
    
    
    let navermapview: NMFNaverMapView = {
        let navermap = NMFNaverMapView()
        
        
        
        return navermap
    }()
    

    let tname: UILabel = {
        let label = UILabel()
        
        label.text = "이름"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        
        return label
    }()
    
    let address: UITextView = {
        let label = UITextView()
        
        label.text = "주소"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    let typelabel: UILabel = {
        let label = UILabel()
        
        label.text = "타입"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        
        
        return label
    }()
    
    let tourimage: UIImageView = {
        let mv = UIImageView()
        
        mv.backgroundColor = .systemGray5
        
        return mv
    }()
    
    let addjjim: UIButton = {
        let bt = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        
        let image = UIImage(systemName: "heart")
        
        bt.setBackgroundImage(image, for: .normal)
        bt.tintColor = .systemRed
        
        return bt
    }()
    
    let house: UIButton = {
        let bt = UIButton()
        
        bt.layer.cornerRadius = 15
        bt.setTitle("숙소 찾기", for: .normal)
        bt.layer.borderColor = UIColor.black.cgColor
        bt.layer.borderWidth = 1
        bt.setTitleColor(.black, for: .normal)
        
        return bt
    }()

    func addview(){
        
        view.addSubview(navermapview)
        view.addSubview(tourimage)
        view.addSubview(typelabel)
        view.addSubview(tname)
        view.addSubview(address)
        view.addSubview(addjjim)
        view.addSubview(house)
    }
    
    let navigationbt: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("완료", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        return bt
    }()
    
    
    func autolayout(){
        
        navermapview.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.height.equalTo(view.frame.height/2)
        }
        
        tourimage.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(30)
            make.top.equalTo(navermapview.snp.bottom).offset(30)
            make.height.equalTo(view.frame.height/7)
            make.width.equalTo(view.frame.width/2.2)
        }
        
        tname.snp.makeConstraints { make in
            make.top.equalTo(tourimage).offset(10)
            make.leading.equalTo(tourimage.snp.trailing)
            make.trailing.equalTo(view)
            make.trailing.equalTo(view).offset(30)
            make.height.equalTo(30)
        }
        
        typelabel.snp.makeConstraints { make in
            make.trailing.equalTo(tname)
            make.leading.equalTo(tname)
            make.top.equalTo(tname.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
        address.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view)
            make.top.equalTo(tourimage.snp.bottom).offset(10)
            make.height.equalTo(80)
        }
        house.snp.makeConstraints { make in
            make.trailing.equalTo(view).offset(-30)
            make.top.equalTo(address).offset(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.width.equalTo(150)
        }
                
    }
    
    
    func marking() {
        let marker = NMFMarker()
        switch type {
        case .tourlist:
        guard let tourlat = local[index].latitude else { return }
        guard let tourlng = local[index].longitude else { return }
        
        
        
        marker.position = NMGLatLng(lat: tourlat , lng: tourlng)
        marker.captionText = local[index].tname!
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: tourlat, lng: tourlng))
            navermapview.mapView.moveCamera(cameraUpdate)
        case.pensionlist:
            guard let tourlat = pensionData.shared.pension[index].latitude else { return }
            guard let tourlng = pensionData.shared.pension[index].longitude else { return }
            

            
            marker.position = NMGLatLng(lat: tourlat , lng: tourlng)
            marker.captionText = pensionData.shared.pension[index].p_name!
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: tourlat, lng: tourlng))
            navermapview.mapView.moveCamera(cameraUpdate)
        }
        
        marker.mapView = navermapview.mapView
        }
        
    
    
    func loadimage() {
        switch type {
        case .tourlist:
        guard let imgurl = local[index].imgPath else { return}
        
        AF.request(imgurl, method: .get).response{ response in
            
            switch response.result {
            case.success(let responseData):
                self.tourimage.image = UIImage(data: responseData!, scale: 1)
                
            case .failure(let error):
                print("error",error)
            }
        }
        case .pensionlist:
            guard let imgurl = pensionData.shared.pension[index].firstimage else { return}
            
            AF.request(imgurl, method: .get).response{ response in
                
                switch response.result {
                case.success(let responseData):
                    self.tourimage.image = UIImage(data: responseData!, scale: 1)
                    
                case .failure(let error):
                    print("error",error)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addview()
        autolayout()
        view.backgroundColor = .white
        navigationItem.titleView = navigationdetailtitle()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addjjim)
        addjjim.addTarget(self, action: #selector(pressjjim(_:)), for: .touchUpInside)
        house.addTarget(self, action: #selector(presshouse(_:)), for: .touchUpInside)
        
        marking()
        loadimage()
        
        
        // Do any additional setup after loading the view.
        
        if type == .pensionlist {
            house.isHidden = true
            tname.text = pensionData.shared.pension[index].p_name
            address.text = pensionData.shared.pension[index].addr
            typelabel.text = pensionData.shared.pension[index].type
        } else {
            tname.text = local[index].tname
            address.text = local[index].addr
            typelabel.text = local[index].type
            
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationbt)
        navigationbt.addTarget(self, action: #selector(pressnavigationbt(_:)), for: .touchUpInside)
    }
    
    @objc func pressnavigationbt(_ sender: UIButton){
        
        navigationController?.popToRootViewController(animated: true)

        
    }
    
    @objc func pressjjim(_ sender: UIButton) {
        if self.isjjim == .notcheck {
            sender.setBackgroundImage(UIImage(systemName:"heart.fill"), for: .normal)
            self.isjjim = .check
        } else {
            sender.setBackgroundImage(UIImage(systemName:"heart"), for: .normal)
            self.isjjim = .notcheck
        }
    }
    
    @objc func presshouse(_ sender: UIButton) {
        type = .pensionlist
        
        pensionData.shared.fetch {
            let vc = resultViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
   
    }

}
