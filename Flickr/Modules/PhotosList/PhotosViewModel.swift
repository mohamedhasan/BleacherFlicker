//
//  PhotosViewModel.swift
//  Flickr
//
//  Created by Mohamed Hassan on 03/02/2023.
//

import Foundation
import Combine

class PhotosViewModel<MediaHandler: MediaAPIHandlerProtocol>: ObservableObject {
    let mediaHandler: MediaHandler

    @Published var mediaList: [FlickrListPhoto] = []

    let pageSize: Int
    private var cancellable: AnyCancellable?

    init(mediaHandler: MediaHandler, pageSize: Int) {
        self.mediaHandler = mediaHandler
        self.pageSize = pageSize
    }

    func searchMedia(query: String) {
        cancellable = mediaHandler.searchMediaPublisher(query: query, pageSize: pageSize)?.sink(receiveCompletion: { error in
            //TODO: Handle errors
        }, receiveValue: { photos in
            self.mediaList = photos as? [FlickrListPhoto] ?? []
        })
    }

    func mediaInfoViewModel(_ photo: FlickrListPhoto) -> PhotoListItemViewModel<MediaHandler> {
        let viewModel = PhotoListItemViewModel(
            mediaHandler: mediaHandler,
            listModel: photo)
        viewModel.fetchMediaInfo()
        return viewModel
    }
}
