//
//  ViewController.swift
//  Weather_Swift
//
//  Created by Timur on 23.02.2024.
//

import UIKit

final class MainViewController: UIViewController {
    @Injected var viewModel: MainViewModelProtocol?
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let str = searchController.searchBar.text else { return false }
        return str.isEmpty
    }
    
    private lazy var citiesTable: UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: .plain)
        table.register(CityWeatherTableViewCell.self,
                       forCellReuseIdentifier: CityWeatherTableViewCell.identifier)
        table.isUserInteractionEnabled = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        return table
    }()

    var searchName: String = ""
    var interval = 500
    let timer = TimerGCD(timeInterval: 1)
    var lastTime = DispatchTime.now()
    
    private var cityList = [CityDTO]() {
        didSet {
            DispatchQueue.main.async {
                self.citiesTable.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        //self.cityList.append(CityDTO.getCity(cityName: "Ханты-Мансийск"))
        
        // находим ближайщий город
        findCity()
    }
    
    private func configuration() {
        if #available(iOS 15.0, *) {
            citiesTable.sectionHeaderTopPadding = 0
        }
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = NSLocalizedString("title.main", comment: "Погода")
        let addContract = getBarButtonItem(target: self, action: #selector(findCity))
        self.navigationItem.rightBarButtonItems = [addContract]
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "City name"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        view.addSubview(citiesTable)
        
        // view config
        NSLayoutConstraint.activate([
            citiesTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            citiesTable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            citiesTable.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            citiesTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
        
        // настройка таймера для поиска
        setupTimer()
    }

    @objc func findCity() {
        viewModel?.findCity { [self] item in
            if !cityList.contains(where: { $0 == item })  {
                cityList.append(item)
            }
        }
    }

    func setupTimer() {
        timer.eventHandler = { [weak self] in
            guard let self = self else { return }
            if DispatchTime.now() > self.lastTime {
                print("timer")
                if !self.searchName.isEmpty {
                    Task {
                        await self.viewModel?.searchCities(cityName: self.searchName) { data in
                            self.cityList = data
                        }
                    }
                }
                self.timer.suspend()
            }
        }
        timer.resume()
    }
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let postVC = ForecastViewController()
        navigationController?.pushViewController(postVC, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityWeatherTableViewCell.identifier,
                                                 for: indexPath) as! CityWeatherTableViewCell
        cell.update(cityList[indexPath.row], isCelsius: true, viewModel)
        cell.indexPath = indexPath
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - SEARCH
extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if (!searchBarIsEmpty) {
            searchContent(searchController.searchBar.text!)
        } else {
            timer.suspend()
            return
        }
    }
    
    private func searchContent(_ searchText: String)
    {
        searchName = searchText
        self.lastTime = DispatchTime.now() + DispatchTimeInterval.milliseconds(interval)
        timer.resume()
    }
}


extension MainViewController: CityWeatherTableViewCelDelegate {
    func makeFavorite(indexPath: IndexPath) {
        let cityId = cityList[indexPath.row].id
        var stateFavorite = viewModel?.isFavorites(cityId) ?? false
        stateFavorite ? viewModel?.removeFavorite(cityId) : viewModel?.addFavorite(cityId)
        citiesTable.reloadRows(at: [indexPath], with: .none)
    }
}
