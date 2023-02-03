//
//  FlickrListResponse.swift
//  Flickr
//
//  Created by Mohamed Hassan on 03/02/2023.
//

import Foundation

struct FlickrListResponse: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [FlickrListPhoto]
}
