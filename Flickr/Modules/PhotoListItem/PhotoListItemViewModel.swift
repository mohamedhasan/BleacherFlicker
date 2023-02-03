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

    @Published var thumbnailImage: UIImage = UIImage(named: "placholder") ?? UIImage()
    @Published var listModel: FlickrListPhoto
    private var mediaCancellable: AnyCancellable?
    private var imageCancellable: AnyCancellable?
    private var allSizes: [FlickrPhotoInfo]?

    init(mediaHandler: MediaHandler, listModel: FlickrListPhoto) {
        self.mediaHandler = mediaHandler
        self.listModel = listModel
    }

    func fetchMediaInfo() {
        mediaCancellable = mediaHandler.mediaInfoPublisher(photoId: listModel.id)?.sink(receiveCompletion: { error in
            //TODO: Handle errors
        }, receiveValue: { mediaDetails in
            self.allSizes = mediaDetails as? [FlickrPhotoInfo]
            guard let thumbnail = self.allSizes?.filter({ $0.type == .thumbnail }).first else { return }
            self.imageCancellable = thumbnail.imagePublisher?.sink(receiveCompletion: { imageError in
                //TODO: Handle errors
                print(imageError)
            }, receiveValue: {
                self.thumbnailImage = $0
            })
        })
    }
}
