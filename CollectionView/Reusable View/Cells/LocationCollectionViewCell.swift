//
//  LocationCollectionViewCell.swift
//  CollectionView
//
//  Created by Quentin Genevois on 12/03/2020.
//  Copyright © 2020 Quentin Genevois. All rights reserved.
//

import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
}

extension LocationCollectionViewCell {
    func configure(with name: String) {
        nameLabel.text = name

        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 6
    }
}
