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

    func downloadImagePublisher(_ imageRequest: URLRequest, mediaID: String, type: String) -> AnyPublisher<UIImage, URLError> {
        let publisher = URLSession.shared.dataTaskPublisher(for: imageRequest)
            .receive(on: RunLoop.main)
            .map(\.data)
            .compactMap({
                let image = UIImage(data: $0)
                if let image = image {
                    self.saveImageToDocumentDirectory(image: image, mediaID: mediaID, type: type)
                }
                return image
            })
            .eraseToAnyPublisher()
        let cachingSubject = PassthroughSubject<UIImage, URLError>()
        loadImageFromDocumentDirectory(mediaID: mediaID, type: type, sendTo: cachingSubject)
        return publisher.merge(with: cachingSubject.receive(on: RunLoop.main).eraseToAnyPublisher()).eraseToAnyPublisher()
    }

    //TODO: Implement a better way of saving images.
    func loadImageFromDocumentDirectory(mediaID: String, type: String, sendTo subject: PassthroughSubject<UIImage, URLError>) {
        DispatchQueue.global().async {
            let imageName = "\(mediaID)-\(type)"
            if let imageData = UserDefaults.standard.object(forKey: imageName) as? Data, let image = UIImage(data: imageData) {
                subject.send(image)
            }
        }
    }

    func saveImageToDocumentDirectory(image: UIImage, mediaID: String, type: String) {
        DispatchQueue.global().async {
            if let pngRepresentation = image.pngData() {
                let imageName = "\(mediaID)-\(type)"
                UserDefaults.standard.set(pngRepresentation, forKey: imageName)
            }
        }
    }
}
