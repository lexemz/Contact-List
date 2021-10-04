//
//  NetworkMaganer.swift
//  Contact List
//
//  Created by Igor on 02.10.2021.
//

import Foundation

class NetwokManager {
    static let shared = NetwokManager()
    
    private let urlAPI = "https://randomuser.me/api/"
    private let urlParameters: [URLQueryItem] = [
        URLQueryItem(name: "results", value: "30")
    ]
    
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                return
            }
            
            // Проверяем, совпадает ли URL, требуемый для конкретной ячейки с URL, который должен прийти с сервера, если не совпадают, то не выдаем изображение ячейке, у которой другой адрес
            guard url == response.url else { return }
            
            DispatchQueue.main.async {
                completion(data, response)
            }
            
        }.resume()
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
