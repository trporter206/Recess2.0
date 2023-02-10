//
//  ClubDetail.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-09.
//

import SwiftUI

struct ClubDetail: View {
    @ObservedObject var dataManager: DataManager
    var club: Club
    
    var body: some View {
        VStack {
            Text(club.getName())
                .font(.title)
            Text(club.getDescription()).font(.subheadline)
            Text("Created by \(club.getCreator().getName())").padding()
            Text("Members: \(club.getMembers().count)")
        }
    }
}

struct ClubDetail_Previews: PreviewProvider {
    static var previews: some View {
        ClubDetail(dataManager: DataManager(), club: DataManager().clubs[0])
    }
}
