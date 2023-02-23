//
//  MeetUpTests.swift
//  Recess2.0Tests
//
//  Created by Torri Ray Porter Jr on 2023-02-08.
//

import XCTest
@testable import Recess2_0

final class MeetUpTests: XCTestCase {
    var mu: MeetUp!
    var p1: User!
    var p2: User!

    override func setUp() {
        p1 = User(name: "Torri", city: "Vancouver")
        p2 = User(name: "Alison", city: "Seattle")
        mu = MeetUp(host: p1, sport: "Basketball", about: "Pick up game", date: Date.now,  gearNeeded: true, clubMeet: false)
    }

    override func tearDown()  {
        p1 = nil
        p2 = nil
        mu = nil
    }
    
    func testAddPlayer(){
        XCTAssertEqual(0, mu.getPlayers().count)
        mu.addPlayer(user: p2)
        XCTAssertEqual(1, mu.getPlayers().count)
    }
    
    func testRemovePlayer(){
        XCTAssertEqual(0, mu.getPlayers().count)
        mu.addPlayer(user: p2)
        XCTAssertEqual(1, mu.getPlayers().count)
        XCTAssertNoThrow(try mu.removePlayer(user: p2), "no throws in this case")
        XCTAssertEqual(0, mu.getPlayers().count)
        
    }
    
    func testAddMeetUp() {
        XCTAssertEqual(0, p1.getScheduledMeetUps().count)
        let mu2 = MeetUp(host: p2, sport: "Tennis", about: "Tennis sessoon", date: Date.now, gearNeeded: true, clubMeet: false)
        p1.addMeetUp(mu: mu2)
        p1.addToMeetUpsJoined()
        XCTAssertEqual(1, p1.getScheduledMeetUps().count)
        XCTAssertEqual(1, p1.getNumJoinedMeets())
    }
    
    func testRemoveMeetUp() {
        let mu2 = MeetUp(host: p2, sport: "Tennis", about: "Tennis sessoon", date: Date.now, gearNeeded: true, clubMeet: false)
        XCTAssertEqual(0, p1.getScheduledMeetUps().count)
        p1.addMeetUp(mu: mu2)
        p1.addToMeetUpsJoined()
        XCTAssertEqual(1, p1.getScheduledMeetUps().count)
        XCTAssertNoThrow(try p1.removeMeetUp(mu: mu2), "no throws in this case")
        XCTAssertEqual(0, p1.getScheduledMeetUps().count)
    }

}
