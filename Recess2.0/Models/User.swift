//
//  User.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-07.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Hashable, Identifiable, Codable {
    var id: String
    private var name: String
    private var city: String
    private var about: String
    private var joinedClubs: Array<String>
    private var createdClubs: Array<String>
    private var numHostedMeets: Int
    private var numJoinedMeets: Int
    private var scheduledMeetUps: Array<MeetUp>
    private var wins: Int
    private var losses: Int
    private var tier: Int
    private var userRef: DocumentReference
    
    init(id: String, name: String, city: String) {
        self.id = id
        self.name = name
        self.city = city
        self.about = ""
        self.joinedClubs = []
        self.createdClubs = []
        self.scheduledMeetUps = []
        self.numHostedMeets = 0
        self.numJoinedMeets = 0
        self.wins = 0
        self.losses = 0
        self.tier = 0
        self.userRef = Firestore.firestore().collection("Players").document(id)
    }
    
    //METHODS====================================
    
    //TODO: test
    //EFFECTS: return number of joined clubs
    func getNumJoinedClubs() -> Int {
        return self.joinedClubs.count
    }
    
    //TODO: test
    //EFFECTS: return number of created clubs
    func getNumCreatedClubs() -> Int {
        return self.createdClubs.count
    }
    
    //MODIFIES: this
    //EFFECTS: if request is accepted, club added to clubs list
    mutating func joinClub(club: Club) {
        userRef.updateData([
            "joinedClubs" : FieldValue.arrayUnion(["\(club.getID())"])
        ])
    }
    
    //MODIFIES: this
    //EFFECTS: remove club from currentClubs
    mutating func leaveClub(club: Club) throws {
        if !self.joinedClubs.contains(where: {$0 == club.getID()}) {
            throw RecessExceptions.clubNotFound
        }
        self.joinedClubs.removeAll{$0 == club.getID()}
    }
    
    //TODO: change doc name to ID when appropriate
    //MODIFIES: this
    //EFFECTS: increment number of meet ups joined
    mutating func addToMeetUpsJoined() {
        let userRef = Firestore.firestore().collection("Players").document(self.id)
        userRef.updateData([
            "numJoinedMeets" : FieldValue.increment(Int64(1))
        ])
    }
    
    //TODO: change doc name to ID when appropriate
    //MODIFIES: this
    //EFFECTS: increment number of meet ups hosted
    mutating func addToMeetUpHosted() {
        let userRef = Firestore.firestore().collection("Players").document(self.id)
        userRef.updateData([
            "numHostedMeets" : FieldValue.increment(Int64(1))
        ])
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
    
    //GETTERS======================================================================================
    func getID() -> String { return self.id }
    
    func getName() -> String { return self.name }
    
    func getCity() -> String { return self.city }
    
    func getAbout() -> String { return self.about }
    
    func getJoinedClubs() async -> Array<Club> {
        var clubData = Array<Club>()
        for clubID in self.joinedClubs {
            let clubRef = Firestore.firestore().collection("Clubs").document(clubID)
            let club = try! await clubRef.getDocument(as: Club.self)
            clubData.append(club)
        }
        return clubData
    }
    
    func getCreatedClubs() async -> Array<Club> {
        var clubData = Array<Club>()
        for clubID in self.createdClubs {
            let clubRef = Firestore.firestore().collection("Clubs").document(clubID)
            let club = try! await clubRef.getDocument(as: Club.self)
            clubData.append(club)
        }
        return clubData
    }
    
    func getNumHostedMeets() -> Int { return self.numHostedMeets }
    
    func getNumJoinedMeets() -> Int { return self.numJoinedMeets }
    
    func getScheduledMeetUps() -> Array<MeetUp> { return self.scheduledMeetUps }
    
    func getWins() -> Int { return self.wins }
    
    func getLosses() -> Int { return self.losses }
    
    func getTier() -> Int { return self.tier }
    
    func getUserRef() -> DocumentReference { return self.userRef }
    
    //SETTERS====================================
    mutating func setName(name: String) { self.name = name }
    
    mutating func setCity(city: String) { self.city = city }
    
    mutating func setAbout(about: String) { self.about = about }
    
    mutating func setJoinedClubs(clubs: Array<String>) { self.joinedClubs = clubs }
    
    mutating func setNumHostedMeets(num: Int) { self.numHostedMeets = num }
    
    mutating func setNumJoinedMeets(num: Int) { self.numJoinedMeets = num }
    
    mutating func setScheduledMeetUps(meetups: Array<MeetUp>) { self.scheduledMeetUps = meetups }
    
    mutating func setWins(wins: Int) { self.wins = wins }
    
    //HASHABILITY================================
    
    static func == (lhs: User, rhs: User) -> Bool {
            return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
