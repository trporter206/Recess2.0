//
//  Explore.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-20.
//

import SwiftUI

struct Explore: View {
    @EnvironmentObject var dM: DataManager
    @State private var currentList = "Clubs"
    var body: some View {
        NavigationStack {
            VStack {
                HStack (alignment: .center){
                    Text("Clubs")
                        .foregroundColor({currentList == "Clubs" ? .blue : .black}())
                        .onTapGesture {
                            currentList = "Clubs"
                            
                        }
                        .font(.title)
                        .padding([.trailing])
                    Text("Meet Ups")
                        .foregroundColor({currentList == "Meet Ups" ? .green : .black}())
                        .onTapGesture {
                            currentList = "Meet Ups"
                        }
                        .font(.title)
                        .padding([.leading])
                }
                Divider().padding([.leading, .trailing])
                ScrollView(.vertical) {
                    if currentList == "Clubs" {
                        ClubList()
                    } else {
                        MeetUpList()
                    }
                }
                Spacer()
            }
        }
    }
}

struct Explore_Previews: PreviewProvider {
    static var previews: some View {
        Explore().environmentObject(DataManager())
    }
}
