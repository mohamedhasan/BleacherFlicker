//
//  AppDesign.swift
//  Flickr
//
//  Created by Mohamed Hassan on 03/02/2023.
//

import Foundation
import UIKit

class AppDesign {
    static func configureDesign() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = appearance
    }
}
