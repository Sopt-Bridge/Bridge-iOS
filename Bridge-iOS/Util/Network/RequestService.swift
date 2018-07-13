//
//  RequestService.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 12..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import Foundation
import Alamofire

class RequestService: Network {
    
    static let decoder: JSONDecoder = {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        //2018-07-10T19:21:51.000Z
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    static func postWrite(userIdx: Int, iboardUrl: String, iboardContent: String, iboardTitle: String,  completion: @escaping () -> Void) {
        let url: String = self.url(path: "/trequest/trequest_write", parameters: nil)
        let body: [String: Any] = [
            "userIdx": userIdx,
            "iboardUrl": iboardUrl,
            "iboardContent": iboardContent,
            "iboardTitle": iboardTitle
        ]
        Alamofire.request(url, method:.post, parameters: body).responseData { (response) in
            completion()
        }
    }
    
    static func postCommentWrite(userIdx: Int, icmtContent: String, iboardIdx: Int, completion: @escaping () -> Void) {
        let url: String = self.url(path: "/trequest/trequestcomment_write", parameters: nil)
        let body: [String: Any] = [
            "userIdx": userIdx,
            "icmtContent": icmtContent,
            "iboardIdx": iboardIdx
        ]
        Alamofire.request(url, method:.post, parameters: body).responseData { (response) in
            completion()
        }
    }
    
    static func postRequestCommentDelete(icmtIdx: Int, completion: @escaping () -> Void) {
        let url: String = self.url(path: "/trequest/trequestcomment_delete", parameters: nil)
        let body: [String: Any] = [
            "icmtIdx": icmtIdx
        ]
        Alamofire.request(url, method:.post, parameters: body).responseData { (response) in
            completion()
        }
    }
    
    static func postReplayRequestCommentWrite(icmtIdx: Int, ircmtContent: String, userIdx: Int, completion: @escaping () -> Void) {
        let url: String = self.url(path: "/trequest/trequestrecomment_write", parameters: nil)
        let body: [String: Any] = [
            "icmtIdx": icmtIdx,
            "userIdx": userIdx,
            "ircmtContent": ircmtContent
        ]
        Alamofire.request(url, method:.post, parameters: body).responseData { (response) in
            completion()
        }
    }
    
    static func postReplayRequestCommentDelete(ircmtIdx: Int, completion: @escaping () -> Void) {
        let url: String = self.url(path: "/trequest/trequestrecomment_delete", parameters: nil)
        let body: [String: Any] = [
            "ircmtIdx": ircmtIdx
        ]
        Alamofire.request(url, method:.post, parameters: body).responseData { (response) in
            completion()
        }
    }
    
    static func getRequestCommentList(iboardIdx: Int, lastcontentsIdx: Int, completion: @escaping ([RequestComment]) -> Void) {
        let url: String = self.url(path: "/trequest/trequestcomment_view", parameters: iboardIdx, lastcontentsIdx)
        Alamofire.request(url, method:.get).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData = try self.decoder.decode(RequestServiceData.self, from: value)
                        completion(decodedData.data[0].request_comment_list!)
                    }
                    catch(let error) {
                        print("get request comment - Decode json data exception: \(error.localizedDescription), Detail: \(error.self)")
                    }
                }
                break
            case .failure(let error):
                print("GET failure to load comment data: \(error.localizedDescription)")
                break
            }
        }
    }
    
    static func getRequestList(completion: @escaping ([RequestData]) -> Void) {
        let url: String = self.url(path: "/trequest/trequest_listview", parameters: 0)
        Alamofire.request(url, method: .get).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData = try self.decoder.decode(RequestServiceData.self, from: value)
                        completion(decodedData.data[0].request_list!)
                    }
                    catch(let error) {
                        print("get request list - Decode json data exception: \(error.localizedDescription), Detail: \(error.self)")
                    }
                }
                break
            case .failure(let error):
                print("GET failure to load comment data: \(error.localizedDescription)")
                break
            }
        }
    }
    
    static func getRequestReplayCommentList(icmtIdx: Int, lastcontentsIdx: Int, completion: @escaping ([ReplayRequestComment]) -> Void) {
        let url: String = self.url(path: "/trequest/trequestrecomment_view", parameters: icmtIdx, lastcontentsIdx)
        Alamofire.request(url, method: .get).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData = try self.decoder.decode(RequestServiceData.self, from: value)
                        completion(decodedData.data[0].request_recomment_list!)
                    }
                    catch(let error) {
                        print("get request replay comment list - Decode json data exception: \(error.localizedDescription), Detail: \(error.self)")
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
