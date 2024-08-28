//
//  XAuthTokenService.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/19/24.
//

import Foundation
import Security

class KeyChain {
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
            print("Item not found")
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
        
        print("deleteItem Error : \(status.description)")
        return false
    }
    
    /// token용 함수
    func getToken() -> String? {
        KeyChain.shared.getItem(key: "xAuthToken") as? String
    }
    
    /// token용 addToken
    func addToken(token: String) -> Bool {
        KeyChain.shared.addItem(id: "xAuthToken", pwd: token)
    }
    
    func deleteToken() -> Bool {
        deleteItem(key: "xAuthToken")
    }
}
