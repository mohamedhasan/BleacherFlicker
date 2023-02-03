//
//  ImageInfoModelProtocol.swift
//  Flickr
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import Foundation
import UIKit
import Combine

protocol ImageInfoModelProtocol: Identifiable {
    var label: String { get }
    var url: String { get }
    var imagePublisher: AnyPublisher<UIImage, URLError>? { get }
}
