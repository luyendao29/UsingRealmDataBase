//
//  BaseRealm.swift
//  UsingRealmDataBase
//
//  Created by Boss on 9/12/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import UIKit
import RealmSwift

final class BaseRealm {
    
    static let shared = BaseRealm()
    
    private var realm: Realm = try! Realm()
    private init() {
    }
    func saveObjects(_ obj: [Object]) {
        try! realm.write({
            realm.add(obj)
        })
    }
    
//    func getAllObject<T: Object>(_ type: T.Type) -> [T] {
//    func getAllObject() -> [myModel1] {
//        let objects = realm.objects(myModel1.self)
//        return objects.map { $0 }
//    }
    func getAllObject<T: Object>(_ type: T.Type) -> [T] {
        let objects = realm.objects(type).toArray(ofType: T.self)
        return objects
    }
    
    // delete exactly an object with id and type
    func deleteObject(_ id: String, withType type: Object.Type) {
        let pedicate = NSPredicate(format: "id == %@", id)
        if let itemDelete = realm.objects(type).filter(pedicate).first {
            try! realm.write({
                realm.delete(itemDelete)
            })
        }
    }
    
    // delete all objects in Realm DB
    func deleteAllObjects() {
        try! realm.write({
            realm.deleteAll()
        })
    }
    
    func updateObject<T: Object>(_ object: T) {
        try! realm.write({
            realm.add(object, update: .modified)
        })
    }
    // hàm check trùng xem đã có chưa.có rồi thì không cho lưu lại  nữa
    func checkObjectAreadyExisted(_ id: String, withType type: Object.Type) -> Bool {
        return realm.object(ofType: type, forPrimaryKey: id) != nil
    }
    
    func checkObjectAreadyExistedInt(_ id: Int, withType type: Object.Type) -> Bool {
        return realm.object(ofType: type, forPrimaryKey: id) != nil
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            let result = self[i]
            array.append(result as! T)
        }
        return array
    }
}
