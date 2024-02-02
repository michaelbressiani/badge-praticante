//
//  CardsService.swift
//  Pan CredCard
//
//  Created by Michael Bressiani on 20/01/24.

import Foundation

class CardsService {
    
    func getCardsMock(completion: (Result<ListCards, Error>) -> Void) {
        if let url = Bundle.main.url(forResource: "Cards", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let listCards: ListCards = try JSONDecoder().decode(ListCards.self, from: data)
                completion(.success(listCards))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
