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
    func mediaInfoPublisher(photoId: String) -> AnyPublisher<[any MediaInfoModelProtocol]?, Error>?
}
