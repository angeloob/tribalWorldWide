//
//  NetworkDataFetcher.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 17/06/21.
//

import Foundation

class NetworkDataFetcher{
    
    var networkService = NetworkService()
    
    func fetchImages(searchTerm: String, currentPage: Int, completion: @escaping (SearchResults?) -> ()){
        networkService.request(searchText: searchTerm, currentPage: currentPage) { (data, error) in
            if let error = error {
                debugPrint("Error haciendo la petición: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
        }
    }
    
    func fetchImagesForProfile(username: String, isForPhotos: Bool, completion: @escaping (userData?) -> ()){
        networkService.requestForProfile(username: username, isForPhotos: isForPhotos) { (data, error) in
            if let error = error {
                debugPrint("Error haciendo la petición: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: userData.self, from: data)
            completion(decode)
        }
    }
    
    func fetchImagesForPhotos(username: String, isForPhotos: Bool, completion: @escaping ([imagePhoto]?) -> ()){
        networkService.requestForProfile(username: username, isForPhotos: isForPhotos) { (data, error) in
            if let error = error {
                debugPrint("Error haciendo la petición: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: [imagePhoto].self, from: data)
            completion(decode)
        }
    }
    
    func fetchImagesForCollection(username: String, completion: @escaping ([collectionPhoto]?) -> ()){
        networkService.requestForProfileCollection(username: username) { (data, error) in
            if let error = error {
                debugPrint("Error haciendo la petición: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: [collectionPhoto].self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else {return nil}
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError{
            debugPrint("Falló el decode de JSON", jsonError)
            return nil
        }
    }
}
