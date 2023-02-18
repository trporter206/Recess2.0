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
        club = Club(creator: p1, name: "Sports Club", description: "Test club", privateClub: false, preReqsNeeded: false, preReqs: "")
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
        XCTAssertNoThrow(try club.addMember(user: p2, accepted: true), "userNotFound is not thrown in this case")
        XCTAssertEqual(2, club.getMembers().count)
    }
    
    func testAddMemberFalse() {
        club.newRequest(user: p2)
        XCTAssertEqual(1, club.getRequests().count)
        XCTAssertNoThrow(try club.addMember(user: p2, accepted: false), "userNotFound is not thrown in this case")
        XCTAssertEqual(1, club.getMembers().count)
    }
    
    func testRemoveMember() {
        club.newRequest(user: p2)
        XCTAssertNoThrow(try club.addMember(user: p2, accepted: true), "userNotFound is not thrown in this case")
        XCTAssertEqual(2, club.getMembers().count)
        XCTAssertNoThrow(try club.removeMember(user: p2), "userNotInClub is not thrown in this case")
        XCTAssertEqual(1, club.getMembers().count)
    }
    
    func testNewRequest() {
        XCTAssertEqual(0, club.getRequests().count)
        club.newRequest(user: p2)
        XCTAssertEqual(1, club.getRequests().count)
    }
    
    func testRemoveRequest() {
        XCTAssertEqual(0, club.getRequests().count)
        club.newRequest(user: p2)
        XCTAssertEqual(1, club.getRequests().count)
        XCTAssertNoThrow(try club.removeRequest(user: p2), "userNotFound is not thrown in this case")
        XCTAssertEqual(0, club.getRequests().count)
    }

    func testAddMeetUp() {
        let mu = MeetUp(host: p1, sport: "test", about: "test", date: "test", gearNeeded: false)
        XCTAssertEqual(0, club.getScheduledGames().count)
        club.addMeetUp(meetUp: mu)
        XCTAssertEqual(1, club.getScheduledGames().count)
    }
    
    func testRemoveMeetUp() {
        let mu = MeetUp(host: p1, sport: "test", about: "test", date: "test", gearNeeded: false)
        XCTAssertEqual(0, club.getScheduledGames().count)
        club.addMeetUp(meetUp: mu)
        XCTAssertEqual(1, club.getScheduledGames().count)
        XCTAssertNoThrow(try club.removeMeetUp(meetUp: mu), "meetUpNotFound is not thrown in this case")
    }
}
