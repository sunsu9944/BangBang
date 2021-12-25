//
//  DistanceViewController.swift
//  BangBang
//
//  Created by 고준혁 on 2021/12/07.
//

import UIKit

var dist:Int = 0


class DistanceViewController: UIViewController {
    
    let distance = ["20KM","50KM","100KM","150KM","제한없음"]
    let senddistance:[Int] = [20,50,100,150,500]
    
    let distancebt: UITableView = {
        let table = UITableView()
        
        table.register(DistanceTableViewCell.self, forCellReuseIdentifier: DistanceTableViewCell.distancetableViewCellindentifeir)
        table.rowHeight = 70
        
        return table
    }()
    
    
    
    func addview() {
        
        view.addSubview(distancebt)
        
        
        
    }
    
    func autolayout() {
        
        distancebt.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(view).offset(view.safeAreaInsets.top)
            make.bottom.equalTo(view).offset(view.safeAreaInsets.bottom)
        }

    }
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addview()
        autolayout()
        navigationItem.titleView =  navigationDistancetitle()
        
        distancebt.delegate = self
        distancebt.dataSource = self
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DistanceViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DistanceTableViewCell.distancetableViewCellindentifeir, for: indexPath) as! DistanceTableViewCell
        
        cell.distancelabel.text = distance[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dist = senddistance[indexPath.row]
        
        let vc = CustomTripViewController()
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        print(dist)
    }
    
    
}
