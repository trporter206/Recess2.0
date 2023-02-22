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
    @Published var currentUser: User
    
    init() {
        var u0 = User(name: "Torri Porter", city: "Vancouver")
        u0.setWins(wins: 2)
        self.currentUser = u0
        var u1 = User(name: "Alison Parker", city: "Seattle")
        var u2 = User(name: "John Smith", city: "Portland")
        var c0 = Club(creator: u0, name: "Sports Club", description: "Pick up games", privateClub: false, preReqsNeeded: false)
        var c1 = Club(creator: u1, name: "Tennis Club", description: "classy tennis", privateClub: true, preReqsNeeded: false)
        var c2 = Club(creator: u2, name: "Basketball Club", description: "street ball", privateClub: false, preReqsNeeded: true, reqWins: 1)
        var m0 = MeetUp(host: u0, sport: "Soccer", about: "casual game", date: Date.now, gearNeeded: true, clubMeet: false)
        var m1 = MeetUp(host: u1, sport: "Tennis", about: "serious training", date: Date.now + 1500000, gearNeeded: true, clubMeet: false)
        var m2 = MeetUp(host: u2, sport: "Basketball", about: "street ball", date: Date.now + 2000000, gearNeeded: false, clubMeet: false)
        
        clubs.append(c0)
        clubs.append(c1)
        clubs.append(c2)
        users.append(u0)
        users.append(u1)
        users.append(u2)
        meetUps.append(m0)
        meetUps.append(m1)
        meetUps.append(m2)
        
        currentUser.addMeetUp(mu: m0)
        currentUser.addMeetUp(mu: m1)

    }
    
    //TODO: test
    //EFFECTS: return users sorted by Tier Ranking
    func rankByTier(users: Array<User>) -> Array<User> {
        return users.sorted(by: {$0.getTier() > $1.getTier()})
    }
    
    //TODO: test
    //EFFECTS: return a filtered list of meet ups based on param
    func filterMeetUpsBySport(meetUps: Array<MeetUp>, sport: String) -> Array<MeetUp> {
        return meetUps.filter({$0.getSport() == sport})
    }
    
    //TODO: test
    //EFFECTS: returns clubs sorted by size
    func sortClubsBySize(clubs: Array<Club>) -> Array<Club> {
        return clubs.sorted(by: {$0.getMembers().count > $1.getMembers().count})
    }
    
    //TODO: test
    //EFFECTS: returns meetups in order of date
    func sortMeetUpsByDate(meetUps: Array<MeetUp>) -> Array<MeetUp> {
        return meetUps.sorted(by: { $0.getDate().compare($1.getDate()) == .orderedAscending })
    }
}

