//
//  ReadingNoteAPI.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/6/25.
//

import Foundation

class ReadingNoteAPI: BaseAPI {
    static let shared = ReadingNoteAPI()
    
    private override init() {
        super.init()
    }
    
    /// 책별 독서노트 조회
    func getReadingNote(isbn: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(
            ReadingNoteService.getReadingNote(isbn),
            interceptor: MyRequestInterceptor()
        ).responseData { (response) in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode
                else {
                    return
                }
                guard let data = response.data
                else {
                    return
                }
                completion(self.judgeData(by: statusCode, data, ReadingNoteResponse.self))
                
            case .failure(let err):
                completion(.networkFail(err.localizedDescription))
            }
        }
    }
}
