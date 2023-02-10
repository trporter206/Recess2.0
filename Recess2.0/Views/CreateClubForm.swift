//
//  CreateClubForm.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-09.
//

import SwiftUI
//TODO convert to club.data object to remove params
struct CreateClubForm: View {
    @ObservedObject var dataManager: DataManager
    @Binding var nameString: String
    @Binding var descString: String
    @Binding var preReqsNeeded: Bool
    @Binding var preReqs: String
    @Binding var privateClub: Bool
    
    var body: some View {
        VStack {
            Text("Create club form")
            TextField("Club Name", text: $nameString).padding()
            TextField("Club Description", text: $descString).padding()
            Toggle("Pre-reqs needed to join", isOn: $preReqsNeeded).toggleStyle(.switch).padding()
            if preReqsNeeded {
                TextField("Pre-reqs", text: $preReqs).padding()
            }
            Toggle("Club is private", isOn: $privateClub).toggleStyle(.switch).padding()
            Button(action: {
                let c = Club(creator: dataManager.currentUser,
                             name: nameString,
                             description: descString,
                             privateClub: privateClub,
                             preReqsNeeded: preReqsNeeded,
                             preReqs: preReqs)
                dataManager.clubs.append(c)
            }, label: {
                Text("Create club")
            })
        }
        .padding()
    }
}

struct CreateClubForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateClubForm(dataManager: DataManager(), nameString: .constant(""), descString: .constant(""), preReqsNeeded: .constant(false), preReqs: .constant(""), privateClub: .constant(false))
    }
}
