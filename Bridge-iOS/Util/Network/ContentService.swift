//
//  ContentsService.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 11..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import Foundation
import Alamofire

class ContentService: Network {
    
    static let decoder: JSONDecoder = {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        //2018-07-10T19:21:51.000Z
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    static func postComment(contentsIdx: Int, ccmtContent: String, userIdx: Int, completion: @escaping ()->Void) {
        let url: String = self.url(path: "/contents/ccomment_write", parameters: nil)
        let body: [String: Any] = [
            "contentsIdx": contentsIdx,
            "ccmtContent": ccmtContent,
            "userIdx": userIdx
        ]
        Alamofire.request(url, method:.post, parameters: body).response { (response) in
            completion()
        }
    }
    
    static func postAddViewCount(contentsIdx: Int) {
        let url: String = self.url(path: "/contents/chit", parameters: nil)
        let body: [String: Any] = [
            "contentsIdx": contentsIdx
        ]
        Alamofire.request(url, method:.post, parameters: body)
    }
    
    static func postDeleteComment(userIdx: Int, ccmtIdx: Int, completion: @escaping ()->Void) {
        let url: String = self.url(path: "/contents/ccomment_delete", parameters: nil)
        let body: [String: Any] = [
            "userIdx": userIdx,
            "ccmtIdx": ccmtIdx
        ]
        Alamofire.request(url, method:.post, parameters: body).response { (response) in
            completion()
        }
    }
    
    static func postLike(contentsIdx: Int, userIdx: Int, completion: @escaping ()->Void) {
        let url: String = self.url(path: "/contents/clike", parameters: nil)
        let body: [String: Any] = [
            "contentsIdx": contentsIdx,
            "userIdx": userIdx
        ]
        Alamofire.request(url, method:.post, parameters: body).response { (response) in
            completion()
        }
    }
    
    static func postContent(userIdx: Int, contentsIdx: Int, contentsType: Int, completion: @escaping (ContentData) -> Void) {
        let url: String = self.url(path: "/contents/getcontents", parameters: nil)
        let body: [String: Any] = [
            "userIdx": userIdx,
            "contentsIdx": contentsIdx,
            "contentsType": contentsType
        ]
        Alamofire.request(url, method:.post, parameters: body).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData = try self.decoder.decode(HomeServiceData.self, from: value)
                        completion(decodedData.data[0].contents_list[0])
                    }
                    catch(let error) {
                        print("postContent - Decode json data exception: \(error.localizedDescription), Detail: \(error.self)")
                    }
                }
                break
            case .failure(let error):
                print("GET failure to load comment data: \(error.localizedDescription)")
                break
            }
        }
    }
    
    static func postContentImage(userIdx: Int, contentsIdx: Int, contentsType: Int, completion: @escaping ([ContentData]) -> Void) {
        let url: String = self.url(path: "/contents/getcontents", parameters: nil)
        let body: [String: Any] = [
            "userIdx": userIdx,
            "contentsIdx": contentsIdx,
            "contentsType": contentsType
        ]
        Alamofire.request(url, method:.post, parameters: body).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData = try self.decoder.decode(HomeServiceData.self, from: value)
                        completion(decodedData.data[0].contents_list)
                    }
                    catch(let error) {
                        print("postContent - Decode json data exception: \(error.localizedDescription), Detail: \(error.self)")
                    }
                }
                break
            case .failure(let error):
                print("GET failure to load comment data: \(error.localizedDescription)")
                break
            }
        }
    }
    
    static func postDeleteReplay(crecmtIdx: Int, userIdx: Int, completion: @escaping () -> Void) {
        let url: String = self.url(path: "/contents/crecomment_delete", parameters: nil)
        let body: [String: Any] = [
            "crecmtIdx": crecmtIdx,
            "userIdx": userIdx
        ]
        Alamofire.request(url, method:.post, parameters: body).response { (response) in
            completion()
        }
    }
    
    static func postReplay(ccmtIdx: Int, crecmtContent: String, userIdx: Int, completion: @escaping () -> Void) {
        let url: String = self.url(path: "/contents/crecomment_write", parameters: nil)
        let body: [String: Any] = [
            "ccmtIdx": ccmtIdx,
            "crecmtContent": crecmtContent,
            "userIdx": userIdx
        ]
        Alamofire.request(url, method:.post, parameters: body).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData = try self.decoder.decode(ContentCommentServiceData.self, from: value)
                        completion()
                    }
                    catch(let error) {
                        print("postReplay - Decode json data exception: \(error.localizedDescription), Detail: \(error.self)")
                    }
                }
                break
            case .failure(let error):
                print("GET failure to load comment data: \(error.localizedDescription)")
                break
            }
        }
    }
    
    static func getReplays(ccmtIdx: Int, lastcontentsIdx: Int, completion: @escaping ([ReplayCommentData])->Void) {
        let url: String = self.url(path: "/contents/crecomment_view", parameters: ccmtIdx, lastcontentsIdx)
        Alamofire.request(url, method: .get).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData = try self.decoder.decode(ContentCommentServiceData.self, from: value)
                        completion(decodedData.data[0].recomment_list!)
                    }
                    catch(let error) {
                        print("get replays - Decode json data exception: \(error.localizedDescription), Detail: \(error.self)")
                    }
                }
                break
            case .failure(let error):
                print("GET failure to load comment data: \(error.localizedDescription)")
                break
            }
        }
    }
    
    static func getUpNext(lastContentsIdx: Int, contentsIdx: Int, completion: @escaping ([ContentData])->Void) {
        let url: String = self.url(path: "/contents/nextcontents", parameters: lastContentsIdx, contentsIdx)
        Alamofire.request(url, method: .get).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData = try self.decoder.decode(HomeServiceData.self, from: value)
                        completion(decodedData.data[0].contents_list)
                    }
                    catch(let error) {
                        print("getUpNext - Decode json data exception: \(error.localizedDescription), Detail: \(error.self)")
                    }
                }
                break
            case .failure(let error):
                print("GET failure to load comment data: \(error.localizedDescription)")
                break
            }
        }
    }
    
    static func getContentComment(contentIndex: Int, lastContentsIndex: Int, completion: @escaping ([ContentCommentData])->Void) {
        let url: String = self.url(path: "/contents/ccomment_view", parameters: contentIndex, lastContentsIndex)
        Alamofire.request(url, method: .get).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData = try self.decoder.decode(ContentCommentServiceData.self, from: value)
                        completion(decodedData.data[0].comments_list!)
                    }
                    catch(let error) {
                        print("getContentComment - Decode json data exception: \(error.localizedDescription), Detail: \(error.self)")
                    }
                }
                break
            case .failure(let error):
                print("GET failure to load comment data: \(error.localizedDescription)")
                break
            }
        }
    }
}
