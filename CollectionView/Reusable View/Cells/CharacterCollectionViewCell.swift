//
//  CharacterCollectionViewCell.swift
//  CollectionView
//
//  Created by Quentin Genevois on 14/01/2020.
//  Copyright © 2020 Quentin Genevois. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
}

extension CharacterCollectionViewCell {
    func configure(with serieCharacter: SerieCharacter) {
        nameLabel.text = serieCharacter.name
        detailLabel.text = serieCharacter.species
        imageView.image(from: serieCharacter.imageURL)
        imageView.layer.cornerRadius = 10
    }
}
