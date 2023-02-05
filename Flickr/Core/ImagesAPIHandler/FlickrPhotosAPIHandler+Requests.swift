//
//  ImagesAPIHandler+Requests.swift
//  Flickr
//
//  Created by Mohamed Hassan on 03/02/2023.
//

import Foundation

extension FlickrPhotosAPIHandler {
    private func flickrRequest() -> URLRequest? {
        guard var url = URL(string: endPoint) else { return nil }
        url.append(queryItems: [
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "api_key", value: "1508443e49213ff84d566777dc211f2a"),
            URLQueryItem(name: "media", value: "photos"),
            URLQueryItem(name: "nojsoncallback", value: "?"),
        ])
        return URLRequest(url: url)
    }

    internal func searchPhotosRequest(query: String, pageSize: Int) -> URLRequest? {
        guard var request = flickrRequest() else { return nil }
        request.url?.append(queryItems: [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "per_page", value: "\(pageSize)"),
            URLQueryItem(name: "text", value: query)
        ])
        request.httpMethod = "GET"
        return request
    }

    internal func searchPhotosRequest(query: String, pageSize: Int, page: Int) -> URLRequest? {
        guard var request = flickrRequest() else { return nil }
        request.url?.append(queryItems: [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "per_page", value: "\(pageSize)"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "text", value: query)
        ])
        request.httpMethod = "GET"
        return request
    }

    internal func photoInfoRequest(photoId: String) -> URLRequest? {
        guard var request = flickrRequest() else { return nil }
        request.url?.append(queryItems: [
            URLQueryItem(name: "method", value: "flickr.photos.getSizes"),
            URLQueryItem(name: "photo_id", value: photoId)
        ])
        request.httpMethod = "GET"
        return request
    }
}
