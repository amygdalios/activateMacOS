//
//  AppDelegate.swift
//  activateMacOS
//
//  Created by Alex Amygdalios on 17/7/25.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(_ notification: Notification) {
        showOverlay()
        setupMenuBarIcon()
    }

    func showOverlay() {
        let contentView = ContentView()
        let hostingView = NSHostingView(rootView: contentView)

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 320, height: 60),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )

        window.contentView = hostingView
        window.isOpaque = false
        window.backgroundColor = .clear
        window.hasShadow = false
        window.level = .floating
        window.ignoresMouseEvents = true
        window.collectionBehavior = [.canJoinAllSpaces, .stationary]

        // Bottom-right position
        if let screen = NSScreen.main {
            let screenRect = screen.visibleFrame
            let x = screenRect.maxX - 320 - 20
            let y = screenRect.minY + 20
            window.setFrameOrigin(NSPoint(x: x, y: y))
        }

        window.makeKeyAndOrderFront(nil)
    }

    func setupMenuBarIcon() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "apple.logo", accessibilityDescription: "Activate macOS")
            button.image?.isTemplate = true // Supports dark/light mode
        }

        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Quit Activate Overlay", action: #selector(quitApp), keyEquivalent: "q"))
        statusItem.menu = menu
    }

    @objc func quitApp() {
        NSApp.terminate(nil)
    }
}
