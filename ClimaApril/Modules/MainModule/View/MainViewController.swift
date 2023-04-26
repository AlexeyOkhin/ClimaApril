//
//  MainViewController.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 24.04.2023.
//

import UIKit
import SVGKit

private enum Constants {
    enum Color {
        static let backgroundColor = UIColor.systemBackground
    }
}

private enum Section: Int, CaseIterable {
    case ClimeToday
    case ClimeHour
    case ClimeDay
}

final class MainViewController: UIViewController {

    // MARK: - Private Properties
    private var presenter: MainPresenterProtocol

    private lazy var refreshControl = UIRefreshControl()
    private lazy var compositionLayout = ClimeCompositionLayout()

    private lazy var climeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionLayout.configureCompositionalLayout())
        collectionView.register(ClimeTodayCell.self, forCellWithReuseIdentifier: ClimeTodayCell.reuseIdentifier)
        collectionView.register(ClimeDayCell.self, forCellWithReuseIdentifier: ClimeDayCell.reuseIdentifier)
        collectionView.register(ClimeHourCell.self, forCellWithReuseIdentifier: ClimeHourCell.reuseIdentifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: "SectionWeek", withReuseIdentifier: SectionHeader.reuseIdentifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: "SectionHour", withReuseIdentifier: SectionHeader.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - Init

    init (presenter: MainPresenterProtocol) {

        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        settingRefreshControl()
        presenter.setLocationClime()
    }
}

    // MARK: - Private Methods
private extension MainViewController {

    func setupUI() {

        view.backgroundColor = .systemBackground
        view.addSubviews(climeCollectionView) {[
            climeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            climeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            climeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            climeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]}
    }

    func settingRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Обновляю...")
        refreshControl.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        climeCollectionView.refreshControl = refreshControl
    }

    @objc
    func didRefresh() {
        presenter.setLocationClime()
    }
}

// MARK: - Extension UITableViewDataSource

extension MainViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }

        switch section {

        case .ClimeToday:
            return 1

        case .ClimeHour:
            guard
                let hoursCount = presenter.clime?.forecasts[0].hours.count
            else {
                return 0
            }
            return hoursCount

        case .ClimeDay:
            guard
                let forecastsCount = presenter.clime?.forecasts.count
            else {
                return 0
            }
            return forecastsCount
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let section = Section(rawValue: indexPath.section)
        else {
            return UICollectionViewCell()
        }

        switch section {
            
        case .ClimeToday:
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClimeTodayCell.reuseIdentifier, for: indexPath) as? ClimeTodayCell
            else {
                return UICollectionViewCell()
            }
            
            let model = presenter.clime
            guard let model else { return cell }
            cell.locationLabel.text = model.geoObject.locality.name
            cell.currentTemperatureLabel.text = "\(model.fact.temp) ℃"
            let icon = model.fact.icon
            let stringUrl = presenter.getUrlIcon(with: icon)
            cell.conditionImageView.loadImage(from: stringUrl)
            cell.conditionLabel.text = model.fact.condition.rawValue
            return cell
            
        case .ClimeHour:
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClimeHourCell.reuseIdentifier, for: indexPath) as? ClimeHourCell
            else {
                return UICollectionViewCell()
            }
            let model = presenter.clime?.forecasts[0].hours[indexPath.row]
            guard let model else { return cell }
            let icon = model.icon
            let stringUrl = presenter.getUrlIcon(with: icon)
            cell.conditionImageView.loadImage(from: stringUrl)

            cell.hourLabel.text = model.hour
            cell.tempLabel.text = String(model.temp)

            return cell
            
        case .ClimeDay:
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClimeDayCell.reuseIdentifier, for: indexPath) as? ClimeDayCell
            else {
                return UICollectionViewCell()
            }
            let model = presenter.clime?.forecasts[indexPath.row]
            guard let model else { return cell }
            cell.weekdayLabel.text = presenter.getDayWeek(at: indexPath.row)
            let icon = model.parts.dayShort.icon
            let stringUrl = presenter.getUrlIcon(with: icon)
            cell.conditionImageView.loadImage(from: stringUrl)
            let minTemp = model.parts.dayShort.tempMin
            let temp = model.parts.dayShort.temp
            cell.rangeTempLabel.text = "\(minTemp)℃...\(temp)℃"
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "SectionHour" {
            guard
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader
            else {
                return UICollectionReusableView()
            }
             sectionHeader.label.text = "Прогноз на сутки"
             return sectionHeader
        } 

        if kind == "SectionWeek" {
            guard
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader
            else {
                return UICollectionReusableView()
            }
             sectionHeader.label.text = "Прогноз на неделю"
             return sectionHeader
        }

        return UICollectionReusableView()

    }
}

// MARK: - Extension MainViewProtocol

extension MainViewController: MainViewProtocol {
    func reloadData() {
        climeCollectionView.reloadData()
    }

    func refreshData() {
        refreshControl.endRefreshing()
    }

    func showError(with error: String) {
        showErrorAlert(and: error)
    }
}
