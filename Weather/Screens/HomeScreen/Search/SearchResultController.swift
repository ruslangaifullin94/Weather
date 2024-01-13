//
//  SearchController.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 28.12.2023.
//

import UIKit
import Combine

final class SearchResultController: NiblessViewController {
    // MARK: - Types
    enum Section: Hashable {
        case results
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, CitySearchModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CitySearchModel>
    
    weak var delegate: PageViewControllerDelegate?
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Layout
    private let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
        let contentInsets = NSDirectionalEdgeInsets(
            top: LayoutConstants.smallOffset,
            leading: LayoutConstants.singleOffset,
            bottom: .zero,
            trailing: LayoutConstants.singleOffset
        )
        
        return .singleRowSection(height: .estimated(resultRowHeight))
            .with(\.contentInsets, setTo: contentInsets)
            .with(\.interGroupSpacing, setTo: LayoutConstants.smallOffset)
    }
    
    // MARK: - Views
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: layout
    ).with {
        $0.clipsToBounds = false
        $0.keyboardDismissMode = .onDrag
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.register(SearchResultCell.self)
    }
    
    private var searchBar: UISearchBar
    
    private lazy var dataSource = makeDataSource()
    let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel, searchBar: UISearchBar) {
        self.viewModel = viewModel
        self.searchBar = searchBar
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
                case .loaded(let results):
                    makeSnapshot(with: results)
                case .error(let error):
                    print(error)
                }
            }.store(in: &subscriptions)
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(LayoutConstants.oneAndHalfOffset)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView
                .dequeueCell(SearchResultCell.self, for: indexPath)
                .configuredCell(data: itemIdentifier)
        }
    }
    
    private func makeSnapshot(with results: [CitySearchModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.results])
        snapshot.appendItems(results, toSection: .results)
        dataSource.apply(snapshot)
    }
    private func hideSearchResultView(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
        searchBar.text = ""
        searchBar.searchTextField.attributedPlaceholder = NSMutableAttributedString {
            AttributedText("Strings.searchEmployee")
                .font(.rubik(size: 14, weight: .regular))
                .foregroundColor(.secondText)
        }
        searchBar.delegate = (parent as? PageViewController)
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
}

extension SearchResultController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        let userLocation = UserLocation(longitude: item.longitude, latitude: item.latitude)
        delegate?.addLocation(location: userLocation, title: item.name)
        hideSearchResultView(searchBar: searchBar)
    }
}
extension SearchResultController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newString = NSMutableAttributedString(string: searchBar.text ?? "")
        newString.replaceCharacters(in: range, with: text)
        viewModel.searchCities(text: newString.string)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchResultView(searchBar: searchBar)
        delegate?.didTapCancel()
       
    }
}

extension SearchResultController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        (textField.text?.trimmingCharacters(in: .newlines)).map { text in
            viewModel.searchCities(text: text)
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        viewModel.clearResults()
        
        return true
    }
}


private let resultRowHeight: CGFloat = 56
