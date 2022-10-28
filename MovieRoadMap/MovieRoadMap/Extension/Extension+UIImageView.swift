//
//  Extension+UIImageView.swift
//  MovieRoadMap
//
//  Created by Dima Kovrigin on 26.10.2022.
//

import UIKit
/// Загрузка картинки
extension UIImageView {
    func loadImage(with url: String, placeHolder: UIImage? = nil) {
        image = nil
        let iconUrl = "https://image.tmdb.org/t/p/w500\(url)"
        if let url = URL(string: iconUrl) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                DispatchQueue.main.async {
                    if let data = data {
                        if let image = UIImage(data: data) {
                            self.image = image
                        }
                    }
                }
            }.resume()
        }
    }
}
