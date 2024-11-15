//
//  ImageViewModel.swift
//  MultithreadingAndConcurrency
//
//  Created by Nika Topuria on 06.11.24.
//

import Foundation
import UIKit

final class ImageViewModel {
    private let networkManager: NetworkManaging
    private let imageProcessor: ImageProcessing
    
    var onImagesUpdated: (() -> Void)?
    
    var images: [UIImage] = [] {
        didSet {
            onImagesUpdated?()
        }
    }
    
    private var imageUrls: [URL] = []
    
    init(
        networkManager: NetworkManaging = NetworkManager(),
        imageProcessor: ImageProcessing = ImageProcessor()
    ) {
        self.networkManager = networkManager
        self.imageProcessor = imageProcessor
    }
    
    // MARK: - დეველოპერებო, აქ უნდა ღვაროთ ოფლი
    
    // დაასრულეთ მეთოდის იმპლემენტაცია GCD-ის გამოყენებით (DispatchGroup)
    func fetchImagesWithGCD() {
        let group = DispatchGroup()
        var images = [UIImage?]()
        for url in imageUrls {
            group.enter()
            DispatchQueue.global().async {
                self.networkManager.downloadImage(from: url) { image in
                    images.append(image)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.images = images.compactMap({ $0 })
        }
        // არ დაგავიწყდეთ, გადმოწერილი იმიჯები საბოლოოდ უნდა მოხვდეს images მასივში.
    }
    
    // დაასრულეთ მეთოდის იმპლემენტაცია NSOperationQueue-ის გამოყენებით
    func fetchImagesWithOperationQueue() {
                var images = [UIImage?]()
                let queue = OperationQueue()

                let completionOperation = BlockOperation {
                    self.images = images.compactMap { $0 }
                }

                for url in imageUrls {
                    let operation = BlockOperation {
                        let semaphore = DispatchSemaphore(value: 0)
                        self.networkManager.downloadImage(from: url) { image in
                            images.append(image)

                            semaphore.signal()
                        }
                        semaphore.wait()
                    }
                    completionOperation.addDependency(operation)
                    queue.addOperation(operation)
                }

                queue.addOperation(completionOperation)
        // არ დაგავიწყდეთ, გადმოწერილი იმიჯები საბოლოოდ უნდა მოხვდეს images მასივში.
    }
    
    // დაასრულეთ მეთოდის იმპლემენტაცია async/await-ის გამოყენებით (შეგიძლიათ დაიხმაროთ fetchAndProcessImageAsync())
    func fetchImagesWithAsyncAwait() {
                var images = [UIImage?]()
                Task {
                    for url in imageUrls {
                        let image = await fetchAndProcessImageAsync(from: url)
                        images.append(image)
                    }
                    self.images = images.compactMap { $0 }
                }
            }
    
    func updateNumberOfImages(to count: Int) {
        generateImageUrls(numberOfImages: count)
    }
    
    private func generateImageUrls(numberOfImages: Int) {
        let maxImageNumber = 700
        var urls: [URL] = []
        
        for _ in 1...numberOfImages {
            let randomImageNumber = Int.random(in: 1...maxImageNumber)
            if let url = URL(string: "https://yavuzceliker.github.io/sample-images/image-\(randomImageNumber).jpg") {
                urls.append(url)
            }
        }
        
        self.imageUrls = urls
    }
    
    private func fetchAndProcessImage(from url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url else { return }
        networkManager.downloadImage(from: url) { [weak self] image in
            guard let self = self, let image = image else {
                completion(nil)
                return
            }
            self.imageProcessor.applyFilter(to: image) { processedImage in
                completion(processedImage)
            }
        }
    }
    
    private func fetchAndProcessImageAsync(from url: URL?) async -> UIImage? {
        await withCheckedContinuation { continuation in
            self.fetchAndProcessImage(from: url) { image in
                continuation.resume(returning: image)
            }
        }
    }
}
