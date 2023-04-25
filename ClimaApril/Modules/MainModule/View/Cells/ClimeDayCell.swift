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

    }

    enum Font {

    }
}


final class ClimeDayCell: UICollectionViewCell {

    // MARK: - Static Properties

    static let reuseIdentifier = "\(ClimeDayCell.self)"

    // MARK: - Private properties

    private lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня"
        return label
    }()

    private lazy var conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "questionmark.square.dashed")
        return imageView
    }()

    private lazy var rangeTempLabel: UILabel = {
        let label = UILabel()
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
        contentView.addSubviews(weekdayLabel, conditionImageView, rangeTempLabel) {[
            weekdayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            weekdayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            conditionImageView.leadingAnchor.constraint(equalTo: weekdayLabel.trailingAnchor, constant: 8),
            conditionImageView.widthAnchor.constraint(equalToConstant: 24),
            conditionImageView.heightAnchor.constraint(equalToConstant: 24),
            conditionImageView.centerYAnchor.constraint(equalTo: weekdayLabel.centerYAnchor),
            conditionImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            rangeTempLabel.leadingAnchor.constraint(equalTo: conditionImageView.trailingAnchor, constant: 8),
            rangeTempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)

        ]}
    }
}
