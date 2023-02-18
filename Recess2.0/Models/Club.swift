//
//  Club.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-07.
//

import Foundation

struct Club: Identifiable {
    var id: String? = UUID().uuidString
    private var creator: User
    private var name: String
    private var description: String
    private var preReqs: String
    private var preReqsNeeded: Bool
    private var privateClub: Bool
    private var members: Array<User>
    private var requests: Array<User>
    private var scheduledGames: Array<MeetUp>
    
    init(id: String = UUID().uuidString, creator: User, name: String, description: String, privateClub: Bool, preReqsNeeded: Bool, preReqs: String) {
        self.id = id
        self.creator = creator
        self.name = name
        self.description = description
        self.preReqs = preReqs
        self.preReqsNeeded = preReqsNeeded
        self.privateClub = privateClub
        self.members = [creator]
        self.requests = []
        self.scheduledGames = []
    }
    
    //METHODS=================================
    
    //MODIFIES: this
    //EFFECTS: add given user to members if accepted, remove from requests either way
    mutating func addMember(user: User, accepted: Bool) throws {
        if !requests.contains(where: {$0.getID() == user.getID()}) {
            throw RecessExceptions.userNotFound
        }
        if accepted {
            self.members.append(user)
        }
        self.requests.removeAll{$0.getName() == user.getName()}
    }
    
    //MODIFIES: this
    //EFFECTS: remove player from members list
    mutating func removeMember(user: User) throws {
        if !members.contains(where: {$0.getID() == user.getID()}) {
            throw RecessExceptions.userNotInClub
        }
        self.members.removeAll{$0.getName() == user.getName()}
    }
    
    //MODIFIES: this
    //EFFECTS: add player to requests
    mutating func newRequest(user: User) {
        self.requests.append(user)
    }
    
    //MODIFIES: this
    //EFFECTS: remove player request
    mutating func removeRequest(user: User) throws {
        if !self.requests.contains(where: {$0.getID() == user.getID()}) {
            throw RecessExceptions.userNotFound
        }
        self.requests.removeAll(where: {$0.getID() == user.getID()})
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
    
    //SETTERS================================
    mutating func setCreator(creator: User) { self.creator = creator }
    
    mutating func setName(name: String) { self.name = name }
    
    mutating func setDescription(desc: String) { self.description = desc }
    
    mutating func setPreReqs(prqs: String) { self.preReqs = prqs }
    
    mutating func setPreReqsNeeded(needed: Bool) { self.preReqsNeeded = needed }
    
    mutating func setPrivateClub(prvt: Bool) { self.privateClub = prvt }
    
    mutating func setMembers(members: Array<User>) { self.members = members }
    
    mutating func setRequests(requests: Array<User>) { self.requests = requests }
    
    mutating func setScheduledGames(games: Array<MeetUp>) { self.scheduledGames = games }
    
    //GETTERS=================================
    func getCreator() -> User { return self.creator }
    
    func getName() -> String { return self.name }
    
    func getDescription() -> String { return self.description }
    
    func getPreReqs() -> String { return self.preReqs }
    
    func getPreReqsNeeded() -> Bool { return self.preReqsNeeded }
    
    func getPrivateClub() -> Bool { return self.privateClub }
    
    func getMembers() -> Array<User> { return self.members }
    
    func getRequests() -> Array<User> { return self.requests }
    
    func getScheduledGames() -> Array<MeetUp> { return self.scheduledGames }
}

extension Club {
    struct Data {
        var name: String = ""
        var description: String = ""
        var preReqs: String = ""
        var preReqsNeeded: Bool = false
        var privateClub: Bool = false
    }
    
    mutating func update(from data: Data) {
        name = data.name
        description = data.description
        preReqs = data.preReqs
        preReqsNeeded = data.preReqsNeeded
        privateClub = data.privateClub
    }
    
    init(data: Data, dataManager: DataManager) {
        creator = dataManager.currentUser
        name = data.name
        description = data.description
        preReqs = data.preReqs
        preReqsNeeded = data.preReqsNeeded
        privateClub = data.privateClub
        members = []
        requests = []
        scheduledGames = []
    }
}
