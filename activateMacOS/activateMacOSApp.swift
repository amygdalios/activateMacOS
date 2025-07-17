//
//  activateMacOSApp.swift
//  activateMacOS
//
//  Created by Alex Amygdalios on 17/7/25.
//

import SwiftUI

@main
struct ActivateMacOSOverlayApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {} // prevents a weird crash when no scene exists
    }
}
