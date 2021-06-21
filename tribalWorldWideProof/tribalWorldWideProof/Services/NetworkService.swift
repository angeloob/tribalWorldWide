//
//  NetworkService.swift
//  tribalWorldWideProof
//
//  Created by Angel Olvera on 17/06/21.
//

import Foundation
import Firebase

class NetworkService {
    
    var ref: DatabaseReference!
    
    func request(searchText: String, currentPage: Int, completion: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareParameters(searchTerm: searchText, currentPage: currentPage)
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
    
    private func prepareParameters(searchTerm: String?, currentPage: Int) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(currentPage)
        parameters["per_page"] = String(10)
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
    
//    MARK: funciones para la vista de profile
    
    func requestForProfile(username: String, isForPhotos: Bool, completion: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareParametersForProfile(username: username)
        let url = self.urlForProfile(params: parameters, username: username, isForPhotos: isForPhotos)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareParametersForProfile(username: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["username"] = username
        return parameters
    }
    
    private func urlForProfile(params: [String: String], username: String, isForPhotos: Bool) -> URL{
        var componets = URLComponents()
        componets.scheme = "https"
        componets.host = "api.unsplash.com"
        if isForPhotos{
            componets.path = "/users/\(username)/photos"
        }else{
            componets.path = "/users/\(username)"
        }
        componets.queryItems = params.map({ URLQueryItem(name: $0, value: $1)
        })
        return componets.url!
    }
    
    func requestForProfileCollection(username: String, completion: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareParametersForProfile(username: username)
        let url = self.urlForCollection(params: parameters, username: username)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func urlForCollection(params: [String: String], username: String) -> URL{
        var componets = URLComponents()
        componets.scheme = "https"
        componets.host = "api.unsplash.com"
        componets.path = "/users/\(username)/collections"
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
    
    func uploadFireBase(data: UnsplashPhoto){
        ref = Database.database().reference()
        let photoUrl = data.urls["full"]!
        let profileUrl = data.user.profile_image["medium"]
        let username = data.user.username
        let likes = data.likes
        let descriptionImage = data.description
        let dateImage = data.created_at
        let array = ["profileUrl": profileUrl ?? "", "username": username, "likes": likes, "descriptionImagen": descriptionImage ?? "", "photoUrl": photoUrl, "date": dateImage] as [String : Any]
        ref.child("data/\(dateImage)").setValue(array)
    }
    
    func uploadFireBase(data: dataDownloadedFromFirebase){
        ref = Database.database().reference()
        let photoUrl = data.photoUrl
        let profileUrl = data.profileUrl
        let username = data.username
        let likes = data.likes
        let descriptionImage = data.descriptionImage
        let dateImage = data.date
        let array = ["profileUrl": profileUrl ?? "", "username": username ?? "", "likes": likes ?? 0, "descriptionImagen": descriptionImage ?? "", "photoUrl": photoUrl ?? "", "date": dateImage ?? ""] as [String : Any]
        ref.child("data/\(dateImage ?? "")").setValue(array)
    }
    
    func removeFirebase(data: dataDownloadedFromFirebase){
        ref = Database.database().reference()
        ref.child("data/\(data.date ?? "")").removeValue()
    }
    
    func removeFirebase(data: UnsplashPhoto){
        ref = Database.database().reference()
        ref.child("data\(data.created_at)").removeValue()
    }
}
