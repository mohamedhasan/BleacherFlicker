//
//  ImageDownloader.swift
//  Flickr
//
//  Created by Mohamed Hassan on 02/02/2023.
//

import Foundation
import Combine
import UIKit

class ImageDownloader {
    static let shared = ImageDownloader()

    func downloadImagePublisher(_ imageRequest: URLRequest) -> AnyPublisher<UIImage, URLError> {
        return URLSession.shared.dataTaskPublisher(for: imageRequest)
            .receive(on: RunLoop.main)
            .map(\.data)
            .compactMap({ UIImage(data: $0) })
            .eraseToAnyPublisher()
    }

    func loadImageFromDocumentDirectory(mediaID: String, type: String) -> UIImage {
        let imageName = "\(mediaID)-\(type)"
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let dirPath = paths.first{
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("Media/\(imageName)")
            guard let image = UIImage(contentsOfFile: imageURL.path) else { return  UIImage.init(named: "placeholder") ?? UIImage()}
            return image
        }
        return UIImage(named: "placeholder") ?? UIImage()
    }

    func saveImageToDocumentDirectory(image: UIImage, mediaID: String, type: String) {
        var objCBool: ObjCBool = true
        let mainPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
        let folderPath = mainPath + "/Media/"

        let isExist = FileManager.default.fileExists(atPath: folderPath, isDirectory: &objCBool)
        if !isExist {
            do {
                try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }

        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imageName = "\(mediaID)-\(type)."
        let imageUrl = documentDirectory.appendingPathComponent("Media/\(imageName)")
        if let data = image.jpegData(compressionQuality: 1.0){
            do {
                try data.write(to: imageUrl)
            } catch {
                print("error saving", error)
            }
        }
    }
}
