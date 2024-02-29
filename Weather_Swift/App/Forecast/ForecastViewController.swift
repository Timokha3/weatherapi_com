//
//  ForecastViewController.swift
//  Weather_Swift
//
//  Created by Timur on 28.02.2024.
//

import UIKit

class ForecastViewController: UIViewController {
    @Injected var viewModel: ForecastViewModelProtocol?
    
    private let stackViewVertical: UIStackView = {
        let edgeInset: CGFloat = 5
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 5
        sv.layoutMargins = UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
    }()
    
    private let stackViewVerticalCityName: UIStackView = {
        let edgeInset: CGFloat = 5
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .center
        sv.layoutMargins = UIEdgeInsets(top: edgeInset, left: 0, bottom: edgeInset, right: edgeInset)
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
    }()
    
    private let stackViewForecast: UIStackView = {
        let edgeInset: CGFloat = 5
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .bottom
        sv.layoutMargins = UIEdgeInsets(top: edgeInset, left: 0, bottom: edgeInset, right: edgeInset)
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
    }()
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "-"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("title.forecast", comment: "Прогноз")
        self.view.backgroundColor = .systemBackground
        viewConfiguration()
    }
    
    func update(_ model: CityDTO, isCelsius: Bool = true) {
        cityNameLabel.text = model.cityName

        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
     
                //todo
        }
    }
    
    private func viewConfiguration() {
        
        [stackViewVertical].forEach {
            self.view.addSubview($0)
        }
        
        [cityNameLabel].forEach {
            stackViewVerticalCityName.addArrangedSubview($0)
        }
        
        [stackViewVerticalCityName, stackViewForecast].forEach {
            stackViewVertical.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackViewVertical.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackViewVertical.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            stackViewVertical.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            stackViewVertical.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }        
}
