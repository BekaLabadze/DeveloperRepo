//
//  KeyChainManager.swift
//  Assignmentest123
//
//  Created by Beka on 02.11.24.
//

import Foundation
import Security

class KeyChainManager {

    static func save(key: String, password: String) {
        guard let data = password.data(using: .utf8) else {
            return
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    static func load(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        guard status == errSecSuccess else {
            return nil
        }

        if let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }

        return nil
    }
}
