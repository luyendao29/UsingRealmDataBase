//
//  ViewController.swift
//  UsingRealmDataBase
//
//  Created by Boss on 9/12/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import UIKit
import Reachability
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var listMusic = [MusicModel]()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(realm.configuration)
        tableView.register(UINib(nibName: "MusicCell", bundle: nil), forCellReuseIdentifier: "MusicCell")
        checkInternet()
    }
    
    func checkInternet() {
        let checkInternet = NetworkManager.sharedInstance.reachability.connection
        switch checkInternet {
        case .unavailable:
            // check không có interNet lấy realm vừa lưu ra hiển thị
            let listMusics = BaseRealm.shared.getAllObject(RealmMusicModel.self)
            listMusics.forEach { object in
                let object = MusicModel(artistId: object.artistId, artistName: object.artistName, previewUrl: object.previewUrl)
                listMusic.append(object)
                self.tableView.reloadData()
            }
        case .wifi:
            callApi()
        default:
            break
        }
    }
    
    func callApi() {
        DataService.sharing.callAPI { data in
            if let results = data.results {
                self.listMusic = results
                // khi lấy data Về Save vào Realm
                results.forEach { object in
                    let object = RealmMusicModel(musisModel: object)
                    // check nếu đã lưu vào rồi check trùng để không lưu lại lần nữa
                    if !BaseRealm.shared.checkObjectAreadyExistedInt(object.artistId, withType: RealmMusicModel.self) {
                        BaseRealm.shared.saveObjects([object])
                        
                    }
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMusic.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicCell
        cell.listMusic = listMusic[indexPath.row]
        cell.fillData()
        return cell
       }
    


}

