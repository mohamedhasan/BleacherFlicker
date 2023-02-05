//
//  MediaAPIMock.swift
//  FlickrTests
//
//  Created by Mohamed Hassan on 05/02/2023.
//

import Foundation
import Combine
@testable import Flickr

struct MediaAPIMock: MediaAPIHandlerProtocol {

    let searchMediaPublisher = PassthroughSubject<[any ListMediaModelProtocol]?, Error>()
    let searchMediaPaginationPublisher = PassthroughSubject<FlickrListResponseModel?, Error>()
    let mediaInfoPublisher = PassthroughSubject<[any MediaInfoModelProtocol]?, Error>()
    let suggestionPublisher = PassthroughSubject<String, Never>()
    
    func searchMediaPublisher(query: String, pageSize: Int) -> AnyPublisher<[any ListMediaModelProtocol]?, Error>? {
        searchMediaPublisher.eraseToAnyPublisher()
    }
    
    func searchMediaPublisher(query: String, pageSize: Int, page: Int) -> AnyPublisher<FlickrListResponseModel?, Error>? {
        searchMediaPaginationPublisher.eraseToAnyPublisher()
    }
    
    func mediaInfoPublisher(photoId: String) -> AnyPublisher<[any MediaInfoModelProtocol]?, Error>? {
        mediaInfoPublisher.eraseToAnyPublisher()
    }
    
    
    func fetchSuggestionsPublisher() -> AnyPublisher<String, Never>? {
        suggestionPublisher.eraseToAnyPublisher()
    }
}

