//
//  FlickrRequestsTests.swift
//  FlickrTests
//
//  Created by Mohamed Hassan on 05/02/2023.
//

import XCTest
import Combine
import UIKit
@testable import Flickr

final class FlickrRequestsTests: XCTestCase {

    func testPhotoSearchRequest() throws {
        let flickrAPI = FlickrPhotosAPIHandler()
        let request = flickrAPI.searchPhotosRequest(query: "Pizza", pageSize: 25, page: 1)
        assert(request?.httpMethod == "GET")
        guard let queryStr = request?.url?.absoluteString else {
            assert(false)
            return
        }
        assert(queryStr.localizedStandardContains("method=flickr.photos.search"))
        assert(queryStr.localizedStandardContains("page=1"))
        assert(queryStr.localizedStandardContains("per_page=25"))
    }

    func testPhotoInfoRequest() throws {
        let flickrAPI = FlickrPhotosAPIHandler()
        let request = flickrAPI.photoInfoRequest(photoId: "1")
        assert(request?.httpMethod == "GET")
        guard let queryStr = request?.url?.absoluteString else {
            assert(false)
            return
        }
        assert(queryStr.localizedStandardContains("photo_id=1"))
        assert(queryStr.localizedStandardContains("method=flickr.photos.getSizes"))
    }
    
}
