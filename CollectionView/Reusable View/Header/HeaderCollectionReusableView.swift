//
//  HeaderCollectionReusableView.swift
//  CollectionView
//
//  Created by Quentin Genevois on 12/03/2020.
//  Copyright © 2020 Quentin Genevois. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
}

extension HeaderCollectionReusableView {
    func configure(title: String, image: UIImage) {
        imageView.image = image
        label.text = title
    }
}
