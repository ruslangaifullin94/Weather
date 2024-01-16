//
//  PageViewController.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 11.01.2024.
//

import UIKit
import Combine

protocol PageViewControllerDelegate: AnyObject {
    func didTapCancel()
    func addLocation(location: UserLocation, title: String)
}

final class PageViewController: NiblessViewController {
    
    private var viewModel: PageViewModel
    private lazy var viewControllers: [UIViewController] = viewModel.viewControllers
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                               navigationOrientation: .horizontal,
                                                               options: nil)
        .with {
            $0.dataSource = self
            $0.delegate = self
        }
    
    private lazy var pageControl = UIPageControl()
        .with {
            $0.numberOfPages = viewControllers.count
            $0.pageIndicatorTintColor = .systemGray3
            $0.currentPageIndicatorTintColor = .mainText
        }
    
    private var searchBarContainer = UIView()
        .with(\.clipsToBounds, setTo: true)
        .with(\.isHidden, setTo: true)
    
    private lazy var searchBar = UISearchBar()
        .with(\.delegate, setTo: self)
        .with(\.backgroundColor, setTo: .clear)
        .with(\.backgroundImage, setTo: UIImage())
        .with(\.clipsToBounds, setTo: false)
        .with {
            $0.searchBarStyle = .minimal
            $0.searchTextField.attributedPlaceholder = NSMutableAttributedString {
                AttributedText("UI.Search.Title".localized)
                    .font(.rubik(size: 14, weight: .regular))
                    .foregroundColor(.secondText)
            }
            $0.searchTextField.tintColor = .mainText
            $0.searchTextField.font = .rubik(size: 14, weight: .regular)
        }
    
    init(viewModel: PageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBarItem()
        bindingModel()
    }
    
    private func setupBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapAddButton))
    }
    
    private func bindingModel() {
        viewModel.$state.sink { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                if let firstViewConroller = viewControllers.first {
                    pageViewController.setViewControllers([firstViewConroller], direction: .forward, animated: false)
                }
            case .updatePage(let numberOfPage, let title, let accessLocation):
                navigationController?.navigationBar.isHidden = false
                searchBarContainer.isHidden = true
                if accessLocation { pageControl.setIndicatorImage(UIImage(systemName: "location.fill"), forPage: 0) }
                pageControl.numberOfPages = numberOfPage
                pageControl.currentPage = numberOfPage - 1
                viewControllers = viewModel.viewControllers
                navigationItem.title = title
                pageViewController.setViewControllers([viewControllers[numberOfPage - 1]], direction: .forward, animated: true)
            case .swipePage(let currentIndex):
                navigationItem.title = viewControllers[currentIndex].navigationItem.title
                pageControl.currentPage = currentIndex
            case .showSearch:
                navigationController?.navigationBar.isHidden = true
                searchBarContainer.isHidden = false
                searchBar.searchTextField.becomeFirstResponder()
            case .cancelSearch:
                navigationController?.navigationBar.isHidden = false
                searchBarContainer.isHidden = true
            case .loaded(let title):
                navigationItem.title = title
            }
        }.store(in: &subscriptions)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubviews(pageControl, pageViewController.view, searchBarContainer)
        searchBarContainer.addSubview(searchBar)
        
        searchBarContainer.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.horizontalEdges.equalToSuperview().inset(LayoutConstants.halfOffset)
            $0.height.equalTo(44)
        }
        
        searchBar.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalToSuperview().inset(LayoutConstants.halfOffset)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    @objc private func didTapAddButton() {
        viewModel.didTapAddButton()
    }
    
}

extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard finished,
              let viewController = pageViewController.viewControllers?.first,
              let index = viewControllers.firstIndex(of: viewController) else {
            return
        }
        viewModel.swipe(index: index)
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        viewControllers.firstIndex(of: viewController).flatMap {
            viewControllers[safeIndex: $0 - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        viewControllers.firstIndex(of: viewController).flatMap {
            viewControllers[safeIndex: $0 + 1]
        }
    }
    
}

extension PageViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        showSearchResultView()
        return true
    }
    private func showSearchResultView() {
        let searchViewModel = SearchViewModel(weatherApiService: viewModel.weatherApiService)
        
        let searchController = SearchResultController(
            viewModel: searchViewModel,
            searchBar: searchBar
        )
        searchController.delegate = self
        addChild(searchController)
        
        view.insertSubview(searchController.view, belowSubview: searchBarContainer)
        searchController.view.frame = view.frame

        searchBar.delegate = searchController
        searchBar.searchTextField.delegate = searchController

        searchController.didMove(toParent: self)
    }
}

extension PageViewController: PageViewControllerDelegate {

    func didTapCancel() {
        viewModel.didCancelSearch()
    }
    
    func addLocation(location: UserLocation, title: String) {
        viewModel.addLocation(location: location, title: title)
    }
}
