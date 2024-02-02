//
//  DetailsCardTests.swift
//  Pan CredCardTests
//
//  Created by Michael Bressiani on 27/01/24.
//

import XCTest
@testable import Pan_CredCard

final class DetailsCardTests: XCTestCase {
    
    var detailsCardViewModel: DetailsCardViewModel!
    var imageString: ImageString!
    
    override func setUpWithError() throws {
        detailsCardViewModel = DetailsCardViewModel()
        imageString = ImageString()
    }
    
    override func tearDownWithError() throws {
        detailsCardViewModel = nil
        imageString = nil
    }
    
    func testIsDebitOrCredit() throws {
        let trueAndTrueString = detailsCardViewModel.isDebitOrCredit(isDebit: true, isCredit: true)
        XCTAssertEqual(trueAndTrueString, "Débito e Crédito")
        let trueAndFalseString = detailsCardViewModel.isDebitOrCredit(isDebit: true, isCredit: false)
        XCTAssertEqual(trueAndFalseString, "Débito")
        let falseAndTrueString = detailsCardViewModel.isDebitOrCredit(isDebit: false, isCredit: true)
        XCTAssertEqual(falseAndTrueString, "Crédito")
        let falseAndFalseString = detailsCardViewModel.isDebitOrCredit(isDebit: false, isCredit: false)
        XCTAssertEqual(falseAndFalseString, "Nem débito nem crédito")
    }
    
    func testConvertBase64ToImage() throws {
        
        let base64Empty = ""
        let imageNilTest1 = detailsCardViewModel.convertBase64ToImage(base64String: base64Empty)
        XCTAssertEqual(imageNilTest1, UIImage())
        
        let base64InvalidNotEmpty = "Any non-empty string that does not match an image in base64"
        let imageNilTest2 = detailsCardViewModel.convertBase64ToImage(base64String: base64InvalidNotEmpty)
        XCTAssertEqual(imageNilTest2, UIImage())
        
        
        let imageBase64Valid = imageString.imageBase64Valid
        let imageNotNilTest = detailsCardViewModel.convertBase64ToImage(base64String: imageBase64Valid)
        XCTAssertNotEqual(imageNotNilTest, UIImage())
        XCTAssertTrue(imageNotNilTest.size.width > 0)
        XCTAssertTrue(imageNotNilTest.size.height > 0)
    }
}
