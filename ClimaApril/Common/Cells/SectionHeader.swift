//
//  SectionHeader.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 26.04.2023.
//

import UIKit

final class SectionHeader: UICollectionReusableView {

    static let reuseIdentifier = "\(SectionHeader.self)"

     var label: UILabel = {
         let label: UILabel = UILabel()
         label.textColor = .systemGray
         label.font = UIFont.systemFont(ofSize: 16)
         return label
     }()

     override init(frame: CGRect) {
         super.init(frame: frame)

         addSubview(label)

         label.translatesAutoresizingMaskIntoConstraints = false
         label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
         label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
         label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
