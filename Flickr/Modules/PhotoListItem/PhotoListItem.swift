//
//  PhotoListItem.swift
//  Flickr
//
//  Created by Mohamed Hassan on 03/02/2023.
//

import SwiftUI

struct PhotoListItem<MediaHandler: MediaAPIHandlerProtocol>: View {

    @ObservedObject var viewModel: PhotoListItemViewModel<MediaHandler>

    var body: some View {
        HStack(alignment: .center, spacing: 8.0) {
            Image(uiImage: viewModel.thumbnailImage).frame(height: 100.0)
                .padding(4.0)
            Text(viewModel.listModel.title)
        }.onAppear {
            viewModel.fetchMediaInfo()
        }
        .background(
            Rectangle()
                .fill(.clear)
                .cornerRadius(8.0)
                .shadow(
                    color: Color.black.opacity(0.16),
                    radius: 4,
                    x: 0,
                    y: 0
                )
        )
    }
}
