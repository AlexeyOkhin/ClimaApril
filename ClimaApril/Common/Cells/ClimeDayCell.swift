//
//  ClimaDayCell.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 24.04.2023.
//

import UIKit

private enum Constants {

    enum Color {

    }

    enum Dimension {
        static let standardOffset: CGFloat = 16
    }
}


final class ClimeDayCell: UICollectionViewCell {

    // MARK: - Static Properties

    static let reuseIdentifier = "\(ClimeDayCell.self)"

    // MARK: - Private properties

    lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Сегодня"
        return label
    }()

    lazy var conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "questionmark.square.dashed")
        return imageView
    }()

    lazy var rangeTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "от 21 до 40"
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
    }


    // MARK: - Private Methods

    private func setupUI() {
        let hStack = UIStackView(arrangedSubviews: [weekdayLabel, conditionImageView, rangeTempLabel])
        hStack.distribution = .fillEqually

        contentView.addSubviews(hStack) {[
            hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Dimension.standardOffset),
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Dimension.standardOffset),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Dimension.standardOffset),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Dimension.standardOffset)
        ]}

        for i in 0..<contentView.constraints.count {
           contentView.constraints[i].priority = .init(999)
        }
    }
}
