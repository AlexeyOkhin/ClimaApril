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

    private lazy var climeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        collectionView.register(ClimeTodayCell.self, forCellWithReuseIdentifier: ClimeTodayCell.reuseIdentifier)
        collectionView.register(ClimeDayCell.self, forCellWithReuseIdentifier: ClimeDayCell.reuseIdentifier)
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        let climeService = ClimeServices(networkService: NetworkService(), requestFactory: URLRequestFactory(latitude: 51.7727, longitude: 55.0988))
        climeService.getClime { [weak self] result in
            switch result {

            case .success(let climeModel):

                print(climeModel)

            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showErrorAlert(and: error.localizedDescription)
                }

            }
        }
    }

    // MARK: - Private Methods

    private func setupUI() {

        view.backgroundColor = .systemBackground
        view.addSubviews(climeCollectionView) {[
            climeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            climeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            climeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            climeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]}
    }

    func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionId, environment in
            switch sectionId {
            case 0: return self?.createSectionLayout1(environment: environment)
            case 1: return self?.createSectionLayout2(environment: environment)
            default: return self?.createSectionLayout2(environment: environment)
            }
        })

        return layout
    }

    func createSectionLayout1(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
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

    func createSectionLayout2(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
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
            return 7
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
