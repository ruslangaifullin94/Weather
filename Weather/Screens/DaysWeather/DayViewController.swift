//
//  DayViewController.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 14.01.2024.
//

import UIKit
import Combine

final class DayViewController: NiblessViewController {
    
    enum Section: Hashable {
        case days
        case forecasts
        case moon
    }
    
    enum Cell: Hashable {
        case day(day: ForecastsWeather)
        case forecast(day: DayWeather)
        case moon
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Cell>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Cell>
    
    private var subscriptions = Set<AnyCancellable>()
    private lazy var dataSource = makeDataSource()
    private var snapshot: Snapshot {
        dataSource.snapshot()
    }
    private var viewModel: DayViewModel
    
    private lazy var layout = UICollectionViewCompositionalLayout(
        sectionProvider: { [weak self] sectionIndex, _ in
        guard let sections = self?.snapshot.sectionIdentifiers,
              let section = sections[safeIndex: sectionIndex] else { return nil }
        return LayoutBuilderDayController()
            .build(section: section)
    }, configuration: UICollectionViewCompositionalLayoutConfiguration()
        .with(\.scrollDirection, setTo: .vertical)
    )
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: layout)
        .with {
            $0.register(DayCell.self)
            $0.register(DateCell.self)
            $0.delegate = self
            $0.backgroundColor = .clear
        }
    
    init(viewModel: DayViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindingModel()
    }
    

    private func bindingModel() {
        viewModel.$state
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .initial:
                    ()
                case .loaded(let city):
                    makeSnapshot(city: city)
                    navigationItem.title = city.name
                }
            }.store(in: &subscriptions)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .day(let day):
                return collectionView
                    .dequeueCell(DateCell.self, for: indexPath)
                    .configuredCell(data: day)
            case .forecast(let day):
                    return collectionView
                    .dequeueCell(DayCell.self, for: indexPath)
                    .configuredCell(data: day)
            case .moon:
                return UICollectionViewCell()
            }
        }
    }
    
    private func makeSnapshot(city: City) {
        var snapshot = Snapshot()
        snapshot.appendSections([.days, .forecasts])
        city.weather.forecasts.forEach {
            snapshot.appendItems([.day(day: $0)], toSection: .days)
        }
        dataSource.apply(snapshot)
    }
    
}

extension DayViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = dataSource.itemIdentifier(for: indexPath) else { return false }
        switch cell {
        case .day:
            return true
        case .forecast:
            return false
        case .moon:
            return false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = dataSource.itemIdentifier(for: indexPath) else { return }
        switch cell {
        case .day(let day):
            collectionView.cellForItem(at: indexPath)?.backgroundColor = .main
            var snapshot = dataSource.snapshot()
            snapshot.deleteSections([.forecasts])
            snapshot.appendSections([.forecasts])
            snapshot.appendItems([.forecast(day: day.parts.day), .forecast(day: day.parts.night)], toSection: .forecasts)
            dataSource.apply(snapshot)
        case .forecast:
            ()
        case .moon:
            ()
        }
    }
}
