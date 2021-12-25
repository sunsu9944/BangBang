//
//  GPSViewController.swift
//  BangBang
//
//  Created by 고준혁 on 2021/11/29.
//

import UIKit
import SnapKit
import NMapsMap
import CoreData


class GPSViewController: UIViewController {

    var locationManager: CLLocationManager!
    static var status = 0
    
    let navermap:NMFNaverMapView = {
        let mapview = NMFNaverMapView()
        
        mapview.showCompass = true
        mapview.mapView.setLayerGroup("NMF_LAYER_GROUP_BUILDING", isEnabled: true)
        //mapview.showLocationButton = true
        
        
        return mapview
    }()
    
    let setXY: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("주소로 설정하기", for: .normal)
        bt.backgroundColor = .systemGray5
        
        return bt
    }()
    
 
    
    
    
    func addview() {
        
        view.addSubview(navermap)
        view.addSubview(setXY)
        
    }
    
    func autolayout() {
        
        navermap.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view)
            make.bottom.equalTo(setXY.snp.top)
        }
        
        setXY.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(view.frame.height/15)
        }
        
   
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addview()
        autolayout()
        
        view.backgroundColor = .white
        navigationItem.titleView =  navigationGPStitle()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        self.locationManager.requestWhenInUseAuthorization()
        makemarker()
        setXY.addTarget(self, action: #selector(touchsetXYbt(_:)), for: .touchUpInside)
        

        // Do any additional setup after loading the view.
    }
    
    
    @objc func touchsetXYbt(_ sender: UIButton) {
        
        latitude = laty
        longtitude = longx
        
        navigationController?.popViewController(animated: true)
    
    }
    

    }

extension GPSViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if getgps == 0 {
            location = locations[locations.count - 1]
            longtitude = location?.coordinate.longitude //위도
            latitude = location?.coordinate.latitude //경도
            getgps = 1
            print(longtitude, latitude)
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정")
            self.locationManager.startUpdatingLocation()
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
            manager.requestWhenInUseAuthorization()
        case .denied:
            manager.requestWhenInUseAuthorization()
        default:
            print("default GPS Authorization")
        }
    }
    
    
    func makemarker() {
        let marker = NMFMarker()
        
        let markerlat:Double
        let markerlong:Double
        
        if GPSViewController.status == 0 {
        guard let lat = latitude else { return }
        guard let long = longtitude else { return }
            markerlat = lat
            markerlong = long
        } else {
            guard let lat = laty else { return }
            guard let long = longx else { return }
            markerlat = lat
            markerlong = long
        }
        
        
        marker.position = NMGLatLng(lat: markerlat, lng: markerlong)
        
        if datas.count == 0 {
            
            marker.captionText = "현재 위치"
            
            
        } else {
        marker.captionText = datas[CurrentGpsViewController.index].road!
        }
        marker.mapView = navermap.mapView
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: markerlat, lng: markerlong))
        navermap.mapView.moveCamera(cameraUpdate)
    }
    
    
}

