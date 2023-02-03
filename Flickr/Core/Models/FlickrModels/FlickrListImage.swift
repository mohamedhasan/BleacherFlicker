//
//  FlickrListImage.swift
//  Flickr
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import Foundation
import UIKit
import Combine

struct FlickrListImage: Codable, ListImageModelProtocol {

    let id: String
    let title: String
    
    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
}
