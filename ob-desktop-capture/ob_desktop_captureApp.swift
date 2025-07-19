//
//  ob_desktop_captureApp.swift
//  ob-desktop-capture
//
//  Created by Airing on 2025/7/19.
//

import SwiftUI

@main
struct ob_desktop_captureApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
