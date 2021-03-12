//
//  Todo_List_FireBaseApp.swift
//  Todo List FireBase
//
//  Created by Edivaldo Goncalves on 3/10/21.
//

import SwiftUI
import Firebase

@main
struct Todo_List_FireBaseApp: App {
  
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
}
