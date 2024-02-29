//
//  CityWeatherTableViewCell.swift
//  Weather_Swift
//
//  Created by Timur on 22.02.2024.
//

import UIKit
import SnapKit

protocol CityWeatherTableViewCelDelegate: AnyObject {
    func makeFavorite(indexPath: IndexPath)
}

final class CityWeatherTableViewCell: UITableViewCell {
    public var indexPath: IndexPath?
    @Injected var favoriteService: FavoritesServiceProtocol?
    weak var delegate: CityWeatherTableViewCelDelegate?
    
    private let stackViewHorizontal: UIStackView = {
        let edgeInset: CGFloat = 5
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 5
        sv.layoutMargins = UIEdgeInsets(top: 0, left: edgeInset, bottom: edgeInset, right: edgeInset)
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
    }()
    
    private let stackViewVerticalCityName: UIStackView = {
        let edgeInset: CGFloat = 5
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .leading
        sv.layoutMargins = UIEdgeInsets(top: edgeInset, left: 0, bottom: edgeInset, right: edgeInset)
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
    }()
    
    private let stackViewVerticalIcon: UIStackView = {
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
    
    private let stackViewVerticalTemp: UIStackView = {
        let edgeInset: CGFloat = 5
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .trailing
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
    
    private lazy var countryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "-"
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "-"
        return label
    }()
    
    private lazy var dateTimeWeatherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "-"
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "-"
        return label
    }()
    
    private lazy var imageViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: AppImage.cloud.rawValue)
        return imageView
    }()
    
    private lazy var spacer: UIView = {
        let spacer = UIView()
        let spacerWidthConstraint = spacer.widthAnchor.constraint(equalToConstant: .greatestFiniteMagnitude)
        spacerWidthConstraint.priority = .defaultLow
        spacerWidthConstraint.isActive = true
        return spacer
    }()
    
    private lazy var favoriteImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: AppImage.notFavorite.rawValue)
        img.tintColor = .red
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        img.isUserInteractionEnabled = true
        return img
    }()
        
    func update(_ model: CityDTO, isCelsius: Bool = true, _ viewModel: MainViewModelProtocol?) {
        cityNameLabel.text = model.cityName
        countryNameLabel.text = model.countryName
        
        let isFavorite = favoriteService?.isFavorite(model.id) ?? false
        favoriteImageView.image = UIImage(
                systemName: isFavorite ? AppImage.favorite.rawValue : AppImage.notFavorite.rawValue
        )
        
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }            
            viewModel?.getCurrentWeatherByCityName(cityName: model.cityName) { [weak self] currentData in
                guard let self = self else { return }
                tempLabel.text = "\(currentData.current.tempC)\(isCelsius ? "°C": "°F")"
                dateTimeWeatherLabel.text = getTimeFromDate(unixtime: currentData.location.localtimeEpoch)
                loadImage(iconUrl: currentData.current.condition.icon)
                conditionLabel.text = currentData.current.condition.text
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isUserInteractionEnabled = true
        configure()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {

        let inset: CGFloat = 16
        
        [stackViewHorizontal].forEach {
            self.contentView.addSubview($0)
        }
                
        [countryNameLabel, cityNameLabel, dateTimeWeatherLabel, spacer, conditionLabel].forEach {
            stackViewVerticalCityName.addArrangedSubview($0)
        }
        
        [imageViewCell].forEach {
            stackViewVerticalIcon.addArrangedSubview($0)
        }
        
        [tempLabel, favoriteImageView].forEach {
            stackViewVerticalTemp.addArrangedSubview($0)
        }
        
        [stackViewVerticalCityName, stackViewVerticalIcon, stackViewVerticalTemp].forEach {
            stackViewHorizontal.addArrangedSubview($0)
        }
        
        
        NSLayoutConstraint.activate([
            self.stackViewHorizontal.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.stackViewHorizontal.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
            self.stackViewHorizontal.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.stackViewHorizontal.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            self.favoriteImageView.widthAnchor.constraint(equalToConstant: 35),
            self.favoriteImageView.heightAnchor.constraint(equalToConstant: 35),
        ])
        
        imageViewCell.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        })
        
        countryNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(inset)
            make.leading.equalToSuperview().inset(inset)
        }
        
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalTo(countryNameLabel.snp.bottom)
            make.leading.equalToSuperview().inset(inset)
        }
                
        spacer.snp.makeConstraints { make in
            make.height.equalTo(cityNameLabel.snp.height)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(inset)
            make.width.lessThanOrEqualTo(150)
        }
        
        favoriteImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(inset)
        }

       dateTimeWeatherLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom)
            make.leading.equalToSuperview().inset(inset)
        }
        
        conditionLabel.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(inset)
            make.bottom.equalToSuperview()
        })
        
    }
}

extension CityWeatherTableViewCell {
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(favoriteAction))
        tapGesture.numberOfTapsRequired = 1
        self.favoriteImageView.isUserInteractionEnabled = true
        self.favoriteImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func favoriteAction() {
        delegate?.makeFavorite(indexPath: self.indexPath!)
    }
    
    private func loadImage(iconUrl: String) {
        
        guard let url = URL(string: "https:" + iconUrl) else { return }
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async { [self] in
                imageViewCell.image = UIImage(data: imageData)
            }
        }
    }
}
