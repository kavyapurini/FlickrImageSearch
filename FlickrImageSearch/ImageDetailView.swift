//
//  SwiftUIView.swift
//  FlickrImageSearch
//
//  Created by Disamcharla, Praveen Kumar on 11/20/24.
//

import SwiftUI

struct ImageDetailView: View {
    let image: FlickrImage

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: image.link)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                } placeholder: {
                    ProgressView()
                }

                Text(image.title)
                    .font(.headline)
                    .padding(.top)

                Text(image.description)
                    .font(.body)

                Text("Author: \(image.author)")
                    .font(.subheadline)

                Text("Published: \(formattedDate(from: image.published))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .navigationTitle("Image Details")
    }

    /// Format the date string into a readable format
    /// - Parameter dateString: Published date string
    /// - Returns: Formatted date
    func formattedDate(from dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .none
            return displayFormatter.string(from: date)
        }
        return dateString
    }
}


#Preview {
    SwiftUIView()
}
