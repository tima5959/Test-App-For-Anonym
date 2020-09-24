//
//  NetworkService.swift
//  Test App For Anonym
//
//  Created by Тимур Фатулоев on 21.09.2020.
//  Copyright © 2020 Тимур Фатулоев. All rights reserved.
//

import UIKit

class NetworkService {
    private let session = URLSession(configuration: .default)
    private let urlString = "http://stage.apianon.ru:3000/fs-posts/v1/posts"
    
    var images = [String: UIImage]()
    
    func fetchNews(_ completionHandler: @escaping ([News]) -> Void,
                   _ completionError: @escaping (String?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completionError(error.localizedDescription)
                return
            }
            
            guard let data = data,
                let news = try? JSONDecoder().decode(Response.self, from: data).data?.items else { return }
                
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            
            DispatchQueue.main.async {
                completionHandler(news)
            }
        }.resume()
    }
    
    
    
    private func fetchPhoto(_ url: String) {
        guard let urlRequset = URL(string: url) else { return }
        
        var requset = URLRequest(url: urlRequset)
        requset.httpMethod = "GET"
        URLSession.shared.dataTask(with: requset) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                print("photo not found \(#function)")
            }
            
            guard let data = data,
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.images[url] = image
            }
        }.resume()
    }
    
    func setImage(_ atIndexPath: IndexPath, by url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else {
            fetchPhoto(url)
        }
        return image
    }
}
