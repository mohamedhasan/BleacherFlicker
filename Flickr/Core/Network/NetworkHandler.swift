//
//  NetworkHandler.swift
//  Flickr
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import Foundation
import Combine
import UIKit

class NetworkHandler {
    func performRequest<T: Codable>(_ request: URLRequest, decodeTo: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
