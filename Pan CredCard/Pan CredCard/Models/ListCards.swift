//
//  CredCard.swift
//  Pan CredCard
//
//  Created by Michael Bressiani on 20/01/24.

struct ListCards: Codable {
    let cards: [Card]
}

struct Card: Codable {
    let id: Int
    let name, alias: String
    let credit, debit: Bool
    let number, codSec, image: String
}
