//
//  MediaInfoModelProtocol.swift
//  Flickr
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import Foundation
import UIKit
import Combine

protocol MediaInfoModelProtocol: Identifiable {
    var url: String { get }
    func imagePublisher(mediaID: String) -> AnyPublisher<UIImage, URLError>?
}
