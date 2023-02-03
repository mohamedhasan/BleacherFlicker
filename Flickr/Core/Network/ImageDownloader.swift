//
//  ImageDownloader.swift
//  Flickr
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import Foundation
import Combine
import UIKit

class ImageDownloader {
    static let shared = ImageDownloader()

    func downloadImagePublisher(_ imageRequest: URLRequest) -> AnyPublisher<UIImage, URLError> {
        return URLSession.shared.dataTaskPublisher(for: imageRequest)
            .receive(on: RunLoop.main)
            .map(\.data)
            .compactMap({ UIImage(data: $0) })
            .eraseToAnyPublisher()
    }
}
