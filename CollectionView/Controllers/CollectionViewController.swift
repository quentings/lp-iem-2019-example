//
//  ViewController.swift
//  CollectionView
//
//  Created by Quentin Genevois on 09/01/2020.
//  Copyright © 2020 Quentin Genevois. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    private enum Section: Int, CaseIterable {
        case characters
        case locations
    }

    private var serieCharacters: [SerieCharacter] = [] {
        didSet {
            collectionView.reloadSections(IndexSet(arrayLiteral: Section.characters.rawValue))
        }
    }

    private var locations: [Location] = [] {
        didSet {
            collectionView.reloadSections(IndexSet(arrayLiteral: Section.locations.rawValue))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchSerieCharacters()
        fetchLocations()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? DetailsTableViewController,
            let sender = sender as? UICollectionViewCell else {
            return
        }

        let indexPath = collectionView.indexPath(for: sender)!

        destination.serieCharacter = serieCharacters[indexPath.item]
    }

    // MARK: - API Calls

    private func fetchSerieCharacters() {
        NetworkingManager.shared.fetchSerieCharacters { [weak self] (result) in
            guard let self = self else {
                return
            }

            switch result {
            case .failure(let error):
                self.presenterAlertController(from: error)

            case .success(let paginedElement):
                self.serieCharacters = paginedElement.decodedElement
            }
        }
    }

    private func fetchLocations() {
        NetworkingManager.shared.fetchLocations { [weak self] (result) in
            guard let self = self else {
                return
            }

            switch result {
            case .failure(let error):
                self.presenterAlertController(from: error)

            case .success(let paginedElement):
                self.locations = paginedElement.decodedElement
            }
        }
    }

    // MARK: - Private Methods

    /// Present a `UIAlertController` from a given error.
    /// - Parameter error: The error to display
    private func presenterAlertController(from error: Error) {
        let alertController = UIAlertController(title: "Erreur",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)

        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)

        alertController.addAction(action)
        alertController.preferredAction = action

        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - CollectionView Methods

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section.allCases[section] {
        case .characters:
            return serieCharacters.count

        case .locations:
            return locations.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section.allCases[indexPath.section] {
        case .characters:
            let cell = collectionView.dequeueReusableItem(CharacterCollectionViewCell.self, at: indexPath)
            cell.configure(with: serieCharacters[indexPath.row])
            return cell

        case .locations:
            let cell = collectionView.dequeueReusableItem(LocationCollectionViewCell.self, at: indexPath)
            cell.configure(with: locations[indexPath.row].name)
            return cell
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: "HeaderCollectionReusableView",
                                                                         for: indexPath) as! HeaderCollectionReusableView

        switch Section.allCases[indexPath.section] {
        case .characters:
            headerView.configure(title: "Personnages",
                                 image: UIImage(systemName: "person.fill")!)

        case .locations:
            headerView.configure(title: "Planètes",
                                 image: UIImage(systemName: "airplane")!)
        }

        return headerView
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch Section.allCases[indexPath.section] {
        case .characters:
            return .init(width: 150, height: 200)

        case .locations:
            return .init(width: 300, height: 50)
        }
    }

}
