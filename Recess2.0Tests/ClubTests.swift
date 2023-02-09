//
//  ClubTests.swift
//  Recess2.0Tests
//
//  Created by Torri Ray Porter Jr on 2023-02-07.
//

import XCTest
@testable import Recess2_0

final class ClubTests: XCTestCase {
    
    var club: Club!
    var p1: User!
    var p2: User!

    override func setUp() {
        p1 = User(name: "Torri Porter", city: "Vancouver")
        p2 = User(name: "Alison Parker", city: "Seattle")
        club = Club(creator: p1, name: "Sports Club", description: "Test club", privateClub: false)
    }

    override func tearDown() {
        p1 = nil
        p2 = nil
        club = nil
    }

    func testClubInit() {
        XCTAssertEqual("Torri Porter", club.getCreator().getName())
        XCTAssertEqual(1, club.getMembers().count)
        XCTAssertEqual(false, club.getPrivateClub())
        XCTAssertEqual("Sports Club", club.getName())
        XCTAssertEqual("Test club", club.getDescription())
        XCTAssertEqual(0, club.getScheduledGames().count)
    }
    
    func testAddMemberTrue() {
        club.newRequest(user: p2)
        XCTAssertEqual(1, club.getRequests().count)
        club.addMember(user: p2, accepted: true)
        XCTAssertEqual(2, club.getMembers().count)
    }
    
    func testAddMemberFalse() {
        club.newRequest(user: p2)
        XCTAssertEqual(1, club.getRequests().count)
        club.addMember(user: p2, accepted: false)
        XCTAssertEqual(1, club.getMembers().count)
    }
    
    func testRemoveMember() {
        club.newRequest(user: p2)
        club.addMember(user: p2, accepted: true)
        XCTAssertEqual(2, club.getMembers().count)
        club.removeMember(user: p2)
        XCTAssertEqual(1, club.getMembers().count)
    }
    
    func testNewRequest() {
        XCTAssertEqual(0, club.getRequests().count)
        club.newRequest(user: p2)
        XCTAssertEqual(1, club.getRequests().count)
    }


}