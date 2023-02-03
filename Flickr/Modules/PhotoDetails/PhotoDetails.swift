//
//  PhotoDetails.swift
//  Flickr
//
//  Created by Mohamed Hassan on 03/02/2023.
//

import SwiftUI

struct PhotoDetails<MediaHandler: MediaAPIHandlerProtocol>: View {
        
    @ObservedObject var viewModel: PhotoDetailsViewModel<MediaHandler>
    
    var body: some View {
        Image(uiImage: viewModel.fullImage)
            .resizable()
            .padding(0)
    }
}
