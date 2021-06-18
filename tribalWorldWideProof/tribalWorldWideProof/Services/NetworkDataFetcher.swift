//
//  NetworkDataFetcher.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 17/06/21.
//

import Foundation

class NetworkDataFetcher{
    
    var networkService = NetworkService()
    
    func fetchImages(searchTerm: String, completion: @escaping (SearchResults?) -> ()){
        networkService.request(searchText: searchTerm) { (data, error) in
            if let error = error {
                debugPrint("Error haciendo la petición: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
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
