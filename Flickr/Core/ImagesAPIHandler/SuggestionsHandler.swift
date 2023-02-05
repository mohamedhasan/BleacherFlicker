//
//  SuggestionsHandler.swift
//  Flickr
//
//  Created by Mohamed Hassan on 05/02/2023.
//

import Foundation
import Combine
import UIKit

class SuggestionsHandler {
    static let shared = SuggestionsHandler()
    private let queriesKey = "queries"
    
    func saveSearchQuery(_ query: String) {
        guard var list = UserDefaults.standard.object(forKey: queriesKey) as? [String] else {
            UserDefaults.standard.set([query], forKey: queriesKey)
            return
        }
        if !list.contains(query) {
            list.append(query)
        }
        UserDefaults.standard.set(list, forKey: queriesKey)
    }
    
    func getSavedQueries() -> AnyPublisher<String, Never>? {
        guard let list = UserDefaults.standard.object(forKey: queriesKey) as? [String] else {
            return nil
        }
        return list.publisher.eraseToAnyPublisher()
    }
}
