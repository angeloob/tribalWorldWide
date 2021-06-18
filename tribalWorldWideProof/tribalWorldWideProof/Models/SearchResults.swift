//
//  SearchResults.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 17/06/21.
//

import Foundation

struct SearchResults: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let created_at: String
    let likes: Double
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue: String]
    let description: String?
    let user: User
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct User: Decodable {
    let username: String
    let name: String
    let profile_image: [URLProfilePhoto.RawValue: String]
    
    enum URLProfilePhoto: String {
        case small
        case medium
        case large
    }
}
