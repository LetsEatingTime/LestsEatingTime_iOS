//
//  api.swift
//  LetsEatingTime
//
//  Created by 최시훈 on 2023/03/22.
//

import Foundation
import Alamofire

public let api = "https://let.team-alt.com/api"

func request<T: Decodable>(_ url: String,
                           _ method: HTTPMethod,
                           params: [String: Any]? = nil,
                           _ model: T.Type,
                           completion: @escaping (T) -> Void) {
    AF.request(url,
               method: method,
               parameters: params,
               encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
               interceptor: Interceptor()
    )
    .responseData { response in
        switch response.result {
        case .success:
            if let data = response.data {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                print(String(decoding: response.data!, as: UTF8.self))
                if let decodedData = try? decoder.decode(T.self, from: data) {
                    DispatchQueue.main.async {
                        completion(decodedData)
                    }
                }
            }
        case .failure(let error):
            print(error)
        }
    }
}
