//
//  ViewModelTests.swift
//  FlickrTests
//
//  Created by Mohamed Hassan on 05/02/2023.
//

import XCTest
import Combine
import UIKit
@testable import Flickr

final class PhotosViewModelTests: XCTestCase {

    func testSkipSearchWhenQueryEmpty() throws {
        let mediaAPI = MediaAPIMock()
        let viewModel = PhotosViewModel(mediaHandler: mediaAPI, pageSize: 10)
        viewModel.searchMedia(query: "")
        _ = viewModel.$isSearching.sink {
            assert(!$0)
        }
    }

    func testSearchWhenQueryProvided() throws {
        let mediaAPI = MediaAPIMock()
        let viewModel = PhotosViewModel(mediaHandler: mediaAPI, pageSize: 10)
        viewModel.searchMedia(query: "Pizza")
        _ = viewModel.$isSearching.sink {
            assert($0)
        }
    }

    func testLoadMoreIncrementsPage() {
        let mediaAPI = MediaAPIMock()
        let viewModel = PhotosViewModel(mediaHandler: mediaAPI, pageSize: 10)
        viewModel.searchMedia(query: "Pizza")
        viewModel.loadPage(pageNumber: viewModel.page + 1)
        viewModel.loadPage(pageNumber: viewModel.page + 1)
        assert(viewModel.page == 2)
    }
    
}

