//
//  PhotoListItem.swift
//  Flickr
//
//  Created by Mohamed Hassan on 03/02/2023.
//

import SwiftUI

struct PhotoListItem<MediaHandler: MediaAPIHandlerProtocol>: View, Equatable {
    
    @ObservedObject var viewModel: PhotoListItemViewModel<MediaHandler>

    static func == (lhs: PhotoListItem<MediaHandler>, rhs: PhotoListItem<MediaHandler>) -> Bool {
        return lhs.viewModel.listModel.id == rhs.viewModel.listModel.id
    }

    var body: some View {
        HStack(alignment: .center, spacing: 8.0) {
            Image(uiImage: viewModel.thumbnailImage)
                .resizable()
                .frame(width: 80.0, height: 80.0)
                .padding(EdgeInsets(top: 4.0, leading: 4.0, bottom: 4.0, trailing: 10.0))
            Text(viewModel.listModel.title)
            NavigationLink(destination: viewModel.itemDetailsView()) {
                Text("")
            }
        }
        .onAppear {
            viewModel.fetchMediaInfo()
        }
        .frame(height: 100.0)
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
