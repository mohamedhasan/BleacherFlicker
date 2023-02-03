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
                VStack(alignment: .leading) {
                    HStack {
                        TextField(LocalizedStringKey("Type to search..."), text: $searchText)
                            .padding(8)
                            .cornerRadius(4)
                            .background(.blue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .submitLabel(.search)
                    }
                    List {
                        ForEach(viewModel.mediaList) { media in
                            let infoViewModel = viewModel.mediaInfoViewModel(media)
                            PhotoListItem<MediaHandler>(viewModel: infoViewModel)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
                .onSubmit
                { viewModel.searchMedia(query: searchText) }
                .navigationTitle(LocalizedStringKey("Photos Search"))
                .navigationBarTitleDisplayMode(.inline)
            }
}
