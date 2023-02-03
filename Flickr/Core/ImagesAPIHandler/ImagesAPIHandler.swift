//
//  ImagesAPIHandler.swift
//  Flickr
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import Foundation
import Combine

class ImagesAPIHandler: APIListHandlerProtocol {
    let endPoint = "https://www.flickr.com/services/rest/"

    func searchImagesPublisher(query: String) -> AnyPublisher<[FlickrListImage], Error>? {
        let networkHandler = NetworkHandler()
        guard let request = searchImagesRequest(query: query) else { return nil }
        return networkHandler.performRequest(request, decodeTo: [FlickrListImage].self)
    }

    func imageInfoPublisher(photoId: String) -> AnyPublisher<[FlickrListImage], Error>? {
        let networkHandler = NetworkHandler()
        guard let request = imageInfoRequest(photoId: photoId) else { return nil }
        return networkHandler.performRequest(request, decodeTo: [FlickrListImage].self)
    }
}
