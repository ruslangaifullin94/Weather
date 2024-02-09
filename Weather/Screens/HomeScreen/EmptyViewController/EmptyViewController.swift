//
//  EmptyViewController.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 15.01.2024.
//

import UIKit

final class EmptyViewController: NiblessViewController {
    
    
    private var label = UILabel()
        .text2
        .with(\.text, setTo: "Нажмите кнопку + чтобы добавить город")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
