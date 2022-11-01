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
        let iconUrl = "\(PurchaseEndPoint.link.rawValue)\(url)"
        if let url = URL(string: iconUrl) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                DispatchQueue.main.async {
                    guard let data = data,
                          let image = UIImage(data: data) else { return }
                    self.image = image
                }
            }.resume()
        }
    }
}
