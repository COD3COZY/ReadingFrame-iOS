//
//  XAuthTokenService.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/19/24.
//

import Foundation
import Security

class KeyChainService {
    /// 전역 키체인 객체
    static let shared = KeyChainService()
    
    /// 서비스 이름
    private let service = Bundle.main.bundleIdentifier
    
    private func addItem(id: Any, pwd: Any) -> Bool {
        let addQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                   kSecAttrAccount: id,
                                   kSecAttrService: service as Any,
                                     kSecValueData: (pwd as AnyObject).data(using: String.Encoding.utf8.rawValue) as Any]
        
        let result: Bool = {
            let status = SecItemAdd(addQuery as CFDictionary, nil)
            if status == errSecSuccess {
                return true
            } else if status == errSecDuplicateItem {
                return updateItem(value: pwd, key: id)
            }
            
            print("addItem Error : \(status.description))")
            return false
        }()
        
        return result
    }
    
    private func getItem(key: Any) -> Any? {
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                kSecAttrAccount: key,
                                kSecAttrService: service as Any,
                           kSecReturnAttributes: true,
                                 kSecReturnData: true]
        var item: CFTypeRef?
        let result = SecItemCopyMatching(query as CFDictionary, &item)
        
        // 잘 찾음
        if result == errSecSuccess {
            if let existingItem = item as? [String: Any],
               let data = existingItem[kSecValueData as String] as? Data,
               let password = String(data: data, encoding: .utf8) {
                return password
            }
            // 항목을 찾을 수 없는 경우
        } else if result == errSecItemNotFound {
            print("Item \'\(key)\' not found")
            return nil
            // 이외 오류
        } else {
            print("getItem Error : \(result.description)")
        }
        return nil
        
    }
    
    private func updateItem(value: Any, key: Any) -> Bool {
        let prevQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                    kSecAttrAccount: key]
        let updateQuery: [CFString: Any] = [kSecValueData: (value as AnyObject).data(using: String.Encoding.utf8.rawValue) as Any]
        
        let result: Bool = {
            let status = SecItemUpdate(prevQuery as CFDictionary, updateQuery as CFDictionary)
            if status == errSecSuccess { return true }
            
            print("updateItem Error : \(status.description)")
            return false
        }()
        
        return result
    }
    
    private func deleteItem(key: KeychainKeys) -> Bool {
        let deleteQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrAccount: key.rawValue]
        let status = SecItemDelete(deleteQuery as CFDictionary)
        if status == errSecSuccess { return true }
        
        print("deleteItem \'\(key.rawValue)\' Error : \(status.description)")
        return false
    }
    
}


// 키체인 존재하는 값 활용하는 부분들
extension KeyChainService {
    // MARK: xAuthToken
    /// xAuthToken get
    func getToken() -> String? {
        getItem(key: KeychainKeys.xAuthToken.rawValue) as? String
    }
    
    /// xAuthToken 추가
    func addToken(token: String) -> Bool {
        addItem(id: KeychainKeys.xAuthToken.rawValue, pwd: token)
    }
    
    /// xAuthToken 없애기
    func deleteToken() -> Bool {
        deleteItem(key: .xAuthToken)
    }
    
    // MARK: KeychainKeys 열거형 활용
    /// KeychainKeys enum 이용해서 value get
    func getKeychainItem(key: KeychainKeys) -> String? {
        getItem(key: key.rawValue) as? String
    }
    
    /// KeychainKeys enum 이용해서 추가
    func addKeychainItem(key: KeychainKeys, value: String) -> Bool {
        addItem(id: key.rawValue, pwd: value)
    }
    
    /// KeychainKeys enum 이용해서 delete
    func deleteKeychainItem(key: KeychainKeys) -> Bool {
        deleteItem(key: key)
    }
    
    /// 카카오 회원탈퇴
    func deleteKakaoAccount() -> Bool {
        if deleteItem(key: KeychainKeys.kakaoNickname) == false { return false }
        if deleteItem(key: KeychainKeys.kakaoEmail)  == false { return false }
        if deleteToken() == false { return false }
        
        return true
    }
    
    /// 애플 회원탈퇴
    func deleteAppleAccount() -> Bool {
        if deleteItem(key: KeychainKeys.appleUserID)  == false { return false }
        if deleteItem(key: KeychainKeys.appleIDToken)  == false { return false }
        if deleteItem(key: KeychainKeys.appleNickname) == false { return false }
        if deleteToken() == false { return false }
        
        return true
    }
}

/// 키체인에서 사용되는 key 모아서 관리
enum KeychainKeys: String {
    // 애플
    case appleUserID = "appleUserIdentifier"
    case appleIDToken = "appleIdentityToken"
    case appleNickname = "appleNickname"
    
    // 카카오
    case kakaoEmail = "kakaoEmail"
    case kakaoNickname = "kakaoNickname"
    
    // 자체토큰
    case xAuthToken = "xAuthToken"
}
