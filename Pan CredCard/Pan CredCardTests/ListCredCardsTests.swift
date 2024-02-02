//
//  ListCredCardsTests.swift
//  Pan CredCardTests
//
//  Created by Michael Bressiani on 28/01/24.
//

import XCTest
@testable import Pan_CredCard

final class ListCredCardsTests: XCTestCase {
    
    var listCredCardsViewModel: ListCredCardsViewModel!
    var imageString: ImageString!
    var card: Card!
    var cardEmpty: Card!
    
    override func setUpWithError() throws {
        listCredCardsViewModel = ListCredCardsViewModel()
        imageString = ImageString()
        card = Card(id: 1, name: "Test" , alias: "Test", credit: true, debit: true, number: "1", codSec: "1", image: "1")
    }
    
    override func tearDownWithError() throws {
        listCredCardsViewModel = nil
        imageString = nil
        card = nil
        cardEmpty = nil
    }
    
    func testNumberOfRows() throws {
        
        listCredCardsViewModel.cards = ListCards(cards: [card])
        let numberOfRows = listCredCardsViewModel.numberOfRows()
        XCTAssertEqual(numberOfRows, 1)
        
        listCredCardsViewModel.cards = nil
        let numberOfRowsZero = listCredCardsViewModel.numberOfRows()
        XCTAssertEqual(numberOfRowsZero, 0)
    }
    
    func testGetCardList() throws {
        
        listCredCardsViewModel.cards = ListCards(cards: [card])
        let indexPath: IndexPath = IndexPath(item: 0, section: 0)
        let getCards = listCredCardsViewModel.getCardList(indexPath: indexPath)
        XCTAssertEqual(getCards.id, card.id)
        XCTAssertEqual(getCards.name, card.name)
        XCTAssertEqual(getCards.alias, card.alias)
        XCTAssertEqual(getCards.number, card.number)
        XCTAssertEqual(getCards.codSec, card.codSec)
        XCTAssertEqual(getCards.image, card.image)
        
        listCredCardsViewModel.cards = nil
        let getCardsNil = listCredCardsViewModel.getCardList(indexPath: indexPath)
        let cardEmpty = listCredCardsViewModel.cardEmpty
        XCTAssertEqual(getCardsNil.id, cardEmpty.id)
        XCTAssertEqual(getCardsNil.name, cardEmpty.name)
        XCTAssertEqual(getCardsNil.alias, cardEmpty.alias)
        XCTAssertEqual(getCardsNil.number, cardEmpty.number)
        XCTAssertEqual(getCardsNil.codSec, cardEmpty.codSec)
        XCTAssertEqual(getCardsNil.image, cardEmpty.image)
    }
    
    func testConvertBase64ToImage() throws {
        
        let base64Empty = ""
        let imageNilTest1 = listCredCardsViewModel.convertBase64ToImage(base64String: base64Empty)
        XCTAssertEqual(imageNilTest1, UIImage())
        
        let base64InvalidNotEmpty = "Any non-empty string that does not match an image in base64"
        let imageNilTest2 = listCredCardsViewModel.convertBase64ToImage(base64String: base64InvalidNotEmpty)
        XCTAssertEqual(imageNilTest2, UIImage())
        
        
        let imageBase64Valid = imageString.imageBase64Valid
        let imageNotNilTest = listCredCardsViewModel.convertBase64ToImage(base64String: imageBase64Valid)
        XCTAssertNotEqual(imageNotNilTest, UIImage())
        XCTAssertTrue(imageNotNilTest.size.width > 0)
        XCTAssertTrue(imageNotNilTest.size.height > 0)
    }
    
    func testLastForDigits() throws {
        let cardNumberTest = "5555 0000 1111 1234"
        let lastForDigitsTest = listCredCardsViewModel.lastForDigits(cardNumber: cardNumberTest)
        XCTAssertEqual(lastForDigitsTest, "1234")
    }
    
    func testInicializationCardEmpyt() throws {
        let cardEmpty = listCredCardsViewModel.cardEmpty
        XCTAssertEqual(cardEmpty.id, 0)
        XCTAssertEqual(cardEmpty.name, "")
        XCTAssertEqual(cardEmpty.alias, "")
        XCTAssertEqual(cardEmpty.number, "")
        XCTAssertEqual(cardEmpty.credit, false)
        XCTAssertEqual(cardEmpty.debit, false)
        XCTAssertEqual(cardEmpty.codSec, "")
        XCTAssertEqual(cardEmpty.image, "")
    }
}
