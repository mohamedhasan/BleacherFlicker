//
//  PhotoListItemViewModel.swift
//  Flickr
//
//  Created by Mohamed Hassan on 03/02/2023.
//

import Foundation
import Combine
import UIKit

class PhotoDetailsViewModel<MediaHandler: MediaAPIHandlerProtocol>: ObservableObject {

    let mediaHandler: MediaHandler

    @Published var fullImage: UIImage = UIImage(named: "placeholder") ?? UIImage()

    private let photoId: String
    private var mediaCancellable: AnyCancellable?
    private var imageCancellable: AnyCancellable?
    private var allSizes: [FlickrPhotoInfo]?

    init(mediaHandler: MediaHandler, photoId: String) {
        self.mediaHandler = mediaHandler
        self.photoId = photoId
    }

    func fetchMediaInfo() {
        mediaCancellable = mediaHandler.mediaInfoPublisher(photoId: photoId)?.sink(receiveCompletion: { error in
            //TODO: Log errors only without stopping user
        }, receiveValue: { [weak self] mediaDetails in
            self?.allSizes = mediaDetails as? [FlickrPhotoInfo]
            guard let thumbnail = self?.allSizes?.filter({ $0.type == .original }).first else { return }
            self?.imageCancellable = thumbnail.imagePublisher(mediaID: self?.photoId ?? "")?.sink(receiveCompletion: { imageError in
                //TODO: Add Reload button for image
            }, receiveValue: {
                self?.fullImage = $0
            })
        })
    }
}
