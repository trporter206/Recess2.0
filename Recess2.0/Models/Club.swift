//
//  Club.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-07.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Club: Identifiable, Hashable, Codable {
    var id: String
    private var creator: String
    private var name: String
    private var description: String
    private var preReqsNeeded: Bool
    private var reqHosted: Int
    private var reqJoined: Int
    private var reqTier: Int
    private var reqWins: Int
    private var privateClub: Bool
    private var members: Array<String>
    private var scheduledGames: Array<MeetUp>
    private var clubRef: DocumentReference
    
    init(id: String, creator: String, name: String, description: String, privateClub: Bool, preReqsNeeded: Bool, reqHosted: Int = 0, reqJoined: Int = 0, reqTier: Int = 0, reqWins: Int = 0) {
        self.id = id
        self.creator = creator
        self.members = [creator]
        self.name = name
        self.description = description
        self.reqTier = reqTier
        self.reqWins = reqWins
        self.reqHosted = reqHosted
        self.reqJoined = reqJoined
        self.preReqsNeeded = preReqsNeeded
        self.privateClub = privateClub
        self.scheduledGames = []
        self.clubRef = Firestore.firestore().collection("Clubs").document("\(id)")
    }
    
    //METHODS=================================
    
    //TODO: test
    //EFFECTS: return number of members
    func getMemberCount() -> Int {
        return self.members.count
    }
    
    //TODO: test
    //EFFECTS: determine if user meets reqs to join club
    func meetsReqs(user: User) -> Bool {
        if user.getTier() < self.reqTier {
            return false
        }
        if user.getWins() < self.reqWins {
            return false
        }
        if user.getNumJoinedMeets() < self.reqJoined {
            return false
        }
        if user.getNumHostedMeets() < self.reqHosted {
            return false
        }
        return true
    }
    
    //MODIFIES: this
    //EFFECTS: add given user to members if accepted, remove from requests either way
    mutating func addMember(user: User) throws {
        clubRef.updateData([
            "members" : FieldValue.arrayUnion(["\(user.getID())"])
        ])

    }
    
    //MODIFIES: this
    //EFFECTS: remove player from members list
    mutating func removeMember(userID: String) throws {
        if !members.contains(where: {$0 == userID}) {
            throw RecessExceptions.userNotInClub
        }
        self.members.removeAll{$0 == userID}
    }
    
    //MODIFIES: this
    //EFFECTS: add new meet up to scheduled
    mutating func addMeetUp(meetUp: MeetUp) {
        self.scheduledGames.append(meetUp)
    }
    
    //MODIFIES: this
    //EFFECTS: remove meet up from scheduled
    mutating func removeMeetUp(meetUp: MeetUp) throws {
        if !self.scheduledGames.contains(where: {$0.getID() == meetUp.getID()}) {
            throw RecessExceptions.meetUpNotFound
        }
        self.scheduledGames.removeAll(where: {$0.getID() == meetUp.getID()})
    }
    
    //EFFECTS: for Hashability
    static func == (lhs: Club, rhs: Club) -> Bool {
            return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    //SETTERS================================
    mutating func setCreator(creator: String) { self.creator = creator }
    
    mutating func setName(name: String) { self.name = name }
    
    mutating func setDescription(desc: String) { self.description = desc }
    
    mutating func setPreReqs(hosted: Int, joined: Int, wins: Int, tier: Int) {
        self.reqHosted = hosted
        self.reqJoined = joined
        self.reqWins = wins
        self.reqTier = tier
    }
    
    mutating func setPreReqsNeeded(needed: Bool) { self.preReqsNeeded = needed }
    
    mutating func setPrivateClub(prvt: Bool) { self.privateClub = prvt }
    
    mutating func setMembers(members: Array<String>) { self.members = members }
    
    mutating func setScheduledGames(games: Array<MeetUp>) { self.scheduledGames = games }
    
    //GETTERS=================================
    func getID() -> String { return self.id }
    
    func getCreator() async -> User {
        let creatorRef = Firestore.firestore().collection("Players")
        return try! await creatorRef.document(self.creator).getDocument(as: User.self)
    }
    
    func getName() -> String { return self.name }
    
    func getDescription() -> String { return self.description }
    
    func getReqHosted() -> Int { return self.reqHosted }
    
    func getReqJoined() -> Int { return self.reqJoined }
    
    func getReqTier() -> Int { return self.reqTier }
    
    func getReqWins() -> Int { return self.reqWins }
    
    func getPreReqsNeeded() -> Bool { return self.preReqsNeeded }
    
    func getPrivateClub() -> Bool { return self.privateClub }
    
    func getMembers() async -> Array<User> {
        var users = Array<User>()
        for memberID in members {
            let playerRef = Firestore.firestore().collection("Players")
            let player = try! await playerRef.document(memberID).getDocument(as: User.self)
            users.append(player)
        }
        return users
    }
    
    func getScheduledGames() -> Array<MeetUp> { return self.scheduledGames }
}

extension Club {
    struct Data {
        init(id: String){
            self.clubRef = Firestore.firestore().collection("Clubs").document("\(id)")
        }
        var clubRef: DocumentReference
        var name: String = ""
        var description: String = ""
        var reqHosted: Int = 0
        var reqJoined: Int = 0
        var reqTier: Int = 0
        var reqWins: Int = 0
        var preReqsNeeded: Bool = false
        var privateClub: Bool = false
    }
    
    mutating func update(from data: Data) {
        name = data.name
        description = data.description
        reqWins = data.reqWins
        reqTier = data.reqTier
        reqJoined = data.reqJoined
        reqHosted = data.reqHosted
        preReqsNeeded = data.preReqsNeeded
        privateClub = data.privateClub
    }
    
    init(data: Data, dataManager: DataManager) {
        id = UUID().uuidString
        creator = dataManager.currentUser.getID()
        name = data.name
        description = data.description
        reqWins = data.reqWins
        reqTier = data.reqTier
        reqJoined = data.reqJoined
        reqHosted = data.reqHosted
        preReqsNeeded = data.preReqsNeeded
        privateClub = data.privateClub
        members = []
        scheduledGames = []
        clubRef = data.clubRef
    }
}
