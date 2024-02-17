//
//  LoadingAnimationViewModel.swift
//  Pan CredCard
//
//  Created by Michael Bressiani on 08/02/24.
//

import Foundation

protocol CardsViewModelProtocol: AnyObject {
    func successRequest()
    func errorRequest()
}

class LoadingAPIRequestViewModel {
    
    private var service = CardsService()
    public var cards: ListCards?
    weak var delegate: CardsViewModelProtocol?
    public var cardEmpty: Card = Card(id: 0, name: "", alias: "", credit: false, debit: false, number: "", codSec: "", image: "")
    
    public func fetchCardsMock() {
        service.getCardsMock { result in
            switch result {
            case .success(let success):
                self.cards = success
                self.delegate?.successRequest()
            case .failure(_):
                self.delegate?.errorRequest()
            }
        }
    }
    
    public func getListCards() -> [Card] {
        return cards?.cards ?? [cardEmpty]
    }
}
