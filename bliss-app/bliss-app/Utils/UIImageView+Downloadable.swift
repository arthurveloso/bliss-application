//
//  UIImageView+Downloadable.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 24/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import UIKit

extension UIImageView {

    func downloaded(from url: URL, completion: @escaping (Data) -> Void) {
        contentMode = .scaleAspectFit
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data),
                let pngData = image.pngData()
                else { return }
            completion(pngData)
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }

    func downloaded(from link: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url) { data in
            completion(data)
        }
    }
}
