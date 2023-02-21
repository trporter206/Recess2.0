//
//  CreateClubForm.swift
//  Recess2.0
//
//  Created by Torri Ray Porter Jr on 2023-02-09.
//

import SwiftUI
//TODO convert to club.data object to remove params
struct CreateClubForm: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var newClubData = Club.Data()
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Create club form")
            TextField("Club Name", text: $newClubData.name).padding()
            TextField("Club Description", text: $newClubData.description).padding()
            Toggle("Pre-reqs needed to join", isOn: $newClubData.preReqsNeeded).toggleStyle(.switch).padding()
            if newClubData.preReqsNeeded {
                TextField("Pre-reqs", text: $newClubData.preReqs).padding()
            }
            Toggle("Club is private", isOn: $newClubData.privateClub).toggleStyle(.switch).padding()
            Button(action: {
                let c = Club(creator: dataManager.currentUser,
                             name: newClubData.name,
                             description: newClubData.description,
                             privateClub: newClubData.privateClub,
                             preReqsNeeded: newClubData.preReqsNeeded,
                             preReqs: newClubData.preReqs)
                dataManager.clubs.append(c)
                showingAlert = true
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Create club")
            })
            .alert("Club Created", isPresented: $showingAlert) {
                Button("OK", role: .cancel){}
            }
        }
        .padding()
    }
}

struct CreateClubForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateClubForm().environmentObject(DataManager())
    }
}
