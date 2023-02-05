//
//  FlickrTests.swift
//  FlickrTests
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import XCTest
import Combine
import UIKit
@testable import Flickr

final class MediaAPTests: XCTestCase {

    func testSearchSuggestion() throws {
        let mediaAPI = MediaAPIMock()
        _ = mediaAPI.fetchSuggestionsPublisher()?.sink(receiveValue: { suggestion in
            assert(suggestion == "value")
        })
        mediaAPI.suggestionPublisher.send("value")
    }

}
