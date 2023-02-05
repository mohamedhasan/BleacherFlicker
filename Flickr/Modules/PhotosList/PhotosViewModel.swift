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
    //TODO: APIs might differ in first page num (0 or 1).
    var page: Int = 1
    private var totalPages: Int? = 1
    private var currentQuery = ""

    var hasMoreRows: Bool {
        get {
            guard let totalPages = totalPages, !mediaList.isEmpty else { return false }
            return page < totalPages
        }
    }
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
        guard !query.isEmpty else { return }
        currentQuery = query
        page = 0
        cancellable = mediaHandler.searchMediaPublisher(query: query, pageSize: pageSize, page: page)?.sink(receiveCompletion: { error in
            //TODO: Handle errors
        }, receiveValue: { [weak self] response in
            self?.mediaList = response?.items as? [FlickrListPhoto] ?? []
            self?.page = response?.page ?? 1
            self?.totalPages = response?.totalPages
        })
        fetchSuggestions()
    }

    func loadPage(pageNumber: Int) {
        guard !currentQuery.isEmpty else { return }
        page = pageNumber
        cancellable = mediaHandler.searchMediaPublisher(query: currentQuery, pageSize: pageSize, page: page)?.sink(receiveCompletion: { error in
            //TODO: Handle errors
        }, receiveValue: { [weak self] response in
            self?.mediaList.append(contentsOf: response?.items as? [FlickrListPhoto] ?? [])
            self?.page = response?.page ?? 1
            self?.totalPages = response?.totalPages
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
