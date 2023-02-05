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
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(viewModel.mediaList) { media in
                        let infoViewModel = viewModel.itemListViewModel(media)
                        PhotoListItem<MediaHandler>(viewModel: infoViewModel).equatable()
                    }
                    if viewModel.hasMoreRows {
                        HStack {
                            Text("Loading more results...")
                                .onAppear {
                                    viewModel.page += 1
                                    viewModel.loadPage(pageNumber: viewModel.page + 1)
                                }
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search for photos ...", suggestions: {
                ForEach(
                  viewModel.suggestions,
                    id: \.self
                ) { suggestion in
                  Text(suggestion)
                    .searchCompletion(suggestion)
                }
            })
            .navigationTitle(LocalizedStringKey("Photos Search"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .onSubmit(of: .search, {
            viewModel.searchMedia(query: searchText)
        })
        .overlay {
            if viewModel.isSearching {
                ProgressView()
            }
            if viewModel.mediaList.isEmpty && !viewModel.isSearching {
                Text("Please enter a valid search query")
                    .font(.callout)
                    .fontWeight(.heavy)
            }
        }
    }
}
