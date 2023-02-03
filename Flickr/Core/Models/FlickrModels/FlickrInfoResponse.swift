//
//  FlickrInfoResponse.swift
//  Flickr
//
//  Created by Mohamed Hassan on 03/02/2023.
//

import Foundation

struct FlickrInfoResponse: Codable {
    let sizes: FlickrListResponseSizeModel
}

struct FlickrListResponseSizeModel: Codable {
    let size: [FlickrPhotoInfo]
}
