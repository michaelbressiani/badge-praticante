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
    var cardSearch: [Card]!
    var listCard: [Card]!
    var cardEmpty: Card!
    
    override func setUpWithError() throws {
        listCredCardsViewModel = ListCredCardsViewModel()
        imageString = ImageString()
        cardSearch = [Card(id: 1, name: "Test" , alias: "Test", credit: true, debit: true, number: "1", codSec: "1", image: "1")]
        listCard = [Card(id: 1, name: "Test" , alias: "Test", credit: true, debit: true, number: "1", codSec: "1", image: "1"), Card(id: 2, name: "Test2" , alias: "Test2", credit: true, debit: true, number: "2", codSec: "2", image: "2")]
    }
    
    override func tearDownWithError() throws {
        listCredCardsViewModel = nil
        imageString = nil
        cardSearch = nil
        listCard = nil
        cardEmpty = nil
    }
    
    func testNumberOfRows() throws {
        
        let numberOfRowsTestTrue = listCredCardsViewModel.numberOfRows(searching: true, searchCardName: cardSearch, listCards: listCard)
        XCTAssertEqual(numberOfRowsTestTrue, 1)
        
        let numberOfRowsTestFalse = listCredCardsViewModel.numberOfRows(searching: false, searchCardName: cardSearch, listCards: listCard)
        XCTAssertEqual(numberOfRowsTestFalse, 2)

    }
    
    func testCardListFilterName() throws {
        
       let searchText = "Test2"
       let listFilterCards = listCredCardsViewModel.cardListFilterName(searchText: searchText, listCards: listCard)
        XCTAssertEqual(listFilterCards[0].id, listCard[1].id)
        XCTAssertEqual(listFilterCards[0].name, listCard[1].name)
        XCTAssertEqual(listFilterCards[0].alias, listCard[1].alias)
        XCTAssertEqual(listFilterCards[0].number, listCard[1].number)
        XCTAssertEqual(listFilterCards[0].credit, listCard[1].credit)
        XCTAssertEqual(listFilterCards[0].debit, listCard[1].debit)
        XCTAssertEqual(listFilterCards[0].codSec, listCard[1].codSec)
        XCTAssertEqual(listFilterCards[0].image, listCard[1].image)
    }
    
    func testCardFilterConfig() throws {
        let indexPath = IndexPath(item: 0, section: 0)
        
        let cardFilterConfigTestTrue = listCredCardsViewModel.cardFilterConfig(searching: true, searchCardName: cardSearch, listCards: listCard, indexPath: indexPath)
        
        XCTAssertEqual(cardFilterConfigTestTrue.id, cardSearch[indexPath.row].id)
        XCTAssertEqual(cardFilterConfigTestTrue.name, cardSearch[indexPath.row].name)
        XCTAssertEqual(cardFilterConfigTestTrue.alias, cardSearch[indexPath.row].alias)
        XCTAssertEqual(cardFilterConfigTestTrue.number, cardSearch[indexPath.row].number)
        XCTAssertEqual(cardFilterConfigTestTrue.credit, cardSearch[indexPath.row].credit)
        XCTAssertEqual(cardFilterConfigTestTrue.debit, cardSearch[indexPath.row].debit)
        XCTAssertEqual(cardFilterConfigTestTrue.codSec, cardSearch[indexPath.row].codSec)
        XCTAssertEqual(cardFilterConfigTestTrue.image, cardSearch[indexPath.row].image)
        
        let cardFilterConfigTestFalse = listCredCardsViewModel.cardFilterConfig(searching: false, searchCardName: cardSearch, listCards: listCard, indexPath: indexPath)
        
        XCTAssertEqual(cardFilterConfigTestFalse.id, listCard[indexPath.row].id)
        XCTAssertEqual(cardFilterConfigTestFalse.name, listCard[indexPath.row].name)
        XCTAssertEqual(cardFilterConfigTestFalse.alias, listCard[indexPath.row].alias)
        XCTAssertEqual(cardFilterConfigTestFalse.number, listCard[indexPath.row].number)
        XCTAssertEqual(cardFilterConfigTestFalse.credit, listCard[indexPath.row].credit)
        XCTAssertEqual(cardFilterConfigTestFalse.debit, listCard[indexPath.row].debit)
        XCTAssertEqual(cardFilterConfigTestFalse.codSec, listCard[indexPath.row].codSec)
        XCTAssertEqual(cardFilterConfigTestFalse.image, listCard[indexPath.row].image)
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
