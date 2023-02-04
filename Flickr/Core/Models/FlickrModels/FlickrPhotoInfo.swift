//
//  FlickrPhotoInfo.swift
//  Flickr
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import Foundation
import UIKit
import Combine

enum FlickrLabel: String, Codable {
    case original = "Original"
    case thumbnail = "Thumbnail"
    case unknown = "Unknown"
}

class FlickrPhotoInfo: Codable, MediaInfoModelProtocol {

    let label: String
    let source: String
    var type: FlickrLabel {
        get {
            return FlickrLabel(rawValue: label) ?? .unknown
        }
    }
    var url: String {
        get {
            return source
        }
    }
    init(label: String, source: String) {
        self.label = label
        self.source = source
    }

}

extension FlickrPhotoInfo {
    func imagePublisher(mediaID: String) -> AnyPublisher<UIImage, URLError>? {
        guard let imageURL = URL(string: url) else { return nil }
        var request = URLRequest(url: imageURL)
        request.cachePolicy = .returnCacheDataElseLoad
        return ImageDownloader.shared.downloadImagePublisher(request, mediaID: mediaID, type: label)
    }
}
