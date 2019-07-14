//
//  UserCollectionViewCell.swift
//  Kite
//
//  Created by kishan kumar on 13/07/19.
//  Copyright © 2019 kishan kumar. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with model: UserModel) {
        nameLabel.text = model.loginName
    }

}
