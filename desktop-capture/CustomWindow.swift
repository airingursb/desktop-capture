//
//  CustomWindow.swift
//  desktop-capture
//
//  Created by Airing on 2025/7/19.
//

import AppKit

class CustomWindow: NSWindow {
    override var canBecomeKey: Bool {
        return true
    }
    
    override var canBecomeMain: Bool {
        return true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isOpaque = false
        self.backgroundColor = .clear
    }
}