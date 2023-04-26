//
//  ClimeHourCell.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 26.04.2023.
//

import UIKit

private enum Constants {

    enum Dimension {
        static let standardOffset: CGFloat = 16
    }
}

final class ClimeHourCell: UICollectionViewCell {

    // MARK: - Static Properties

    static let reuseIdentifier = "\(ClimeHourCell.self)"

    // MARK: - Private properties

    lazy var hourLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "0"
        return label
    }()

    lazy var conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "questionmark.square.dashed")
        return imageView
    }()

    lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "0"
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        hourLabel.text = nil
        conditionImageView.image = nil
        tempLabel.text = nil
    }


    // MARK: - Private Methods

    private func setupUI() {
        let vStack = UIStackView(arrangedSubviews: [hourLabel, conditionImageView, tempLabel])
        vStack.distribution = .fillEqually
        vStack.axis = .vertical

        contentView.addSubviews(vStack) {[
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Dimension.standardOffset),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Dimension.standardOffset),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Dimension.standardOffset),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Dimension.standardOffset)
        ]}

        for i in 0..<contentView.constraints.count {
           contentView.constraints[i].priority = .init(999)
        }
    }
}

