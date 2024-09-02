//
//  XAuthTokenService.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/19/24.
//

import Foundation
import Security

class KeyChain {
    /// 전역 키체인 객체
    static let shared = KeyChain()
    
    /// 서비스 이름
    private let service = Bundle.main.bundleIdentifier
    
    func addItem(id: Any, pwd: Any) -> Bool {
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
    
    func getItem(key: Any) -> Any? {
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
    
    func updateItem(value: Any, key: Any) -> Bool {
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
    
    func deleteItem(key: String) -> Bool {
        let deleteQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrAccount: key]
        let status = SecItemDelete(deleteQuery as CFDictionary)
        if status == errSecSuccess { return true }
        
        print("deleteItem \'\(key)\' Error : \(status.description)")
        return false
    }
    
}


// 키체인 존재하는 값 활용하는 부분들
extension KeyChain {
    // MARK: xAuthToken
    /// xAuthToken get
    func getToken() -> String? {
        KeyChain.shared.getItem(key: "xAuthToken") as? String
    }
    
    /// xAuthToken 추가
    func addToken(token: String) -> Bool {
        KeyChain.shared.addItem(id: "xAuthToken", pwd: token)
    }
    
    /// xAuthToken 없애기
    func deleteToken() -> Bool {
        KeyChain.shared.deleteItem(key: "xAuthToken")
    }
    
    // MARK: KeychainKeys 열거형 활용
    /// KeychainKeys enum 이용해서 value get
    func getKeychainItem(key: KeychainKeys) -> String? {
        KeyChain.shared.getItem(key: key.rawValue) as? String
    }
    
    /// KeychainKeys enum 이용해서 추가
    func addKeychainItem(key: KeychainKeys, value: String) -> Bool {
        KeyChain.shared.addItem(id: key.rawValue, pwd: value)
    }
    
    /// KeychainKeys enum 이용해서 delete
    func deleteKeychainItem(key: KeychainKeys) -> Bool {
        KeyChain.shared.deleteItem(key: key.rawValue)
    }
    
    /// 카카오 회원탈퇴
    func deleteKakaoAccount() -> Bool {
        if deleteItem(key: "kakaoNickname") == false { return false }
        if deleteItem(key: "kakaoEmail")  == false { return false }
        if deleteToken() == false { return false }
        
        return true
    }
    
    /// 애플 회원탈퇴
    func deleteAppleAccount() -> Bool {
        if deleteItem(key: "appleUserIdentifier")  == false { return false }
        if deleteItem(key: "appleIdentityToken")  == false { return false }
        if deleteItem(key: "appleNickname") == false { return false }
        if deleteToken() == false { return false }
        
        return true
    }
}

/// 키체인에서 사용되는 key 모아서 관리
enum KeychainKeys: String {
    // 애플
    case appleUserIdentifier = "appleUserIdentifier"
    case appleIdentityToken = "appleIdentityToken"
    case appleNickname = "appleNickname"
    
    // 카카오
    case kakaoEmail = "kakaoEmail"
    case kakaoNickname = "kakaoNickname"
}
