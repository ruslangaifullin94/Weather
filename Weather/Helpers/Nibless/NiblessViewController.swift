//
//  NiblessViewController.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 27.12.2023.
//

import UIKit

class NiblessViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        navigationItem.backButtonTitle = "UI.Universal.Title.back".localized
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
