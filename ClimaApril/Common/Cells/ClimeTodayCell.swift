//
//  ClimeTodayCell.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 24.04.2023.
//

import UIKit

private enum Constants {

    enum Color {
        static let textLocation = UIColor.label
        static let textCurrentTemperature = UIColor.label
        static let textCondition = UIColor.label
    }

    enum Dimension {
        static let sizeFontForLocation: CGFloat = 26.0
        static let sizeFontForCurrentTemperature: CGFloat = 48
        static let sizeFontForCondition: CGFloat = 18
        static let standardOffset: CGFloat = 16
        static let imageSize: CGFloat = 125
    }

    enum Font {

    }
}

final class ClimeTodayCell: UICollectionViewCell {

    // MARK: - Static Properties

    static let reuseIdentifier = "\(ClimeTodayCell.self)"

    // MARK: - Private properties

    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: Constants.Dimension.sizeFontForLocation)
        label.textColor = Constants.Color.textLocation
        label.textAlignment = .center
        label.text = "Orenburg"
        return label
    }()

    lazy var currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.Dimension.sizeFontForCurrentTemperature)
        label.textColor = Constants.Color.textCurrentTemperature
        label.text = "21℃"
        return label
    }()

    lazy var conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "questionmark.square.dashed")
        return imageView
    }()

    lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: Constants.Dimension.sizeFontForCondition)
        label.textColor = Constants.Color.textCondition
        label.text = ""
        label.textAlignment = .center
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
        
        contentView.addSubviews(locationLabel, currentTemperatureLabel, conditionImageView, conditionLabel) {[
            locationLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            conditionImageView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: Constants.Dimension.standardOffset),
            conditionImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -Constants.Dimension.standardOffset * 2),
            conditionImageView.heightAnchor.constraint(equalToConstant: Constants.Dimension.imageSize),
            conditionImageView.widthAnchor.constraint(equalToConstant: Constants.Dimension.imageSize),

            currentTemperatureLabel.leadingAnchor.constraint(equalTo: conditionImageView.trailingAnchor, constant: Constants.Dimension.standardOffset),
            currentTemperatureLabel.centerYAnchor.constraint(equalTo: conditionImageView.centerYAnchor),

            conditionLabel.topAnchor.constraint(equalTo: conditionImageView.bottomAnchor, constant: Constants.Dimension.standardOffset / 2),
            conditionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Dimension.standardOffset),
            conditionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Dimension.standardOffset),
            conditionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Dimension.standardOffset)

        ]}
    }
}

extension ClimeTodayCell {
    func configure(with model: ClimeModel) {

    }
}
