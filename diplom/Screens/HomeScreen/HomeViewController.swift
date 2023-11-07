//
//  HomeViewController.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 08.10.2023.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModel

    
    private lazy var cityLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 200, y: 200, width: 200, height: 50))
        
        
        return label
    }()
    private lazy var longitude: UILabel = {
        let label = UILabel(frame: CGRect(x: 200, y: 300, width: 200, height: 50))
        
        
        return label
    }()
    private lazy var latitude: UILabel = {
        let label = UILabel(frame: CGRect(x: 200, y: 300, width: 200, height: 50))
        
        
        return label
    }()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        viewModel.getLocation()
        bindingModel()
    }
    
    private func bindingModel() {
        viewModel
            .$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .loading:
                    print("loooooooading")
                case .loaded(let location):
                    self?.latitude.text = String(location.latitude)
                    self?.longitude.text = String(location.longitude)
                case .error:
                    print("errororororooror")
                }
            }
            .store(in: &subscriptions)

    }
}
