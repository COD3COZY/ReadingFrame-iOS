//
//  TargetType.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/20/24.
//

import Foundation
import Alamofire

/// API 요청 과정 모듈화
protocol TargetType: URLRequestConvertible {
    var baseURL: String { get } // 기본 URL
    var method: HTTPMethod { get } // HTTP 메서드
    var path: String { get } // path
    var parameters: RequestParams { get } // 요청 파라미터
}

/// API 요청 시 parameter 정의
enum RequestParams {
    /// URL 쿼리
    case query(_ parameter: Encodable?)
    
    /// Body Parameter
    case body(_ parameter: Encodable?)
}

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionaryData = jsonData as? [String: Any] else { return [:] }
        return dictionaryData
    }
}

extension TargetType {
    var baseURL: String {
        return baseURL
    }
    
    // URLRequestConvertible 구현
    func asURLRequest() throws -> URLRequest {
        // url 설정
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        // 파라미터 설정
        switch parameters {
        case .query(let request):
            let params = request?.toDictionary() ?? [:]
            let queryParams = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        case .body(let request):
            let params = request?.toDictionary() ?? [:]
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        }

        return urlRequest
    }
}
