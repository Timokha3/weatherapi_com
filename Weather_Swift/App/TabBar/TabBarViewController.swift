//
//  TabBarViewController.swift
//  Weather_Swift
//
//  Created by Timur on 27.02.2024.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create Tab one
        let mainVC = MainViewController()
        let tabOne = UINavigationController(rootViewController: mainVC)
        let tabOneBarItem = UITabBarItem(
                    title: NSLocalizedString("title.favorites", comment: "Избранное"),
                    image: UIImage(systemName: "location.circle"),
                    selectedImage: UIImage(systemName: "location.circle.fill"))
        
        tabOne.tabBarItem = tabOneBarItem
        
        
        // Create Tab two
        let favVC = FavoritesViewController()
        let tabTwo = UINavigationController(rootViewController: favVC)
        let tabTwoBarItem2 = UITabBarItem(
                    title: NSLocalizedString("title.favorites", comment: "Избранное"),
                    image: UIImage(systemName: "heart.circle"),
                    selectedImage: UIImage(systemName: "heart.circle.fill"))
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
        
        self.viewControllers = [tabOne, tabTwo]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected")
    }
}
