//
//  ListMediaModelProtocol.swift
//  Flickr
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import Foundation
import UIKit
import Combine

protocol ListMediaModelProtocol: Identifiable {
    var title: String { get }
    var id: String { get }
}
