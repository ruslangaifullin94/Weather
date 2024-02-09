//
//  ImageDownloader.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 10.01.2024.
//

import UIKit

public actor ImageDownloader {
    private var cache = NSCache<NSURL, UIImage>()
    
    public init(cacheCountLimit: Int) {
        cache.countLimit = cacheCountLimit
    }
    
    func loadImage(for url: URL) async throws -> UIImage {
        if let image = lookupCache(for: url) {
            return image
        }
        
        let image = try await doLoadImage(for: url)
        
        updateCache(image: image, and: url)
        return lookupCache(for: url) ?? image
    }
    
    private func doLoadImage(for url: URL) async throws -> UIImage {
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        guard let content = SVG(data) else {
            throw URLError(.cannotDecodeContentData)
        }
        let render = UIGraphicsImageRenderer(size: content.size)
        let image = render.image { context in
            content.draw(in: context.cgContext)
        }
        
        return image
    }
    
    private func lookupCache(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    private func updateCache(image: UIImage, and url: URL) {
        if cache.object(forKey: url as NSURL) == nil {
            cache.setObject(image, forKey: url as NSURL)
        }
    }
}
