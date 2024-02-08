//
//  ListCredCardsViewModel.swift
//  Pan CredCard
//
//  Created by Michael Bressiani on 20/01/24.

import UIKit

class ListCredCardsViewModel {
    
    private var service = CardsService()
    public var cards: ListCards?
    public var cardEmpty: Card = Card(id: 0, name: "", alias: "", credit: false, debit: false, number: "", codSec: "", image: "")
    
    public func numberOfRows(searching: Bool, searchCardName: [Card], listCards: [Card]) -> Int {
        
        if searching {
            return searchCardName.count
        } else {
            return listCards.count
        }
    }
    
    public func cardListFilterName(searchText: String, listCards: [Card]) -> [Card] {
        return listCards.filter({$0.name.prefix(searchText.count) == searchText })
    }
    
    public func cardFilterConfig(searching: Bool, searchCardName: [Card], listCards: [Card], indexPath: IndexPath) -> Card {
        
        if searching {
            return searchCardName[indexPath.row]
        } else {
            return listCards[indexPath.row]
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
    
    public func lastForDigits(cardNumber: String) -> String {
        return String(cardNumber.suffix(4))
    }
    
}
