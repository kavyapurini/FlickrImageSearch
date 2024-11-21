//
//  ImageSearchViewModel.swift
//  FlickrImageSearch
//
//  Created by Disamcharla, Praveen Kumar on 11/20/24.
//

import SwiftUI

class ImageSearchViewModel: ObservableObject {
    @Published var searchText: String = "" // Search input
    @Published var images: [FlickrImage] = [] // List of fetched images
    @Published var isLoading: Bool = false // Loading state
    @Published var errorMessage: String? // Error message

    /// Fetch images from Flickr API based on search text.
    /// - Parameter searchQuery: Search query string
    func fetchImages(for searchQuery: String) {
        guard !searchQuery.isEmpty else {
            self.images = []
            return
        }

        isLoading = true
        errorMessage = nil
        let formattedQuery = searchQuery.replacingOccurrences(of: " ", with: ",")
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(formattedQuery)"

        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }

                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }

                do {
                    let decodedResponse = try JSONDecoder().decode(FlickrResponse.self, from: data)
                    self?.images = decodedResponse.items
                } catch {
                    self?.errorMessage = "Failed to decode response"
                }
            }
        }.resume()
    }
}

struct FlickrResponse: Decodable {
    let items: [FlickrImage]
}
