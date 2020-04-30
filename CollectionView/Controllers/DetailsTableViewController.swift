//
//  DetailsTableViewController.swift
//  CollectionView
//
//  Created by Quentin Genevois on 24/03/2020.
//  Copyright © 2020 Quentin Genevois. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var origineLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var numberOfEpisod: UILabel!
    @IBOutlet weak var creationDate: UILabel!

    var serieCharacter: SerieCharacter!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never

        imageView.image(from: serieCharacter.imageURL)
        nameLabel.text = serieCharacter.name
        speciesLabel.text = serieCharacter.species
        statusLabel.text = serieCharacter.status
        origineLabel.text = serieCharacter.origin.name
        genderLabel.text = serieCharacter.gender
        numberOfEpisod.text = "\(serieCharacter.episodes.count)"
        creationDate.text = DateFormatter.localizedString(from: serieCharacter.createdDate,
                                                          dateStyle: .short,
                                                          timeStyle: .short)

    }
}
