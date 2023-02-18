//
//  ClubListItem.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-18.
//

import SwiftUI

struct ClubListItem: View {
    @ObservedObject var dataManager: DataManager
    var club: Club
    
    var body: some View {
        NavigationLink(destination: ClubDetail(dataManager: dataManager, club: club), label: {
            VStack (alignment: .leading) {
                Text(club.getName())
                    .font(.title3)
                    .foregroundColor(.black)
                Text("Members: \(club.getMembers().count)")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            .padding()
        })
        .padding()
        .border(.black, width: 2)
    }
}

struct ClubListItem_Previews: PreviewProvider {
    static var previews: some View {
        ClubListItem(dataManager: DataManager(), club: DataManager().clubs[0])
    }
}
