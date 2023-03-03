//
//  MeetUp.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-07.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MeetUp: Equatable, Hashable, Identifiable, Codable {
    var id: String
    private var host: String
    private var sport: String
    private var about: String
    private var players: Array<String>
    private var date: Date
    private var gearNeeded: Bool
    private var clubMeet: Bool
    private var hostClub: String?
    private var meetUpRef: DocumentReference
    
    init(id: String, host: String, sport: String, about: String, date: Date, gearNeeded: Bool, clubMeet: Bool, hostClub: String? = nil) {
        self.id = id
        self.host = host
        self.sport = sport
        self.about = about
        self.players = []
        self.date = date
        self.gearNeeded = gearNeeded
        self.clubMeet = clubMeet
        self.hostClub = hostClub
        self.meetUpRef = Firestore.firestore().collection("MeetUps").document(id)
    }
    
    //METHODS==================================
    
    //TODO: this
    //EFFECTS: return number of players
    func getNumPlayers() -> Int {
        return self.players.count
    }
    
    //MODIFIES: this
    //EFFECTS: adds given user to list of players
    mutating func addPlayer(user: User) {
        meetUpRef.updateData([
            "players" : FieldValue.arrayUnion(["\(user.getID())"])
        ])
    }
    
    //MODIFIES: this
    //EFFECTS: removes user from players
    mutating func removePlayer(userID: String) throws {
        if !players.contains(where: {$0 == userID}) {
            throw RecessExceptions.userNotFound
        }
        meetUpRef.updateData([
            "players" : FieldValue.arrayRemove([userID])
        ])
    }
    
    //EFFECTS: for Hashability
    static func == (lhs: MeetUp, rhs: MeetUp) -> Bool {
            return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    //GETTERS==================================
    func getID() -> String { return self.id }
    
    func getHost() async -> User {
        let hostRef = Firestore.firestore().collection("Players")
        return try! await hostRef.document(self.host).getDocument(as: User.self)
        
    }
    
    func getSport() -> String { return self.sport }
    
    func getAbout() -> String { return self.about }
    
    func getPlayers() async -> Array<User> {
        var users = Array<User>()
        for playerID in players {
            let playerRef = Firestore.firestore().collection("Players")
            let player = try! await playerRef.document(playerID).getDocument(as: User.self)
            users.append(player)
        }
        return users
    }
    
    func getDate() -> Date { return self.date }
    
    func getGearNeeded() -> Bool { return self.gearNeeded }
    
    func getClubMeet() -> Bool { return self.clubMeet }
    
    func getHostClub() async -> Club? {
        if self.hostClub == nil {
            return nil
        } else {
            let hostRef = Firestore.firestore().collection("Clubs").document(self.host)
            return try! await hostRef.getDocument(as: Club.self)
        }
    }
    
    //SETTERS=====================================
    mutating func setHost(host: String) { self.host = host }
    
    mutating func setSport(sport: String) { self.sport = sport }
    
    mutating func setAbout(about: String) { self.about = about }
    
    mutating func setPlayers(players: Array<String>) { self.players = players }
    
    mutating func setDate(date: Date) { self.date = date }
    
    mutating func setGearNeeded(needed: Bool) { self.gearNeeded = needed }
    
    mutating func setClubMeet(bool: Bool) { self.clubMeet = bool }
}

extension MeetUp {
    struct Data {
        var sport: String = ""
        var about: String = ""
        var date: Date = Date.now
        var gearNeeded: Bool = false
        var hostClub: String?
        var clubMeet: Bool = false
    }
    
    mutating func update(from data: Data) {
        sport = data.sport
        about = data.about
        date = data.date
        gearNeeded = data.gearNeeded
        hostClub = data.hostClub
        clubMeet = data.clubMeet
    }
    
    init(data: Data, dataManager: DataManager) {
        id = UUID().uuidString
        host = dataManager.currentUser.getID()
        sport = data.sport
        about = data.about
        players = [dataManager.currentUser.getID()]
        date = data.date
        gearNeeded = data.gearNeeded
        hostClub = data.hostClub
        clubMeet = data.clubMeet
        meetUpRef = Firestore.firestore().collection("MeetUps").document(id)
    }
}
