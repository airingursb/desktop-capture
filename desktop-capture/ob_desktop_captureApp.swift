//
//  ob_desktop_captureApp.swift
//  desktop-capture
//
//  Created by Airing on 2025/7/19.
//

import SwiftUI

@main
struct ob_desktop_captureApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
