//
//  DataManager.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-09.
//

import Foundation

class DataManager: ObservableObject {
    @Published var clubs = [Club]()
    @Published var meetUps = [MeetUp]()
    @Published var users = [User]()
    @Published var currentUser = User(name: "Torri Porter", city: "Vancouver")
    
    init() {
        let u0 = User(name: "Torri Porter", city: "Vancouver")
        let u1 = User(name: "Alison Parker", city: "Seattle")
        let u2 = User(name: "John Smith", city: "Portland")
        var c0 = Club(creator: u0, name: "Sports Club", description: "Pick up games", privateClub: false, preReqsNeeded: false, preReqs: "")
        var c1 = Club(creator: u1, name: "Tennis Club", description: "classy tennis", privateClub: true, preReqsNeeded: false, preReqs: "")
        var c2 = Club(creator: u2, name: "Basketball Club", description: "street ball", privateClub: false, preReqsNeeded: true, preReqs: "email the creator")
        var m0 = MeetUp(host: u0, sport: "Soccer", about: "casual game", date: "saturday", gearNeeded: true)
        var m1 = MeetUp(host: u1, sport: "Tennis", about: "serious training", date: "Sunday", gearNeeded: true)
        var m2 = MeetUp(host: u2, sport: "Basketball", about: "street ball", date: "Next week", gearNeeded: false)
        clubs.append(c0)
        clubs.append(c1)
        clubs.append(c2)
        users.append(u0)
        users.append(u1)
        users.append(u2)
    }
    
    
    
}
