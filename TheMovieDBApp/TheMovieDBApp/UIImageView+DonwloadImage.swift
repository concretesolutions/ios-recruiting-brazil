//
//  UIImageView+DonwloadImage.swift
//  TheMovieDB
//
//  Created by Gustavo Quenca on 03/11/18.
//  Copyright © 2018 Quenca. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(url: URL) -> URLSessionDownloadTask {
        print("LOAD IMAGE")
        let session = URLSession.shared
        // Save the donwloaded file to a temporary location on disk
        let donwloadTask = session.downloadTask(with: url, completionHandler: { [weak self] url, response, error in
            // check error in the given url
            if error == nil, let url = url, let data = try? Data(contentsOf: url),
                // load the file into a Data object
                let image = UIImage(data: data) {
                // Put the image into a image property to use in the main thread
                DispatchQueue.main.async {
                    if let weakSelf = self {
                        weakSelf.image = image
                    }
                }
            }
        })
        // After creating the download task you call resume() to start it, and then return the URLSessionDownloadTask object to the caller
        donwloadTask.resume()
        return donwloadTask
    }
}
