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
        presenter.loadClime()
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
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        climeCollectionView.refreshControl = refreshControl
    }

    @objc
    func didRefresh() {
        presenter.loadClime()
    }
}

// MARK: - Extension UITableViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard
            let section = Section(rawValue: section)
        else {
            return 0
        }

        switch section {

        case .ClimeToday:
            return 1
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
            cell.conditionLabel.text = model.fact.condition
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
