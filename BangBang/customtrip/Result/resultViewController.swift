//
//  resultViewController.swift
//  BangBang
//
//  Created by 고준혁 on 2021/12/08.
//

import UIKit
import Alamofire

enum resulttype {
    case tourlist
    case pensionlist
}

class resultViewController: UIViewController {
    
    static var selectrow = 0
    
    let tableview: UITableView = {
        let tv = UITableView()
        
        tv.register(resultTableViewCell.self, forCellReuseIdentifier: resultTableViewCell.idnentifier)
        
        tv.rowHeight = 200
        return tv
    }()
    
    
    func addview() {
        view.addSubview(tableview)
        
    }
    
    func autolayout() {
        tableview.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addview()
        autolayout()

        
        view.backgroundColor = .white
        navigationItem.titleView = navigationResultitle()
        tableview.delegate = self
        tableview.dataSource = self
        
        
        
    }
    

    

}


extension resultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch type {
        case .tourlist:
            return local.count
        case .pensionlist:
            print("pension: ",pensionData.shared.pension.count)
            return pensionData.shared.pension.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: resultTableViewCell.idnentifier, for: indexPath) as! resultTableViewCell
        
        
        switch type {
        case .tourlist:
            
            cell.tname.text = local[indexPath.row].tname
            cell.typelabel.text = local[indexPath.row].type
            cell.address.text = local[indexPath.row].addr
            
            guard let imgurl = local[indexPath.row].imgPath else { return cell }
            
            
            AF.request(imgurl, method: .get).response{ response in
                
                switch response.result {
                case.success(let responseData):
                    cell.tourimage.image = UIImage(data: responseData!, scale: 1)
                    
                case .failure(let error):
                    print("error",error)
                }
            }
            return cell
            
        case .pensionlist:
           print("pesion")
            cell.tname.text = pensionData.shared.pension[indexPath.row].p_name
            cell.typelabel.text = pensionData.shared.pension[indexPath.row].type
            cell.address.text = pensionData.shared.pension[indexPath.row].addr
            
            guard let imgurl = pensionData.shared.pension[indexPath.row].firstimage else { return cell }
            
            
            AF.request(imgurl, method: .get).response{ response in
                
                switch response.result {
                case.success(let responseData):
                    cell.tourimage.image = UIImage(data: responseData!, scale: 1)
                    
                case .failure(let error):
                    print("error",error)
                }
            }
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        resultViewController.selectrow = indexPath.row
        if type == .tourlist{
        addr = local[resultViewController.selectrow].addr
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = tourDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
