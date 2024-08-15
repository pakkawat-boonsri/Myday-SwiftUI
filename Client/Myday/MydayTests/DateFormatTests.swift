//
//  DateFormatTests.swift
//  MydayTests
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 28/9/2565 BE.
//

import XCTest
@testable import Myday

final class DateFormatTests: XCTestCase {

    
    var format: DateFormat!

    override func setUp() {
        format = DateFormat()
    }
    
    override func tearDown() {
        format = nil
    }
    
    func testdateConvert() {
        let isoDate = "2022-09-28T10:44:00+0700"

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        
        let result = "28 ก.ย. 2022 Time 16:01 - 16:01"
        let data = format.dateConvert(startDate: date , endDate: Date())
//        XCTAssertEqual(result,data)
    }
    

}
