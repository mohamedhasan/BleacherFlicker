//
//  MediaListItemMock.swift
//  FlickrTests
//
//  Created by Mohamed Hassan on 05/02/2023.
//

import Foundation
@testable import Flickr

struct MediaListItemMock: Codable, ListMediaModelProtocol {
    let title: String
    let id: String
}
