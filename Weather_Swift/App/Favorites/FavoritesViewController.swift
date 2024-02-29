//
//  FavoriteViewController.swift
//  Weather_Swift
//
//  Created by Timur on 27.02.2024.
//

import UIKit

class FavoritesViewController: UIViewController {
    @Injected var viewModel: FavoritesViewModelProtocol?

    private lazy var citiesTable: UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: .plain)
        table.register(FavoriteTableCellView.self,
                       forCellReuseIdentifier: FavoriteTableCellView.identifier)
        table.isUserInteractionEnabled = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        return table
    }()

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
        viewConfig()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cityList = viewModel?.favorites ?? []
    }
    
    private func configuration() {
        if #available(iOS 15.0, *) {
            citiesTable.sectionHeaderTopPadding = 0
        }
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = NSLocalizedString("title.favorites", comment: "Избранное")
        
        definesPresentationContext = true
        view.addSubview(citiesTable)
    }
    
    private func viewConfig(){
        NSLayoutConstraint.activate([
            citiesTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            citiesTable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            citiesTable.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            citiesTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
}

//MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableCellView.identifier,
                                                 for: indexPath) as! FavoriteTableCellView
        cell.update(cityList[indexPath.row], isCelsius: true, viewModel)
        cell.delegate = self
        cell.indexPath = indexPath
        cell.selectionStyle = .none
        return cell
    }
}

extension FavoritesViewController: FavoriteTableCellViewDelegate {
    func makeFavorite(indexPath: IndexPath) {
        let cityId = cityList[indexPath.row].id
        var stateFavorite = viewModel?.isFavorites(cityId) ?? false
        if stateFavorite {
            viewModel?.removeFavorite(cityId)
            cityList.remove(at: indexPath.row)
        } else {
            viewModel?.addFavorite(cityId)
        }
    }
}
