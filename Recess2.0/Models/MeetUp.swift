//
//  MeetUp.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-07.
//

import Foundation

struct MeetUp: Equatable, Hashable {
    private var id: String? = UUID().uuidString
    private var host: User
    private var sport: String
    private var about: String
    private var players: Array<User>
    private var date: Date
    private var gearNeeded: Bool
    
    init(id: String = UUID().uuidString, host: User, sport: String, about: String, date: Date, gearNeeded: Bool) {
        self.id = id
        self.host = host
        self.sport = sport
        self.about = about
        self.players = []
        self.date = date
        self.gearNeeded = gearNeeded
    }
    
    //METHODS==================================
    
    //MODIFIES: this
    //EFFECTS: adds given user to list of players
    mutating func addPlayer(user: User) {
        self.players.append(user)
    }
    
    //MODIFIES: this
    //EFFECTS: removes user from players
    mutating func removePlayer(user: User) throws {
        if !players.contains(where: {$0.getID() == user.getID()}) {
            throw RecessExceptions.userNotFound
        }
        self.players.removeAll{ $0.getID() == user.getID() }
    }
    
    //EFFECTS: for Hashability
    static func == (lhs: MeetUp, rhs: MeetUp) -> Bool {
            return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    //GETTERS==================================
    func getID() -> String { return self.id! }
    
    func getHost() -> User { return self.host }
    
    func getSport() -> String { return self.sport }
    
    func getAbout() -> String { return self.about }
    
    func getPlayers() -> Array<User> { return self.players }
    
    func getDate() -> Date { return self.date }
    
    func getGearNeeded() -> Bool { return self.gearNeeded }
    
    //SETTERS=====================================
    mutating func setHost(host: User) { self.host = host }
    
    mutating func setSport(sport: String) { self.sport = sport }
    
    mutating func setAbout(about: String) { self.about = about }
    
    mutating func setPlayers(players: Array<User>) { self.players = players }
    
    mutating func setDate(date: Date) { self.date = date }
    
    mutating func setGearNeeded(needed: Bool) { self.gearNeeded = needed }
}

extension MeetUp {
    struct Data {
        var sport: String = ""
        var about: String = ""
        var date: Date = Date.now
        var gearNeeded: Bool = false
    }
    
    mutating func update(from data: Data) {
        sport = data.sport
        about = data.about
        date = data.date
        gearNeeded = data.gearNeeded
    }
    
    init(data: Data, dataManager: DataManager) {
        host = dataManager.currentUser
        sport = data.sport
        about = data.about
        players = [dataManager.currentUser]
        date = data.date
        gearNeeded = data.gearNeeded
    }
}
