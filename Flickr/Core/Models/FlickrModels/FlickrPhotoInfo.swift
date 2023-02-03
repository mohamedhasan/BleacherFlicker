//
//  FlickrPhotoInfo.swift
//  Flickr
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import Foundation
import UIKit
import Combine

enum FlickrLabel: String {
    case Original = "Original"
    case Thumbnail = "Thumbnail"
}

class FlickrPhotoInfo: Codable, MediaInfoModelProtocol {

    let label: String
    let url: String

    init(label: String, url: String) {
        self.label = label
        self.url = url
    }

}

extension FlickrPhotoInfo {
    var imagePublisher: AnyPublisher<UIImage, URLError>? {
        get {
            //TODO: create a custom request with caching
            guard let url = URL(string: url) else { return nil }
            let request = URLRequest(url: url)
            return ImageDownloader.shared.downloadImagePublisher(request)
        }
    }
}
