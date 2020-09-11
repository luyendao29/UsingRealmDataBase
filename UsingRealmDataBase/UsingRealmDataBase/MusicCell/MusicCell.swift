//
//  MusicCell.swift
//  UsingRealmDataBase
//
//  Created by Boss on 9/12/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import UIKit

class MusicCell: UITableViewCell {
    @IBOutlet weak var artistIdTextView: UITextView!
    @IBOutlet weak var artistNameTextView: UITextView!
    @IBOutlet weak var previewUrlTextView: UITextView!
    
    var listMusic = MusicModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillData() {
        let text = "\(listMusic.artistId ?? 0)"
        artistIdTextView.text = text
        artistNameTextView.text = listMusic.artistName
        previewUrlTextView.text = listMusic.previewUrl
    }
    
    
}
