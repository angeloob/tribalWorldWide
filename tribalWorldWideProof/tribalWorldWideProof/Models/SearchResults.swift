//
//  SearchResults.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 17/06/21.
//

import Foundation

struct SearchResults: Decodable {
    let total: Int
    let total_pages: Int
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

struct userData: Decodable {
    let username: String
    let name: String?
    let bio: String?
    let location: String?
    let total_likes: Int
    let total_photos: Int
    let total_collections: Int
    let profile_image: [URLProfilePhoto.RawValue: String]
    
    enum URLProfilePhoto: String {
        case small
        case medium
        case large
    }
}

struct imagePhoto: Decodable {
    let urls: [URLProfilePhoto.RawValue: String]
    
    enum URLProfilePhoto: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct collectionPhoto: Decodable {
    let urls: [URLProfilePhoto.RawValue: String]
    
    enum URLProfilePhoto: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct dataDownloadedFromFirebase {
    var username: String?
    var name: String?
    var descriptionImage: String?
    var likes: Int?
    var photoUrl: String?
    var profileUrl: String?
    var date: String?
    
    init(username: String, name: String, descriptionImage: String, likes: Int, photoUrl: String, profileUrl: String, date: String) {
        self.username = username
        self.name = name
        self.descriptionImage = descriptionImage
        self.likes = likes
        self.photoUrl = photoUrl
        self.profileUrl = profileUrl
        self.date = date
    }
}
