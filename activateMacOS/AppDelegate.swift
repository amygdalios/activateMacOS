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
    var yOffset: CGFloat = 60
    var xOffset: CGFloat = -20 // Negative values offset from RIGHT edge

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
            let x = screenRect.maxX - 320 - xOffset
            let y = screenRect.minY + yOffset
            window.setFrameOrigin(NSPoint(x: x, y: y))
        }

        window.makeKeyAndOrderFront(nil)
    }

    func setupMenuBarIcon() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "apple.logo", accessibilityDescription: "Activate macOS")
            button.image?.isTemplate = true
        }

        let menu = NSMenu()

        // === Y Offset Submenu ===
        let yMenu = NSMenu(title: "Vertical Position")
        [20, 40, 60, 80, 100].forEach { offset in
            let item = NSMenuItem(
                title: "\(offset) px from bottom",
                action: #selector(setYOffset(_:)),
                keyEquivalent: ""
            )
            item.tag = offset
            item.target = self
            yMenu.addItem(item)
        }

        let yMenuItem = NSMenuItem(title: "Vertical Position", action: nil, keyEquivalent: "")
        menu.setSubmenu(yMenu, for: yMenuItem)
        menu.addItem(yMenuItem)

        // === X Offset Submenu ===
        let xMenu = NSMenu(title: "Horizontal Position")
        if let screen = NSScreen.main {
            let screenWidth = screen.visibleFrame.width

            let xOffsets: [(String, CGFloat)] = [
                ("Left", -(screenWidth - 320 - 20)),
                ("Center", -(screenWidth / 2 - 160)),
                ("Right", -20),
                ("100 px from right", -100),
                ("200 px from right", -200)
            ]

            for (title, offset) in xOffsets {
                let item = NSMenuItem(title: title, action: #selector(setXOffset(_:)), keyEquivalent: "")
                item.representedObject = offset
                item.target = self
                xMenu.addItem(item)
            }
        }

        let xMenuItem = NSMenuItem(title: "Horizontal Position", action: nil, keyEquivalent: "")
        menu.setSubmenu(xMenu, for: xMenuItem)
        menu.addItem(xMenuItem)

        // === Quit ===
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit Activate Overlay", action: #selector(quitApp), keyEquivalent: "q"))

        statusItem.menu = menu
    }
    
    
    func repositionOverlay() {
        if let screen = NSScreen.main {
            let screenRect = screen.visibleFrame
            let x = screenRect.maxX - 320 + xOffset
            let y = screenRect.minY + yOffset
            window.setFrameOrigin(NSPoint(x: x, y: y))
        }
    }
    
    @objc func setYOffset(_ sender: NSMenuItem) {
        yOffset = CGFloat(sender.tag)
        repositionOverlay()
    }
    
    @objc func setXOffset(_ sender: NSMenuItem) {
        guard let offset = sender.representedObject as? CGFloat else { return }
        xOffset = offset
        repositionOverlay()
    }

    @objc func quitApp() {
        NSApp.terminate(nil)
    }
    
    
}
