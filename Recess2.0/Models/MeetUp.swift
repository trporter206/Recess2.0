//
//  MeetUp.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-07.
//

import Foundation

struct MeetUp {
    var host: User
    var sport: String
    var about: String
    var players: Array<User>
    var date: String
    var gearNeeded: Bool
    
    init(host: User, sport: String, about: String, date: String, gearNeeded: Bool) {
        self.host = host
        self.sport = sport
        self.about = about
        self.players = []
        self.date = date
        self.gearNeeded = gearNeeded
    }
}
