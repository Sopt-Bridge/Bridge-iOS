//
//  AlamoUtil.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 11..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import Foundation
import Alamofire
import AVKit

class AlamoUtil {
    static func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        if let urlData = URL(string: url) {
            Alamofire.request(urlData, method: .get).responseData { (response) in
                if let data = response.data {
                    completion(UIImage(data: data))
                }
            }
        }
    }
    
    static func loadThumbnail(url: String, completion: @escaping (UIImage?) -> Void) {
        if let urlData = URL(string: url) {
            do {
                let asset = AVURLAsset(url: urlData, options: nil)
                let imgGenerator = AVAssetImageGenerator(asset: asset)
                imgGenerator.appliesPreferredTrackTransform = true
                let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(10, 1), actualTime: nil)
                let thumbnail = UIImage(cgImage: cgImage)
                completion(thumbnail)
            }
            catch let error {
                print("Error generating thumbnail: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
