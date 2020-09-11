//
//  RealmModel.swift
//  UsingRealmDataBase
//
//  Created by Boss on 9/12/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import UIKit
import RealmSwift

class RealmMusicModel: Object {
    @objc dynamic var artistId: Int = 0
    @objc dynamic var artistName: String = ""
    @objc dynamic var previewUrl: String = ""
    
    override class func primaryKey() -> String? {
        return "artistId"
    }
    
    convenience init(musisModel: MusicModel) {
        self.init()
        artistId = musisModel.artistId ?? 0
        artistName = musisModel.artistName ?? ""
        previewUrl = musisModel.previewUrl ?? ""
    }
    
}
