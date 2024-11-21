//
//  FlickrImage.swift
//  FlickrImageSearch
//
//  Created by Disamcharla, Praveen Kumar on 11/20/24.
//

import Foundation

struct FlickrImage: Identifiable, Decodable {
    let id = UUID() // Unique ID for SwiftUI's Identifiable
    let title: String
    let link: String
    let description: String
    let author: String
    let published: String

    private enum CodingKeys: String, CodingKey {
        case title, link, description, author, published
    }
}


