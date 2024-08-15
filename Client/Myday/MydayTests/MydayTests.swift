//
//  MydayTests.swift
//  MydayTests
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 14/9/2565 BE.
//

import XCTest
@testable import Myday

class MydayTests: XCTestCase {
    
    var rsa: RSA!

    override func setUp() {
        rsa = RSA()
    }
    
    override func tearDown() {
        rsa = nil
    }
    
    
//    func testEncyption() {
//        let resultBruteKeyEncypt = "Q58:N19:D196:"
//        XCTAssertEqual(resultBruteKeyEncypt, rsa.encryptData(text: "การ"))
//    }
//
//    func testDecyption() {
//        let resultRSADecypt = "การ"
//        XCTAssertEqual(resultRSADecypt, rsa.decryptData(text: "Q58:N19:D196:"))
//    }
    
    func testGenKey() {
        rsa.genKey()
        debugPrint("PublicKey")
        debugPrint("e:",rsa.getPublicKey().e)
        debugPrint("n:",rsa.getPublicKey().n)
        debugPrint("PrivateKey : ",rsa.getPrivateKey())
//        XCTAssertTrue(rsa.getPublicKey() != nil)
//        XCTAssertEqual(resultRSADecypt, rsa.decryptData(text: "Q58:N19:D196:"))
    }
    


}
