//
//  ViewController.swift
//  WeatherApp
//
//  Created by Raziel on 04.03.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let someView: UIView = UIView()
        someView.backgroundColor = .systemYellow
        self.view.addSubview(someView)
        someView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            someView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            someView.topAnchor.constraint(equalTo: self.view.topAnchor),
            someView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            someView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
