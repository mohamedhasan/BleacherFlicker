//
//  PhotosView.swift
//  Flickr
//
//  Created by Mohamed Hassan on 03/02/2023.
//

import Foundation
import SwiftUI
import Combine

struct PhotosView<MediaHandler: MediaAPIHandlerProtocol>: View {

    @ObservedObject var viewModel: PhotosViewModel<MediaHandler>

    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                List {
                    Section() {
                        ForEach(viewModel.mediaList) { media in
                            let infoViewModel = viewModel.mediaInfoViewModel(media)
                            PhotoListItem<MediaHandler>(viewModel: infoViewModel)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.searchMedia(query: "Apple")
        }
    }
}
