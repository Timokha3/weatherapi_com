//
//  BarButtonItemHelper.swift
//  Weather_Swift
//
//  Created by Timur on 23.02.2024.
//

import Foundation
import UIKit

func getBarButtonItem(target: AnyObject, action: Selector) -> UIBarButtonItem {
    
    let barBtn = UIBarButtonItem(image: UIImage(systemName: AppImage.location.rawValue),
                                 style: .plain,
                                 target: target,
                                 action: action)
    return barBtn
}
