//
//  APIHandlerProtocol.swift
//  Flickr
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import Foundation
import Combine

protocol APIListHandlerProtocol {
    func searchImagesPublisher(query: String) -> AnyPublisher<[FlickrListImage], Error>?
    func imageInfoPublisher(photoId: String) -> AnyPublisher<[FlickrListImage], Error>?
}
