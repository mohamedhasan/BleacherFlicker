//
//  FlickrListResponse.swift
//  Flickr
//
//  Created by Mohamed Hassan on 03/02/2023.
//

import Foundation

struct FlickrListResponse: Codable {
    let photos: FlickrListResponseModel
}

struct FlickrListResponseModel: Codable, MediaListProtocol {
    var totalPages: Int {
        get {
            return pages
        }
    }

    var items: [any ListMediaModelProtocol] {
        get {
            return photo
        }
    }

    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [FlickrListPhoto]
}
