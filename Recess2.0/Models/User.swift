//
//  User.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-07.
//

import Foundation

struct User: Hashable, Identifiable {
    var id: String
    private var name: String
    private var city: String
    private var about: String
    private var joinedClubs: Array<Club>
    private var numHostedMeets: Int
    private var numJoinedMeets: Int
    private var scheduledMeetUps: Array<MeetUp>
    private var wins: Int
    private var losses: Int
    private var tier: Int
    
    init(id: String = UUID().uuidString, name: String, city: String) {
        self.id = id
        self.name = name
        self.city = city
        self.about = ""
        self.joinedClubs = []
        self.scheduledMeetUps = []
        self.numHostedMeets = 0
        self.numJoinedMeets = 0
        self.wins = 0
        self.losses = 0
        self.tier = 0
    }
    
    //METHODS==========================
    
    //MODIFIES: this
    //EFFECTS: if request is accepted, club added to clubs list
    mutating func joinClub(club: Club) {
        self.joinedClubs.append(club)
    }
    
    //MODIFIES: this
    //EFFECTS: remove club from currentClubs
    mutating func leaveClub(club: Club) throws {
        if !self.joinedClubs.contains(where: {$0.getName() == club.getName()}) {
            throw RecessExceptions.clubNotFound
        }
        self.joinedClubs.removeAll{$0.getName() == club.getName()}
    }
    
    //MODIFIES: this
    //EFFECTS: increment number of meet ups joined
    mutating func addToMeetUpsJoined() {
        self.numJoinedMeets += 1
    }
    
    //MODIFIES: this
    //EFFECTS: increment number of meet ups hosted
    mutating func addToMeetUpHosted() {
        self.numHostedMeets += 1
    }
    
    //MODIFIES: this
    //EFFECTS: remove meet up from scheduled
    mutating func removeMeetUp(mu: MeetUp) throws {
        if !self.scheduledMeetUps.contains(where: {$0.getID() == mu.getID()}) {
            throw RecessExceptions.meetUpNotFound
        }
        self.scheduledMeetUps.removeAll{$0 == mu}
    }
    
    //MODIFIES: this
    //EFFECTS: add meet up to scheduled
    mutating func addMeetUp(mu: MeetUp) {
        self.scheduledMeetUps.append(mu)
    }
    
    //EFFECTS: for Hashability
    static func == (lhs: User, rhs: User) -> Bool {
            return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    //GETTERS==========================
    func getID() -> String { return self.id }
    
    func getName() -> String { return self.name }
    
    func getCity() -> String { return self.city }
    
    func getAbout() -> String { return self.about }
    
    func getJoinedClubs() -> Array<Club> { return self.joinedClubs }
    
    func getNumHostedMeets() -> Int { return self.numHostedMeets }
    
    func getNumJoinedMeets() -> Int { return self.numJoinedMeets }
    
    func getScheduledMeetUps() -> Array<MeetUp> { return self.scheduledMeetUps }
    
    func getWins() -> Int { return self.wins }
    
    func getLosses() -> Int { return self.losses }
    
    func getTier() -> Int { return self.tier }
    
    //SETTERS=====================================
    mutating func setName(name: String) { self.name = name }
    
    mutating func setCity(city: String) { self.city = city }
    
    mutating func setAbout(about: String) { self.about = about }
    
    mutating func setJoinedClubs(clubs: Array<Club>) { self.joinedClubs = clubs }
    
    mutating func setNumHostedMeets(num: Int) { self.numHostedMeets = num }
    
    mutating func setNumJoinedMeets(num: Int) { self.numJoinedMeets = num }
    
    mutating func setScheduledMeetUps(meetups: Array<MeetUp>) { self.scheduledMeetUps = meetups }
    
    mutating func setWins(wins: Int) { self.wins = wins }
}
