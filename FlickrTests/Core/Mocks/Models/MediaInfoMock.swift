//
//  MediaInfoMock.swift
//  FlickrTests
//
//  Created by Mohamed Hassan on 05/02/2023.
//

import Foundation
import Combine
import UIKit
@testable import Flickr

class MediaInfoMock: Codable, MediaInfoModelProtocol {

    let label: String
    let source: String
    var type: FlickrLabel {
        get {
            return FlickrLabel(rawValue: label) ?? .unknown
        }
    }
    var url: String {
        get {
            return source
        }
    }
    init(label: String, source: String) {
        self.label = label
        self.source = source
    }

}

extension MediaInfoMock {
    func imagePublisher(mediaID: String) -> AnyPublisher<UIImage, URLError>? {
        let subject = PassthroughSubject<UIImage, URLError>()
        return subject.eraseToAnyPublisher()
    }
}
