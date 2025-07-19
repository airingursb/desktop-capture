//
//  AppDelegate.swift
//  desktop-capture
//
//  Created by Airing on 2025/7/19.
//

import SwiftUI
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    private var sidebarWindow: NSWindow?
    private var popoverWindow: NSWindow?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupSidebarButton()
        setupPopoverWindow()
        setupScreenChangeNotifications()
        
        // Keep app running but hide from dock
        NSApp.setActivationPolicy(.accessory)
    }
    
    private func setupScreenChangeNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(screenParametersChanged),
            name: NSApplication.didChangeScreenParametersNotification,
            object: nil
        )
    }
    
    @objc private func screenParametersChanged() {
        updateSidebarPosition()
        updatePopoverPosition()
    }
    
    private func setupSidebarButton() {
        let buttonFrame = calculateSidebarFrame()
        
        sidebarWindow = NSWindow(
            contentRect: buttonFrame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        
        sidebarWindow?.isOpaque = false
        sidebarWindow?.backgroundColor = .clear
        sidebarWindow?.level = .statusBar
        sidebarWindow?.ignoresMouseEvents = false
        sidebarWindow?.collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]
        sidebarWindow?.hidesOnDeactivate = false
        sidebarWindow?.acceptsMouseMovedEvents = true
        sidebarWindow?.isReleasedWhenClosed = false
        
        let sidebarView = SidebarButtonView {
            self.togglePopover()
        }
        
        sidebarWindow?.contentViewController = NSHostingController(rootView: sidebarView)
        sidebarWindow?.makeKeyAndOrderFront(nil)
        
        print("Sidebar window created: \(sidebarWindow != nil)")
        print("Sidebar window visible: \(sidebarWindow?.isVisible ?? false)")
        print("Sidebar window frame: \(sidebarWindow?.frame ?? NSRect.zero)")
    }
    
    private func calculateSidebarFrame() -> NSRect {
        guard let screen = NSScreen.main else { 
            return NSRect(x: 0, y: 0, width: 35, height: 80) 
        }
        
        let screenFrame = screen.visibleFrame
        let buttonWidth: CGFloat = 35
        let buttonHeight: CGFloat = 80
        
        // Position at the right edge of the visible area
        let frame = NSRect(
            x: screenFrame.maxX - buttonWidth,
            y: screenFrame.midY - buttonHeight/2,
            width: buttonWidth,
            height: buttonHeight
        )
        
        print("Screen frame: \(screenFrame)")
        print("Sidebar frame: \(frame)")
        
        return frame
    }
    
    private func updateSidebarPosition() {
        let newFrame = calculateSidebarFrame()
        sidebarWindow?.setFrame(newFrame, display: true, animate: true)
    }
    
    private func setupPopoverWindow() {
        let popoverFrame = calculatePopoverFrame()
        
        popoverWindow = CustomWindow(
            contentRect: popoverFrame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        
        popoverWindow?.isOpaque = false
        popoverWindow?.backgroundColor = .clear
        popoverWindow?.level = .floating
        popoverWindow?.collectionBehavior = [.canJoinAllSpaces]
        popoverWindow?.hidesOnDeactivate = false
        popoverWindow?.contentViewController = NSHostingController(rootView: QuickCaptureView {
            self.hidePopover()
        })
    }
    
    private func calculatePopoverFrame() -> NSRect {
        let screenFrame = NSScreen.main?.frame ?? NSRect.zero
        let popoverSize = NSSize(width: 400, height: 550)
        return NSRect(
            x: screenFrame.maxX - popoverSize.width - 80,
            y: screenFrame.midY - popoverSize.height/2,
            width: popoverSize.width,
            height: popoverSize.height
        )
    }
    
    private func updatePopoverPosition() {
        let newFrame = calculatePopoverFrame()
        popoverWindow?.setFrame(newFrame, display: true, animate: true)
    }
    
    private func togglePopover() {
        guard let popoverWindow = popoverWindow else { return }
        
        if popoverWindow.isVisible {
            hidePopover()
        } else {
            showPopover()
        }
    }
    
    private func showPopover() {
        popoverWindow?.makeKeyAndOrderFront(nil)
        popoverWindow?.makeKey()
        NSApp.activate(ignoringOtherApps: true)
    }
    
    private func hidePopover() {
        popoverWindow?.orderOut(nil)
    }
}