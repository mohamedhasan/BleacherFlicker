//
//  MediaListProtocol.swift
//  Flickr
//
//  Created by Mohamed Hassan on 05/02/2023.
//

import Foundation
import UIKit
import Combine

protocol MediaListProtocol {
    var totalPages: Int { get }
    var page: Int { get }
    var items: [any ListMediaModelProtocol]  { get }
}
