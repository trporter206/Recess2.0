//
//  UserTests.swift
//  Recess2.0Tests
//
//  Created by Torri Ray Porter Jr on 2023-02-08.
//

import XCTest
@testable import Recess2_0

final class UserTests: XCTestCase {
    var p1: User!
    var club: Club!

    override func setUp() {
        p1 = User(name: "Torri Porter", city: "Vancouver")
        club = Club(creator: p1, name: "Sport Club", description: "Test club", privateClub: false)
    }

    override func tearDown() {
        p1 = nil
        club = nil
    }

    func testAddRequest() throws {
        var p2 = User(name: "Alison Parker", city: "Seattle")
        XCTAssertEqual(0, p2.getRequestedClubs().count)
        p2.addClubRequest(club: club)
        XCTAssertEqual(1, p2.getRequestedClubs().count)
    }
    
    func testRemoveRequest() throws {
        var p2 = User(name: "Alison Parker", city: "Seattle")
        XCTAssertEqual(0, p2.getRequestedClubs().count)
        p2.addClubRequest(club: club)
        XCTAssertEqual(1, p2.getRequestedClubs().count)
        p2.removeClubRequest(club: club)
        XCTAssertEqual(0, p2.getRequestedClubs().count)
    }

}
