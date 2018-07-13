//
//  LoginService.swift
//  Bridge-iOS
//
//  Created by 김덕원 on 2018. 7. 12..
//  Copyright © 2018년 codevillain. All rights reserved.
//

import Foundation
import Alamofire

class LoginService: Network {
    
    static let decoder: JSONDecoder = {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        //2018-07-10T19:21:51.000Z
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    static func getMyRequests(userIdx: Int, completion: @escaping ([RequestData]) -> Void) {
        let url: String = self.url(path: "/user/getmytext", parameters: userIdx)
        Alamofire.request(url, method: .get).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData = try self.decoder.decode(RequestServiceData.self, from: value)
                        completion(decodedData.data[0].request_list!)
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
    
    static func postLogin(userUuid: String, userName: String, completion: @escaping (UserData) -> Void) {
        let url: String = self.url(path: "/user/login", parameters: nil)
        
        var loginType = 0
        if String(userUuid).count != 21 {
            loginType = 1
        }
        
        let body: [String: Any] = [
            "userUuid": userUuid,
            "userName": userName,
            "userType": loginType
        ]
        Alamofire.request(url, method:.post, parameters: body).responseData { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    do {
                        let decodedData = try self.decoder.decode(UserServiceData.self, from: value)
                        completion(decodedData.data[0])
                    }
                    catch(let error) {
                        print("postLogin - Decode json data exception: \(error.localizedDescription), Detail: \(error.self)")
                    }
                }
                break
            case .failure(let error):
                print("GET failure to load comment data: \(error.localizedDescription)")
                break
            }
        }
    }
    
    static func postQuitAccount(token: String, completion: @escaping () -> Void) {
        let url: String = self.url(path: "/user/quit", parameters: nil)
        
        let body: [String: Any] = [
            "token": token
        ]
        Alamofire.request(url, method:.post, parameters: body).responseData { (response) in
            completion()
        }
    }
}
