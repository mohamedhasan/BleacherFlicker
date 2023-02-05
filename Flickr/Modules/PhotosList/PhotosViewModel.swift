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
    @Published var suggestions: [String] = []

    let pageSize: Int
    private var cancellable: AnyCancellable?
    private var suggestionsCancellable: AnyCancellable?

    init(mediaHandler: MediaHandler, pageSize: Int) {
        self.mediaHandler = mediaHandler
        self.pageSize = pageSize
        self.fetchSuggestions()
    }

    func fetchSuggestions() {
        suggestions = []
        suggestionsCancellable = mediaHandler.fetchSuggestionsPublisher()?.reduce(suggestions, { suggestions, value in
            return suggestions + [value]
        }).sink(receiveValue: { suggestions in
            self.suggestions = suggestions
        })
    }

    func searchMedia(query: String) {
        cancellable = mediaHandler.searchMediaPublisher(query: query, pageSize: pageSize)?.sink(receiveCompletion: { error in
            //TODO: Handle errors
        }, receiveValue: { photos in
            self.mediaList = photos as? [FlickrListPhoto] ?? []
        })
        fetchSuggestions()
    }

    func itemListViewModel(_ photo: FlickrListPhoto) -> PhotoListItemViewModel<MediaHandler> {
        let viewModel = PhotoListItemViewModel(
            mediaHandler: mediaHandler,
            listModel: photo)
        return viewModel
    }
}
