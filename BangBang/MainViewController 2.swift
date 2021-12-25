//
//  ViewController.swift
//  BangBang
//
//  Created by 고준혁 on 2021/11/24.
//

import UIKit
import SnapKit
import CoreLocation

var location: CLLocation?

var longtitude: CLLocationDegrees?
var latitude:CLLocationDegrees?
var getgps = 0




class MainViewController: UIViewController {
    
    var currentpage = 0
    var locationManager: CLLocationManager!
    
    

    let mainview: UIScrollView = { // main스크롤뷰
       let vc = UIScrollView()
        
        vc.backgroundColor = .white
        vc.showsVerticalScrollIndicator = false
        vc.showsHorizontalScrollIndicator = false
        
        return vc
    }()
    
    let recommendview: UIScrollView = { //맨위 상단 좌우 스크롤뷰
        let vc = UIScrollView()
        vc.backgroundColor = .white
        vc.isPagingEnabled = true
        vc.showsVerticalScrollIndicator = false
        vc.showsHorizontalScrollIndicator = false

        return vc
    }()
    
    var contents: [UIView] = []
    var itemview: [UIView] = []
    
    func addremmendViewsaddview() { // 페이지마다 뷰와 버튼 생성
        for _ in 0..<5 {
            contents.append(UIView())
            itemview.append(UIButton())
        }
        
        for i in 0..<5 { // 구조 설정 및 추가
            //let xPos = self.view.frame.width * CGFloat(i)
        
            recommendview.addSubview(contents[i])
            recommendview.contentSize.width = view.frame.width * 5
            
            contents[i].snp.makeConstraints { make in
                make.centerY.equalTo(recommendview)
                if i == 0 {
                    make.leading.equalTo(recommendview)
                    
                } else {
                    make.leading.equalTo(contents[i-1]).offset(view.frame.width)
                }
                make.width.equalTo(view.frame.width)
                make.height.equalTo(recommendview)
            }
            
            itemview[i].backgroundColor = .systemGray6
            itemview[i].layer.cornerRadius = 15
            
            contents[i].addSubview(itemview[i])
            itemview[i].snp.makeConstraints { make in
                make.top.equalTo(contents[i]).offset(10)
                make.bottom.equalTo(contents[i]).offset(-10)
                make.leading.equalTo(contents[i]).offset(10)
                make.trailing.equalTo(contents[i]).offset(-10)
            }
        }
    }
    
    let currentPageLabel: UILabel = { // 현재 페이지 번호 출력
       let label = UILabel()
        
        label.textColor = .white
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        label.text = "1 / 5"
        label.layer.cornerRadius = 7.5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label

    }()
    

    
    let searchtravelBt: UIButton = { //검색 버튼
        let bt = UIButton()
        
        bt.backgroundColor = UIColor.init(red: 215/255, green: 234/255, blue: 253/255, alpha: 1)
        bt.layer.cornerRadius = 15
        
        return bt
    }()
    
    let searchLabel: UILabel = {
        let label = UILabel()
        
        label.text = "여행"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    let searchtextview: UITextView = {
        let tv = UITextView()
        
        tv.text = "맞춤 여행\n추천받아\n다녀오세요!"
        tv.textColor = .black
        tv.isEditable = false
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 13)
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    let searchimgView: UIImageView = {
        let iv = UIImageView()
        let img = UIImage(named: "map.png")
        iv.image = img
        
        return iv
    }()
    
    //소풍
    
    let picnicview :UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .systemGray5
        bt.layer.cornerRadius = 15
        return bt
    }()
    
    let picnicLabel: UILabel = {
        let label = UILabel()
        label.text = "소풍"
        label.textColor = .black
        
        return label
    }()
    
    let picnicimg: UIImageView = {
        let imgv = UIImageView()
        
        let img  = UIImage(named: "picnic.png")
        imgv.image = img
        
        return imgv
    }()
    
    //GPS
    
    let GPSview :UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .systemGray5
        bt.layer.cornerRadius = 15
        return bt
    }()
    
    let GPSLabel: UILabel = {
        let label = UILabel()
        label.text = "GPS 설정"
        label.textColor = .black
        
        return label
    }()
    
    let GPSimg: UIImageView = {
        let imgv = UIImageView()
        
        let img  = UIImage(named: "gps.png")
        imgv.image = img
        
        imgv.backgroundColor = .white
        
        return imgv
    }()
    
    // Buttons
    
    var mainbutton:[CustomButton] = []
    func addMainButtons() {
        for i in 0..<3 {
            mainbutton.append(CustomButton())
            mainview.addSubview(mainbutton[i])
            switch i {
            case 0:
                mainbutton[i].btTitle.text = "반려견과의 여행"
                mainbutton[i].btimg.image = UIImage(named: "withpet.png")
            case 1:
                mainbutton[i].btTitle.text = "노약자와의 여행"
                mainbutton[i].btimg.image = UIImage(named: "old.png")
            case 2:
                mainbutton[i].btTitle.text = "아기와의 여행"
                mainbutton[i].btimg.image = UIImage(named: "baby.png")
            default:
                break
        }
    }
    }
    
    let line:UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray5
        return v
    }()
    
    let festivalLabel:UILabel = {
        let label = UILabel()
        label.text = "지역축제 즐기기"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    let festivalscrollView:UIScrollView = {
        let sv = UIScrollView()
        
        sv.backgroundColor = .white
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    var festivalbutton:[festivalview] = []
    
    func addfestivalviews() {
        for i in 0..<10 {
            festivalbutton.append(festivalview())
            festivalscrollView.addSubview(festivalbutton[i])
        }
    }
    
    
  
    func addviews() {
        
        view.addSubview(mainview)
        mainview.addSubview(recommendview)
        
        //검색
        mainview.addSubview(searchtravelBt)
        searchtravelBt.addSubview(searchLabel)
        searchtravelBt.addSubview(searchtextview)
        searchtravelBt.addSubview(searchimgView)
        
        //소풍
        mainview.addSubview(picnicview)
        picnicview.addSubview(picnicLabel)
        picnicview.addSubview(picnicimg)
        
        //gps설정
        
        mainview.addSubview(GPSview)
        GPSview.addSubview(GPSLabel)
        GPSview.addSubview(GPSimg)
        
        // 3buttons
        addMainButtons()
        
        // festival
        mainview.addSubview(line)
        mainview.addSubview(festivalLabel)
        mainview.addSubview(festivalscrollView)
        addfestivalviews()
    
    }
    
    func autolayout(){
        
        mainview.snp.makeConstraints { make in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaInsets)
            make.bottom.equalTo(self.view.safeAreaInsets)
        }
        
        //추천
        
        recommendview.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(mainview)
            make.height.equalTo(view.frame.height/5)
        }
        
        //검색
        
        searchtravelBt.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(10)
            make.top.equalTo(recommendview.snp.bottom).offset(20)
            make.height.width.equalTo(view.frame.height/6)
            make.trailing.equalTo(view.snp.centerX).offset(-5)
        }
        
        searchLabel.snp.makeConstraints { make in
            make.leading.equalTo(searchtravelBt).offset(20)
            make.top.equalTo(searchtravelBt).offset(20)
        }
        
        searchtextview.snp.makeConstraints { make in
            make.leading.equalTo(searchtravelBt).offset(10)
            make.top.equalTo(searchLabel.snp.bottom).offset(10)
            make.trailing.bottom.equalTo(searchtravelBt)
        }
        
        searchimgView.snp.makeConstraints { make in
            make.trailing.equalTo(searchtravelBt).offset(-10)
            make.bottom.equalTo(searchtravelBt).offset(-20)
            make.top.equalTo(searchtravelBt).offset(20)
            make.leading.equalTo(searchtravelBt.snp.centerX).offset(-10)
        }
        
        //소풍
        
        picnicview.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.centerX).offset(5)
            make.top.equalTo(searchtravelBt)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
            make.bottom.equalTo(searchtravelBt.snp.centerY).offset(-5)
        }
        
        picnicLabel.snp.makeConstraints { make in
            make.leading.equalTo(picnicview).offset(20)
            make.top.equalTo(picnicview).offset(10)
        }
        
        picnicimg.snp.makeConstraints { make in
            make.trailing.equalTo(picnicview.snp.trailing).offset(-10)
            make.top.equalTo(picnicview).offset(10)
            make.bottom.equalTo(picnicview).offset(-10)
            make.leading.equalTo(picnicview.snp.centerX).offset(10)
        }
        
        //gps
        
        GPSview.snp.makeConstraints { make in
            make.leading.equalTo(picnicview)
            make.trailing.equalTo(picnicview)
            make.top.equalTo(searchtravelBt.snp.centerY).offset(5)
            make.bottom.equalTo(searchtravelBt.snp.bottom)
        }
        
        GPSLabel.snp.makeConstraints { make in
            make.leading.equalTo(picnicLabel)
            make.top.equalTo(GPSview).offset(10)
        }
        
        GPSimg.snp.makeConstraints { make in
            make.leading.trailing.equalTo(picnicimg)
            make.top.equalTo(GPSview).offset(10)
            make.bottom.equalTo(GPSview).offset(-10)
        }
        
        for i in 0..<3 {
            switch i {
            case 0:
                mainbutton[i].snp.makeConstraints { make in
                    make.top.equalTo(searchtravelBt.snp.bottom).offset(10)
                }
            default:
                mainbutton[i].snp.makeConstraints { make in
                    make.top.equalTo(mainbutton[i-1].snp.bottom).offset(10)
                }
            }
            mainbutton[i].snp.makeConstraints { make in
                make.leading.equalTo(searchtravelBt)
                make.trailing.equalTo(picnicview)
                make.height.equalTo(view.frame.height/10)
            }
        }
        
        line.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(mainbutton[2].snp.bottom).offset(20)
            make.height.equalTo(5)
        }
        
        festivalLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(20)
            make.leading.equalTo(view.frame.width/10)
        }
        
        festivalscrollView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(festivalLabel.snp.bottom).offset(20)
            make.height.equalTo(view.frame.height/4)
        }
        
        for i in 0..<10 {
            if i == 0 {
                festivalbutton[i].snp.makeConstraints { make in
                    make.leading.equalTo(festivalscrollView).offset(20)
                }
            }
            else {
                festivalbutton[i].snp.makeConstraints { make in
                    make.leading.equalTo(festivalbutton[i-1].snp.trailing).offset(20)
                }
            }
            festivalbutton[i].snp.makeConstraints { make in
                make.top.equalTo(festivalscrollView).offset(20)
                make.width.equalTo(view.frame.width/2)
                make.height.equalTo(view.frame.height/5)
            }
    }
        
        
        
        
    }
    
    func currentPageLabellayout() {
        
        view.addSubview(currentPageLabel)
        
        currentPageLabel.snp.makeConstraints { make in
            make.trailing.equalTo(recommendview).offset(-30)
            make.bottom.equalTo(recommendview).offset(-20)
            make.width.equalTo(recommendview).multipliedBy(0.1)
            
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        mainview.contentSize.height = view.frame.height + view.frame.height / 4
        festivalscrollView.contentSize.width = view.frame.width * 5 + 420
        
        addviews()
        autolayout()
        addremmendViewsaddview()
        currentPageLabellayout()
        
        
        recommendview.delegate = self
        //location manager
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        
        navigationAppearance(vc: self)
        tabbarAppearance(vc: self)
        
        GPSview.addTarget(self, action: #selector(presentGpsView(_:)), for: .touchUpInside)
        searchtravelBt.addTarget(self, action: #selector(searchtravelaction(_:)), for: .touchUpInside)
        
        
        

    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        currentpage = Int(scrollView.contentOffset.x / view.frame.width)
        print(currentpage + 1)
        currentPageLabel.text = "\(currentpage+1) / 5"
    }
}

//bt action
extension MainViewController {
    //gps action
    func GPSReset() {
        GPSview.snp.remakeConstraints { make in
            make.leading.equalTo(picnicview)
            make.trailing.equalTo(picnicview)
            make.top.equalTo(searchtravelBt.snp.centerY).offset(5)
            make.bottom.equalTo(searchtravelBt.snp.bottom)
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        }) { finshed in
            let gpsvc = CurrentGpsViewController()
            self.navigationController?.pushViewController(gpsvc, animated: true)
        }
    }

    @objc func presentGpsView(_ sender: UIButton) {
            GPSview.snp.remakeConstraints { make in
                make.leading.equalTo(picnicview).offset(-1)
                make.trailing.equalTo(picnicview).offset(1)
                make.top.equalTo(searchtravelBt.snp.centerY).offset(4)
                make.bottom.equalTo(searchtravelBt.snp.bottom).offset(1)
            }
        UIView.animate(withDuration: 0.1, animations:  {
            self.view.layoutIfNeeded()
        }) { finished in
            self.GPSReset()
        }
    }
    
    func searchtravelReset() {
        searchtravelBt.snp.remakeConstraints { make in
            make.leading.equalTo(view).offset(10)
            make.top.equalTo(recommendview.snp.bottom).offset(20)
            make.height.width.equalTo(view.frame.height/6)
            make.trailing.equalTo(view.snp.centerX).offset(-5)
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        }) { finshed in
            let vc = CustomTripViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func searchtravelaction(_ sender: UIButton) {
        
        searchtravelBt.snp.remakeConstraints { make in
            make.leading.equalTo(view).offset(9)
            make.top.equalTo(recommendview.snp.bottom).offset(19)
            make.height.width.equalTo(view.frame .height/6+1)
            make.trailing.equalTo(view.snp.centerX).offset(-4)
        }
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        } completion: { finished in
            self.searchtravelReset()
        }
    }

}

extension MainViewController: CLLocationManagerDelegate {
    
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
    
}
