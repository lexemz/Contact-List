//
//  NetworkMaganer.swift
//  Contact List
//
//  Created by Igor on 02.10.2021.
//

import Foundation

class NetwokManager {
    static let shared = NetwokManager()
    
    private let urlAPI = "https://randomuser.me/api/?results=100"
    private let urlParameters: [URLQueryItem] = [
        URLQueryItem(name: "results", value: "50")
    ]
    
    
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        return try? Data(contentsOf: imageURL)
    }
    
    func fetchContacts(completion: @escaping ([Contact]) -> Void) {
        guard var urlWithComponents = URLComponents(string: urlAPI) else { return }
        urlWithComponents.queryItems = urlParameters
        
        guard let url = urlWithComponents.url else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error info")
                return
            }

            do {
                var contacts: [Contact] = []
                let results = try JSONDecoder().decode(Results.self, from: data)
                
                for contact in results.results {
                    contacts.append(contact)
                }
                
                completion(contacts)
                
            } catch {
                print("Decode error")
            }
            
        }.resume()
    }
}
