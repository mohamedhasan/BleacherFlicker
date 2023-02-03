//
//  ListImageModelProtocol.swift
//  Flickr
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import Foundation
import UIKit
import Combine

protocol ListImageModelProtocol: Identifiable {
    var title: String { get }
    var id: String { get }
}
