//
//  MainViewController.swift
//  ClimaApril
//
//  Created by Djinsolobzik on 24.04.2023.
//

import UIKit

private enum Constants {
    enum Color {
        static let backgroundColor = UIColor.systemBackground
    }

    enum Dimension {
        static let sectionHeaderHeight: CGFloat = 56.0
        static let rowHeight: CGFloat = 100
        static let numberSections = 2
    }
}

private enum Section: Int, CaseIterable {
    case ClimeToday
    case ClimeDay
}

class MainViewController: UIViewController {

    // MARK: - Private Properties
    private var presenter: MainPresenterProtocol

    private lazy var refreshControl = UIRefreshControl()

    private lazy var climeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
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

    func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionId, environment in
            switch sectionId {
            case 0: return self?.createSectionLayoutDayClime(environment: environment)
            case 1: return self?.createSectionLayoutForWeekClime(environment: environment)
            default: return self?.createSectionLayoutForWeekClime(environment: environment)
            }
        })

        return layout
    }

    func createSectionLayoutDayClime(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(300))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        return section
    }

    func createSectionLayoutForWeekClime(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        return section
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
            guard
                let model
            else {
                return cell
            }
            cell.locationLabel.text = model.geoObject.locality.name
            cell.currentTemperatureLabel.text = "\(model.fact.temp) ℃"

            return cell
        case .ClimeDay:
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClimeDayCell.reuseIdentifier, for: indexPath) as? ClimeDayCell
            else {
                return UICollectionViewCell()
            }

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
