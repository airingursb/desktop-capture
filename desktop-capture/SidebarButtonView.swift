//
//  SidebarButtonView.swift
//  desktop-capture
//
//  Created by Airing on 2025/7/19.
//

import SwiftUI

struct SidebarButtonView: View {
    @State private var isHovered = false
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ZStack {
                // Simple rounded rectangle for testing
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray)
                    .frame(width: 30, height: 70)
                
                // Simple icon
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
            }
            .scaleEffect(isHovered ? 1.05 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: isHovered)
        }
        .buttonStyle(PlainButtonStyle())
        .onHover { hovering in
            isHovered = hovering
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red.opacity(0.3)) // Debug background
    }
}

struct DevonThinkTabShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        let cornerRadius: CGFloat = 8
        
        // Start from the right edge (screen edge)
        path.move(to: CGPoint(x: width, y: 0))
        
        // Right edge down
        path.addLine(to: CGPoint(x: width, y: height))
        
        // Bottom edge with rounded corner
        path.addLine(to: CGPoint(x: cornerRadius, y: height))
        
        // Bottom left corner
        path.addQuadCurve(
            to: CGPoint(x: 0, y: height - cornerRadius),
            control: CGPoint(x: 0, y: height)
        )
        
        // Left edge up
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        
        // Top left corner
        path.addQuadCurve(
            to: CGPoint(x: cornerRadius, y: 0),
            control: CGPoint(x: 0, y: 0)
        )
        
        // Top edge back to right
        path.addLine(to: CGPoint(x: width, y: 0))
        
        return path
    }
}

#Preview {
    SidebarButtonView {
        print("Bookmark tapped!")
    }
    .frame(width: 35, height: 80)
    .background(Color.gray.opacity(0.1))
}