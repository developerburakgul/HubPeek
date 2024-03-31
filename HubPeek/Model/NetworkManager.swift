//
//  Network.swift
//  HubPeek
//
//  Created by Burak Gül on 30.03.2024.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.github.com/users/"
    
    func fetchUser(for username: String, completion: @escaping (Result<GithubUser, Error>) -> Void) {
        let urlString = "https://api.github.com/users/\(username)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1001, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NSError(domain: "", code: -1002, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
            
            
            do {
                

                let user = try JSONDecoder().decode(GithubUser.self, from: data)
                
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchFollowers(for username: String, completion: @escaping (Result<[Follower], Error>) -> Void) {
        
        let urlString = baseURL + "\(username)/followers"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1001, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NSError(domain: "", code: -1002, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
            
            
            do {
                

                let follower = try JSONDecoder().decode([Follower].self, from: data)
                
                completion(.success(follower))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else {
                print("Download error or data is not an image")
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                completion(image)
            }
        }
        .resume()
    }
    
    
    
    
}



