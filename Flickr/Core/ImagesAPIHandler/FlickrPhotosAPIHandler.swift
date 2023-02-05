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

    func searchMediaPublisher(query: String, pageSize: Int) -> AnyPublisher<[any ListMediaModelProtocol]?, Error>? {
        SuggestionsHandler.shared.saveSearchQuery(query)
        let networkHandler = NetworkHandler()
        guard let request = searchPhotosRequest(query: query, pageSize: pageSize) else { return nil }
        return networkHandler.performRequest(request, decodeTo: FlickrListResponse.self)
            .map(\.photos.photo)
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

    func fetchSuggestionsPublisher() -> AnyPublisher<String, Never>? {
        return SuggestionsHandler.shared.getSavedQueries()
    }
}
