//
//  Extension+String.swift
//  MovieRoadMap
//
//  Created by Dima Kovrigin on 28.10.2022.
//

import UIKit
/// Изменение настроек строки
extension NSMutableAttributedString {
    var fontSize: CGFloat {
        13
    }
    var boldFont: UIFont {
        UIFont.boldSystemFont(ofSize: fontSize)
    }
    var normalFont: UIFont {
        UIFont.systemFont(ofSize: fontSize)
    }
    func bold(_ value: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: boldFont,
            .foregroundColor: UIColor.label
        ]
        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    func normal(_ value: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Avenir-Heavy", size: 24) as Any,
            .foregroundColor: UIColor.label
        ]
        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }

    func normalGray(_ value: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Avenir-Heavy", size: 24) as Any,
            .foregroundColor: UIColor.secondaryLabel
        ]
        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
}
