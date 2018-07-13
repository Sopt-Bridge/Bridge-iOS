//
//  HomeService.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 9..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HomeService: Network {
    
    static let decoder: JSONDecoder = {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    static func getTrending(category: Int, completion: @escaping ([ContentData])->Void) {
        let url: String = HomeService.url(path: "/home/nowtrend", parameters: category)
        Alamofire.request(url, method: .get).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData: HomeServiceData = try self.decoder.decode(HomeServiceData.self, from: value)
//                        print("success---")
//                        print(decodedData)
                        completion(decodedData.data[0].contents_list)
                    }
                    catch(let error) {
                        print("Decode json data exception: \(error.localizedDescription), Detail: \(error.self)")
                    }
                }
                break
                
            case .failure(let error):
                print("GET failure to load trending data: \(error.localizedDescription)")
                break
            }
        }
    }
    
    static func getRecent(category: Int, page: Int, completion: @escaping ([ContentData])->Void) {
        let url: String = HomeService.url(path: "/home/recent", parameters: category, page)
        Alamofire.request(url, method: .get).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData = try self.decoder.decode(HomeServiceData.self, from: value)
                        completion(decodedData.data[0].contents_list)
                    }
                    catch(let error) {
                        print("Decode json data exception: \(error.localizedDescription), Detail: \(error.self)")
                    }
                }
                break
            case .failure(let error):
                print("GET failure to load recent data: \(error.localizedDescription)")
                break
            }
        }
    }
    
    static func getRecommended(completion: @escaping ([ContentData])->Void) {
        let url: String = HomeService.url(path: "/home/recommended", parameters: nil)
        Alamofire.request(url, method: .get).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData = try self.decoder.decode(HomeServiceData.self, from: value)
                        completion(decodedData.data[0].contents_list)
                    }
                    catch(let error) {
                        print("Decode json data exception: \(error.localizedDescription), Detail: \(error.self)")
                    }
                }
                break
                
            case .failure(let error):
                print("GET failure to load recommended data: \(error.localizedDescription)")
                break
            }
        }
    }
    
    static func getLikes(category: Int, page: Int, completion: @escaping ([ContentData])->Void) {
        let url: String = HomeService.url(path: "/home/likesort", parameters: category, page)
        Alamofire.request(url, method: .get).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData = try self.decoder.decode(HomeServiceData.self, from: value)
                        completion(decodedData.data[0].contents_list)
                    }
                    catch(let error) {
                        print("Decode json data exception: \(error.localizedDescription), Detail: \(error.self)")
                    }
                }
                break
                
            case .failure(let error):
                print("GET failure to load likes data: \(error.localizedDescription)")
                break
            }
        }
    }
    
    static func getViewOrdered(category: Int, page: Int, completion: @escaping ([ContentData])->Void) {
        let url: String = HomeService.url(path: "/home/hitsort", parameters: category, page)
        Alamofire.request(url, method: .get).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData = try self.decoder.decode(HomeServiceData.self, from: value)
                        completion(decodedData.data[0].contents_list)
                    }
                    catch(let error) {
                        print("Decode json data exception: \(error.localizedDescription), Detail: \(error.self)")
                    }
                }
                break
                
            case .failure(let error):
                print("GET failure to load viewordered data: \(error.localizedDescription)")
                break
            }
        }
    }
}
