//
//  DetailsViewModel.swift
//  Pan CredCard
//
//  Created by Michael Bressiani on 22/01/24.

import UIKit

class DetailsCardViewModel {
    
    public func isDebitOrCredit(isDebit: Bool, isCredit: Bool) -> String {
        if isDebit && isCredit {
            return "Débito e Crédito"
        } else if isDebit {
            return "Débito"
        } else if isCredit {
            return "Crédito"
        } else {
            return "Nem débito nem crédito"
        }
    }
    
    public func convertBase64ToImage(base64String: String) -> UIImage {
        if let data = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            if let image = UIImage(data: data) {
                return image
            }
        }
        return UIImage()
    }
}
