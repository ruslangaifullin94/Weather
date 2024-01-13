//
//  HomeViewController.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 08.10.2023.
//

import UIKit
import SnapKit
import Combine

class HomeViewController: NiblessViewController {
    
    
    typealias DataSource = UICollectionViewDiffableDataSource<Sections, Cell>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Sections, Cell>
    
    enum Sections {
        case main
        case timing
        case days
    }
    
    enum Cell: Hashable {
        case main(weather: FactWeather)
        case timing(model: WeatherHour)
        case days(forecasts: ForecastsWeather)
    }
    
    weak var delegate: PageViewModelDelegate?
    private var viewModel: HomeViewModel
    private var subscriptions = Set<AnyCancellable>()

    private lazy var dataSource = makeDataSource()
    private var snapshot: Snapshot {
        dataSource.snapshot()
    }
    
    private lazy var layout = UICollectionViewCompositionalLayout(
        sectionProvider: { [weak self] sectionIndex, _ in
            guard let sections = self?.snapshot.sectionIdentifiers,
                  let section = sections[safeIndex: sectionIndex] else { return nil }
            return LayoutBuilderHomeViewController()
                .build(for: section)
        }, configuration: UICollectionViewCompositionalLayoutConfiguration()
            .with(\.scrollDirection, setTo: .vertical)
    )
    
    private lazy var refreshControl = UIRefreshControl()
        .with {
            $0.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        }
    
    private lazy var shimmer = ShimmeringView()
        .with(\.alpha, setTo: 0)
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: layout)
        .with {
            $0.register(MainCell.self)
            $0.register(WeatherDayCell.self)
            $0.register(WeatherTimeCell.self)
            $0.showsVerticalScrollIndicator = false
            $0.refreshControl = refreshControl
            $0.delegate = self
            $0.backgroundColor = .clear
        }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindingModel()
    }
    
    private func setupView() {
        view.addSubviews(collectionView, shimmer)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        shimmer.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(LayoutConstants.singleOffset)
            $0.height.equalTo(212)
        }
    }
    
    private func bindingModel() {
        viewModel.$state.sink { [weak self] state in
            guard let self else { return }
            switch state {
            case .loading:
                collectionView.alpha = 0
                shimmer.alpha = 1
                shimmer.startShimmering()
            case .loaded(let city):
                makeSnapshot(city: city)
                navigationItem.title = city.name
                delegate?.updateTitle(title: city.name)
                refreshControl.endRefreshing()
                collectionView.alpha = 1
                shimmer.stopShimmering()
                shimmer.removeFromSuperview()
            case .error(let error):
                print(error)
           
            }
        }.store(in: &subscriptions)
    }
    
    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .main(let weather):
                return collectionView
                    .dequeueCell(MainCell.self, for: indexPath)
                    .configuredCell(data: weather)
            case .timing(let model):
                return collectionView
                    .dequeueCell(WeatherTimeCell.self, for: indexPath)
                    .configuredCell(data: model)
            case .days(let weather):
                return collectionView
                    .dequeueCell(WeatherDayCell.self, for: indexPath)
                    .configuredCell(data: weather)
            }
        }
    }
    
    private func makeSnapshot(city: City) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main, .timing, .days])
        snapshot.appendItems([.main(weather: city.weather.fact)], toSection: .main)
        city.weather.forecasts[0].hours.forEach {
            snapshot.appendItems([.timing(model: $0)], toSection: .timing)
        }
        city.weather.forecasts.forEach {
            snapshot.appendItems([.days(forecasts: $0)], toSection: .days)
        }
        dataSource.apply(snapshot)
    }
    
    @objc private func refreshData() {
        viewModel.refresh()
    }
    
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
 
}
