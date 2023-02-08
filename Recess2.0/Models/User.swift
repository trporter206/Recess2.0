//
//  User.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-07.
//

import Foundation

struct User {
    var name: String
    var city: String
    var about: String
    var joinedClubs: Array<Club>
    var requestedClubs: Array<Club>
    var numHostedMeets: Int
    var numJoinedMeets: Int
    
    init(name: String, city: String) {
        self.name = name
        self.city = city
        self.about = ""
        self.joinedClubs = []
        self.requestedClubs = []
        self.numHostedMeets = 0
        self.numJoinedMeets = 0
    }
    
    //METHODS==========================
    
    //REQUIRES: club in joinRequests
    //MODIFIES: this
    //EFFECTS: remove club from requests
    mutating func removeClubRequest(club: Club) {
        self.requestedClubs.removeAll{$0.getName() == club.getName()}
    }
    
    //MODIFIES: this
    //EFFECTS: add club to requested
    mutating func addClubRequest(club: Club) {
        self.requestedClubs.append(club)
    }
    
    //MODIFIES: this
    //EFFECTS: if request is accepted, club added to clubs list
    mutating func joinClub(club: Club) {
        self.joinedClubs.append(club)
    }
    
    //MODIFIES: this
    //EFFECTS: if request is accepted, club added to clubs list
    mutating func leaveClub(club: Club) {
        self.joinedClubs.removeAll{$0.getName() == club.getName()}
    }
    
    //MODIFIES: this
    //EFFECTS: increment number of meet ups hosted
    mutating func addToMeetUpHosted() {
        
    }
    
    //MODIFIES: this
    //EFFECTS: increment number of meet ups joined
    mutating func addToMeetUpsJoined() {
        
    }
    
    //GETTERS==========================
    func getName() -> String { return self.name }
    
    func getCity() -> String { return self.city }
    
    func getAbout() -> String { return self.about }
    
    func getJoinedClubs() -> Array<Club> { return self.joinedClubs }
    
    func getRequestedClubs() -> Array<Club> { return self.requestedClubs }
    
    func getNumHostedMeets() -> Int { return self.numHostedMeets }
    
    func getNumJoinedMeets() -> Int { return self.numJoinedMeets }
    
    //SETTERS=====================================
    mutating func setName(name: String) { self.name = name }
    
    mutating func setCity(city: String) { self.city = city }
    
    mutating func setAbout(about: String) { self.about = about }
    
    mutating func setJoinedClubs(clubs: Array<Club>) { self.joinedClubs = clubs }
    
    mutating func setRequestedClubs(clubs: Array<Club>) {self.requestedClubs = clubs }
    
    mutating func setNumHostedMeets(num: Int) { self.numHostedMeets = num }
    
    mutating func setNumJoinedMeets(num: Int) { self.numJoinedMeets = num }
}
