//
//  ImagesAPIHandler.swift
//  Flickr
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import Foundation
import Combine

class FlickrPhotosAPIHandler: MediaAPIHandlerProtocol {
    let endPoint = "https://www.flickr.com/services/rest/"

    func searchMediaPublisher(query: String) -> AnyPublisher<[any ListMediaModelProtocol]?, Error>? {
        let networkHandler = NetworkHandler()
        guard let request = searchPhotosRequest(query: query) else { return nil }
        return networkHandler.performRequest(request, decodeTo: FlickrListResponse.self)
            .map(\.photo)
            .map { return $0 as [any ListMediaModelProtocol] }
            .eraseToAnyPublisher()
    }

    func mediaInfoPublisher(photoId: String) -> AnyPublisher<[any MediaInfoModelProtocol]?, Error>? {
        let networkHandler = NetworkHandler()
        guard let request = photoInfoRequest(photoId: photoId) else { return nil }
        return networkHandler.performRequest(request, decodeTo: FlickrInfoResponse.self)
            .map(\.sizes.size)
            .map { return $0 as [any MediaInfoModelProtocol] }
            .eraseToAnyPublisher()
    }
}
