//
//  APIHandlerProtocol.swift
//  Flickr
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import Foundation
import Combine

protocol MediaAPIHandlerProtocol {
    func searchMediaPublisher(query: String, pageSize: Int) -> AnyPublisher<[any ListMediaModelProtocol]?, Error>?
    func searchMediaPublisher(query: String, pageSize: Int, page: Int) -> AnyPublisher<FlickrListResponseModel?, Error>?
    func mediaInfoPublisher(photoId: String) -> AnyPublisher<[any MediaInfoModelProtocol]?, Error>?
    func fetchSuggestionsPublisher() -> AnyPublisher<String, Never>?
}
