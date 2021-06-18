//
//  NetworkService.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 17/06/21.
//

import Foundation
import Firebase

class NetworkService {
    
    func request(searchText: String, completion: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareParameters(searchTerm: searchText)
        let url = self.url(params: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID fCDKswOswNb2iHDTurBaSQ8_mmnJlZwYL68-3X4c6_k"
        return headers
    }
    
    private func prepareParameters(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        return parameters
    }

    private func url(params: [String: String]) -> URL{
        var componets = URLComponents()
        componets.scheme = "https"
        componets.host = "api.unsplash.com"
        componets.path = "/search/photos"
        componets.queryItems = params.map({ URLQueryItem(name: $0, value: $1)
        })
        return componets.url!
    }
    
    private func createDataTask (from request: URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask{
        return URLSession.shared.dataTask(with: request){ (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    var ref: DatabaseReference!

    
    
    func uploadFireBase(array: UnsplashPhoto){
        ref = Database.database().reference()
        ref.child("data\(array.urls["full"]!)").setValue(array)
    }

}
