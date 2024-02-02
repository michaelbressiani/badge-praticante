//
//  SecureStorageManager.swift
//  Pan CredCard
//
//  Created by Michael Bressiani on 22/01/24.
//

import Foundation
import Security

class SecureStorageCard {
    
    public func saveCardToKeychain(card: Card) {
        do {
            let encodedCard = try JSONEncoder().encode(card)
            
            let keychainQuery: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: "Pan CredCard",
                kSecAttrAccount as String: String(card.id),
                kSecValueData as String: encodedCard
            ]
            
            let status = SecItemAdd(keychainQuery as CFDictionary, nil)
            
            if status == errSecSuccess {
                print("Armazenamento do cartão no Keychain realizado com sucesso.")
            } else if status == errSecDuplicateItem {
                let updateQuery: [String: Any] = [
                    kSecValueData as String: encodedCard
                ]
                
                let updateStatus = SecItemUpdate(keychainQuery as CFDictionary, updateQuery as CFDictionary)
                
                if updateStatus == errSecSuccess {
                    print("Sucesso na atualização do cartão no Keychain.")
                }
            } else {
                print("Erro ao armazenar o cartão no Keychain. Código do erro: \(status)")
            }
        } catch {
            print("Erro ao codificar o cartão: \(error)")
        }
    }
}
