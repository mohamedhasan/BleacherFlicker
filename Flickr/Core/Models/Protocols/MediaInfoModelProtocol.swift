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
    var imagePublisher: AnyPublisher<UIImage, URLError>? { get }
}
