//
//  MediaListMock.swift
//  FlickrTests
//
//  Created by Mohamed Hassan on 05/02/2023.
//

import Foundation
@testable import Flickr

struct MediaListMock: MediaListProtocol {
    var items: [any ListMediaModelProtocol] {
        get {
            return mediaList
        }
    }
    var totalPages: Int
    var page: Int
    var mediaList: [MediaListItemMock]
}
