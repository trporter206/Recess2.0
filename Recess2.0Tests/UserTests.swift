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
        club = Club(creator: p1, name: "Sport Club", description: "Test club", privateClub: false, preReqsNeeded: false, preReqs: "")
    }

    override func tearDown() {
        p1 = nil
        club = nil
    }

    func testAddRequest() throws {
        var p2 = User(name: "Alison Parker", city: "Seattle")
        XCTAssertEqual(0, p2.getRequestedClubs().count)
        XCTAssertNoThrow(try p2.addClubRequest(club: club), "no throws in this case")
        XCTAssertEqual(1, p2.getRequestedClubs().count)
    }
    
    func testRemoveRequest() throws {
        var p2 = User(name: "Alison Parker", city: "Seattle")
        XCTAssertEqual(0, p2.getRequestedClubs().count)
        XCTAssertNoThrow(try p2.addClubRequest(club: club), "no throws in this case")
        XCTAssertEqual(1, p2.getRequestedClubs().count)
        XCTAssertNoThrow(try p2.removeClubRequest(club: club), "no throws in this case")
        XCTAssertEqual(0, p2.getRequestedClubs().count)
    }
    
    func testAddToMeetUpHosted() {
        XCTAssertEqual(0, p1.getNumHostedMeets())
        p1.addToMeetUpHosted()
        XCTAssertEqual(1, p1.getNumHostedMeets())
        p1.addToMeetUpHosted()
        XCTAssertEqual(2, p1.getNumHostedMeets())
    }
    
    func testAddtoMeetUpsJoined() {
        XCTAssertEqual(0, p1.getNumJoinedMeets())
        p1.addToMeetUpsJoined()
        XCTAssertEqual(1, p1.getNumJoinedMeets())
        p1.addToMeetUpsJoined()
        XCTAssertEqual(2, p1.getNumJoinedMeets())
    }

}
