//
//  FlickrApp.swift
//  Flickr
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import SwiftUI

@main
struct FlickrApp: App {
    init() {
        AppDesign.configureDesign()
    }

    var body: some Scene {
        WindowGroup {
            let viewModel = PhotosViewModel(mediaHandler: FlickrPhotosAPIHandler(), pageSize: 25)
            PhotosView(viewModel: viewModel)
        }
    }
}
