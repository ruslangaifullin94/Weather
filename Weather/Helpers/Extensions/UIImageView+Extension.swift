//
//  UIImageView+Extension.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 10.01.2024.
//

import UIKit

extension UIImageView {

    private static let imageLoader = ImageDownloader(cacheCountLimit: 500)

    @MainActor
    func setImage(by url: URL) async throws {
        let image = try await Self.imageLoader.loadImage(for: url)

        if !Task.isCancelled {
            self.image = image
        }
    }
}
