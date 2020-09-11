//
//  MusicModel.swift
//  UsingRealmDataBase
//
//  Created by Boss on 9/12/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import UIKit

struct BaseDataModel: Codable {
    var resultCount: Int?
    var results: [MusicModel]?
}
struct MusicModel: Codable {
    var artistId: Int?
    var artistName: String?
    var previewUrl: String?
}
