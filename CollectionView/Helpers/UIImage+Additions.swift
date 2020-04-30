//
//  UIImage+Additions.swift
//  CollectionView
//
//  Created by Quentin Genevois on 12/03/2020.
//  Copyright © 2020 Quentin Genevois. All rights reserved.
//

import UIKit

extension UIImageView {
    func image(from url: URL, completionHandler: ((UIImage?) -> Void)? = nil) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in

            guard
                error == nil,
                let httpResponse = response as? HTTPURLResponse,
                200...299 ~= httpResponse.statusCode,
                let data = data else {
                    completionHandler?(nil)
                    return
            }

            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                completionHandler?(self.image)
            }
        }

        dataTask.resume()
    }
}
