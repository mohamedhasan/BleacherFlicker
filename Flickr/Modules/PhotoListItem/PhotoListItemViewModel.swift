//
//  PhotoListItemViewModel.swift
//  Flickr
//
//  Created by Mohamed Hassan on 03/02/2023.
//

import Foundation
import Combine
import UIKit

class PhotoListItemViewModel<MediaHandler: MediaAPIHandlerProtocol>: ObservableObject {

    let mediaHandler: MediaHandler

    @Published var thumbnailImage: UIImage = UIImage(named: "placeholder") ?? UIImage()
    @Published var listModel: FlickrListPhoto
    private var mediaCancellable: AnyCancellable?
    private var imageCancellable: AnyCancellable?
    private var allSizes: [FlickrPhotoInfo]?

    init(mediaHandler: MediaHandler, listModel: FlickrListPhoto) {
        self.mediaHandler = mediaHandler
        self.listModel = listModel
    }

    func fetchMediaInfo() {
        mediaCancellable = mediaHandler.mediaInfoPublisher(photoId: listModel.id)?.sink(receiveCompletion: { response in
            //TODO: Log errors only without stopping user
            switch response {
            case .failure(let error):
                print(error)
            default:
                return
            }
        }, receiveValue: { [weak self] mediaDetails in
            self?.allSizes = mediaDetails as? [FlickrPhotoInfo]
            guard let thumbnail = self?.allSizes?.filter({ $0.type == .thumbnail }).first else { return }
            self?.imageCancellable = thumbnail.imagePublisher(mediaID: self?.listModel.id ?? "")?.sink(receiveCompletion: { imageError in
                //TODO: Add Reload button for image
            }, receiveValue: {
                self?.thumbnailImage = $0
            })
        })
    }

    func itemDetailsView() -> PhotoDetails<MediaHandler> {
        let viewModel = PhotoDetailsViewModel(
            mediaHandler: mediaHandler,
            photoId: listModel.id)
        viewModel.fetchMediaInfo()
        return PhotoDetails<MediaHandler>(viewModel: viewModel)
    }
}
