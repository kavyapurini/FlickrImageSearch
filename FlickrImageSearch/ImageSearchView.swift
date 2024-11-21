//
//  ImageSearchView.swift
//  FlickrImageSearch
//
//  Created by Disamcharla, Praveen Kumar on 11/20/24.
//

import SwiftUI

struct ImageSearchView: View {
    @StateObject private var viewModel = ImageSearchViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                TextField("Search images...", text: $viewModel.searchText, onEditingChanged: { _ in
                    viewModel.fetchImages(for: viewModel.searchText)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    // Image grid
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
                            ForEach(viewModel.images) { image in
                                NavigationLink(destination: ImageDetailView(image: image)) {
                                    AsyncImage(url: URL(string: image.link)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(8)
                                    } placeholder: {
                                        Color.gray
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Flickr Image Search")
        }
    }
}

#Preview {
    ImageSearchView()
}
