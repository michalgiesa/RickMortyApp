//
//  SecureStore.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import Foundation
import LocalAuthentication
import Security

struct SecureStore {
    struct Key: Hashable { let rawValue: String; init(_ v: String){ rawValue = v } }
    let service: String

    /// Zapisuje wartość do Keychain.
    /// - Parameters:
    /// - value: ciąg bajtów (String) do zapisania.
    /// - key: klucz elementu.
    /// - protectedWithBiometrics: gdy `true`, zastosuje `biometryCurrentSet` (wymaga kontekstu przy odczycie).
    func save(_ value: String, for key: Key, protectedWithBiometrics: Bool) throws {
        let data = Data(value.utf8)
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data
        ]
        if protectedWithBiometrics {
            let access = SecAccessControlCreateWithFlags(nil,
                kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                .biometryCurrentSet, nil)!
            query[kSecAttrAccessControl as String] = access
        } else {
            query[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        }
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw NSError(domain: NSOSStatusErrorDomain, code: Int(status)) }
    }

    /// Odczytuje wartość z Keychain.
    /// - Parameter key: klucz elementu.
    /// - Returns: Tekstowa wartość zapisana dla klucza.
    func read(_ key: Key) throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess, let data = item as? Data, let str = String(data: data, encoding: .utf8) else {
            throw NSError(domain: NSOSStatusErrorDomain, code: Int(status))
        }
        return str
    }

    /// Błędy HTTP zwracane przez klienta sieciowego.
    func delete(_ key: Key) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrService as String: service,
                                    kSecAttrAccount as String: key.rawValue]
        SecItemDelete(query as CFDictionary)
    }
}
