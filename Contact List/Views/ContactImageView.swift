//
//  ContactImageView.swift
//  Contact List
//
//  Created by Igor on 04.10.2021.
//

import UIKit

class ContactImageView: UIImageView {
    func fetchImage(from url: String) {
        // в случае битой ссылки возвращаем изображение заглушку
        guard let url = URL(string: url) else {
            image = UIImage(systemName: "person.crop.circle")
            return
        }
        
        // проверяем наличие изображения в кеше, если есть, восстанавливаем из кеша
        // НЕ СДЕЛАНО, КАРТИНКИ ВСЁ РАВНО ПРЫГАЮТ В ТАБЛИЦЕ
        
        // изображения в кеше нет, грузим из сети и загружаем в кеш
        NetwokManager.shared.fetchImage(from: url) { data, response in
            self.image = UIImage(data: data)
            
            self.fetchImageAndSaveInCache(data: data, response: response)
        }
    }
    
    private func fetchImageAndSaveInCache(data: Data, response: URLResponse) {
        // создаем кешируемый объект
        // сохраняем как данные, так и ответ от сервера
        let cachedObject = CachedURLResponse(response: response, data: data)
        
        // передаем URL, который лежит в ответе от сервера
        // по нему будем в будущем искать кешируемый объект
        guard let url = response.url else { return}
        let urlRequest = URLRequest(url: url)
        
        // Кешируем данные
        URLCache.shared.storeCachedResponse(cachedObject, for: urlRequest)
    }
}

