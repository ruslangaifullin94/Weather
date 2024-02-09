//
//  HourlyViewController.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 16.01.2024.
//

import UIKit
import Combine

final class HourlyViewController: NiblessViewController {
    
    enum Section {
        case graph
        case main
    }
    
    enum Cell: Hashable {
        case graph(weather: [WeatherHour])
        case hourly(weather: WeatherHour)
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Cell>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Cell>
        
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel: HourlyViewModel
    
    private lazy var layout = UICollectionViewCompositionalLayout(
        sectionProvider: { [weak self] _, _ in
            return self?.makeLayout()
    }, configuration: UICollectionViewCompositionalLayoutConfiguration()
            .with(\.scrollDirection, setTo: .vertical)
    )
    
    private lazy var dataSource = self.makeDataSource()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        .with {
            $0.registerHeader(HeaderCell.self)
            $0.register(GraphCell.self)
            $0.register(HourCell.self)
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .second
        }
    
    init(viewModel: HourlyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindingModel()
        viewModel.getWeather()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func bindingModel() {
        viewModel.$state
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .initial:
                    ()
                case .loaded(let city):
                    self.makeSnapshot(city: city)
                    self.dataSource.supplementaryViewProvider = self.makeHeaderProvider(city: city.name)
                }
            }.store(in: &subscriptions)
    }
    
    private func makeLayout() -> NSCollectionLayoutSection? {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(155))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(155))
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(30)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )

        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: LayoutConstants.singleOffset,
            bottom: 0,
            trailing: LayoutConstants.singleOffset
        )
        section.interGroupSpacing = LayoutConstants.oneAndHalfOffset
        return section
    }
    
    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .graph(let weather):
                return collectionView
                    .dequeueCell(GraphCell.self, for: indexPath)
                    .configuredCell(data: weather)
            case .hourly(let weather):
                return collectionView
                    .dequeueCell(HourCell.self, for: indexPath)
                    .configuredCell(data: weather)
            }
        }
    }
    
    private func makeSnapshot(city: City) {
        var snapshot = Snapshot()
        snapshot.appendSections([.graph])
        snapshot.appendItems([.graph(weather: city.weather.forecasts[0].hours)], toSection: .graph)
        snapshot.appendSections([.main])
        city.weather.forecasts[0].hours.forEach { hour in
            snapshot.appendItems([.hourly(weather: hour)], toSection: .main)
        }
        dataSource.apply(snapshot)
    }
    
    private func makeHeaderProvider(city: String) -> (UICollectionView, String, IndexPath) -> UICollectionReusableView? {
        return { [weak self] collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let section = self?.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            
            let header: HeaderCell = collectionView.dequeueHeader(for: indexPath)
            if section == .graph {
                header.title = "UI.HoursVC.chart".localized
            } else {
                header.title = city
            }
            return header
        }
    }
    
    
}

