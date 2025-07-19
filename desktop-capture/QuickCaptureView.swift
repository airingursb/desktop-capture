//
//  QuickCaptureView.swift
//  desktop-capture
//
//  Created by Airing on 2025/7/19.
//

import SwiftUI

struct QuickCaptureView: View {
    @State private var name: String = "Automatic"
    @State private var content: String = ""
    @State private var url: String = ""
    @State private var selectedFormat: String = "Markdown"
    @State private var selectedLocation: String = "TikTok > Inbox"
    @State private var tags: [String] = []
    @State private var newTag: String = ""
    @State private var rating: Int = 0
    @State private var isAddingTag = false
    
    let formats = ["Markdown", "Plain Text", "Rich Text", "HTML"]
    let locations = ["TikTok > Inbox", "General > Notes", "Projects > Current"]
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with toolbar icons
            HStack {
                Button(action: {}) {
                    Image(systemName: "list.bullet")
                        .foregroundColor(.secondary)
                }
                
                Button(action: {}) {
                    Image(systemName: "equal")
                        .foregroundColor(.blue)
                }
                
                Button(action: {}) {
                    Image(systemName: "list.dash")
                        .foregroundColor(.secondary)
                }
                
                Button(action: {}) {
                    Image(systemName: "video")
                        .foregroundColor(.secondary)
                }
                
                Button(action: {}) {
                    Image(systemName: "desktopcomputer")
                        .foregroundColor(.secondary)
                }
                
                Button(action: {}) {
                    Image(systemName: "globe")
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color(NSColor.controlBackgroundColor))
            
            // Main content - wrap in ScrollView
            ScrollView {
                VStack(spacing: 12) {
                // Name field
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Name")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("Automatic")
                            .foregroundColor(.secondary)
                    }
                    
                    TextField("", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Body field
                VStack(alignment: .leading, spacing: 4) {
                    Text("Body")
                        .foregroundColor(.secondary)
                    
                    TextEditor(text: $content)
                        .frame(minHeight: 120)
                        .padding(4)
                        .background(Color(NSColor.textBackgroundColor))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                        )
                }
                
                // URL fields
                HStack(spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("URL")
                            .foregroundColor(.secondary)
                        TextField("", text: $url)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("URL")
                            .foregroundColor(.secondary)
                        TextField("", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                
                Divider()
                    .padding(.vertical, 4)
                
                // Info section with icons and rating
                HStack {
                    Text("Info")
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    HStack(spacing: 6) {
                        Image(systemName: "doc.text")
                            .foregroundColor(.secondary)
                        Image(systemName: "circle")
                            .foregroundColor(.secondary)
                        Image(systemName: "lock")
                            .foregroundColor(.secondary)
                        
                        // Star rating
                        HStack(spacing: 2) {
                            ForEach(1...5, id: \.self) { index in
                                Image(systemName: index <= rating ? "star.fill" : "star")
                                    .foregroundColor(index <= rating ? .yellow : .secondary)
                                    .onTapGesture {
                                        rating = index
                                    }
                            }
                        }
                        
                        Menu {
                            ForEach(formats, id: \.self) { format in
                                Button(format) {
                                    selectedFormat = format
                                }
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.secondary)
                        }
                        .menuStyle(BorderlessButtonMenuStyle())
                        .frame(width: 20)
                    }
                }
                
                // Tags section
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Tags")
                            .foregroundColor(.secondary)
                        Spacer()
                        Button(action: {
                            isAddingTag.toggle()
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .frame(width: 16, height: 16)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                        }
                    }
                    
                    // Show existing tags
                    if !tags.isEmpty {
                        FlowLayout(tags: tags) { tag in
                            TagView(tag: tag) {
                                removeTag(tag)
                            }
                        }
                    }
                    
                    // Tag input field
                    if isAddingTag {
                        HStack {
                            TextField("Enter tag", text: $newTag)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onSubmit {
                                    addTag()
                                }
                            
                            Button("Add") {
                                addTag()
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.small)
                            
                            Button("Cancel") {
                                cancelAddTag()
                            }
                            .buttonStyle(.bordered)
                            .controlSize(.small)
                        }
                    }
                }
                
                // Format selection
                HStack {
                    Text("Format")
                        .foregroundColor(.secondary)
                    Spacer()
                    
                    Menu(selectedFormat) {
                        ForEach(formats, id: \.self) { format in
                            Button(format) {
                                selectedFormat = format
                            }
                        }
                    }
                    .menuStyle(BorderlessButtonMenuStyle())
                    .frame(maxWidth: 120)
                }
                
                // Location selection
                HStack {
                    Text("Location")
                        .foregroundColor(.secondary)
                    Spacer()
                    
                    Menu(selectedLocation) {
                        ForEach(locations, id: \.self) { location in
                            Button(location) {
                                selectedLocation = location
                            }
                        }
                    }
                    .menuStyle(BorderlessButtonMenuStyle())
                    .frame(maxWidth: 160)
                }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            
            // Add button - fixed at bottom
            HStack {
                Spacer()
                Button("Add") {
                    addNote()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
            .background(Color(NSColor.windowBackgroundColor))
        }
        .frame(width: 400, height: 550)
        .background(Color(NSColor.windowBackgroundColor))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
    
    private func addNote() {
        print("Adding note:")
        print("Name: \(name)")
        print("Content: \(content)")
        print("URL: \(url)")
        print("Format: \(selectedFormat)")
        print("Location: \(selectedLocation)")
        print("Rating: \(rating)")
        
        // Clear form after adding
        content = ""
        url = ""
        name = "Automatic"
        rating = 0
        
        // Close popover after adding
        onClose()
    }
    
    private func addTag() {
        let trimmedTag = newTag.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedTag.isEmpty && !tags.contains(trimmedTag) {
            tags.append(trimmedTag)
        }
        newTag = ""
        isAddingTag = false
    }
    
    private func removeTag(_ tag: String) {
        tags.removeAll { $0 == tag }
    }
    
    private func cancelAddTag() {
        newTag = ""
        isAddingTag = false
    }
}

// Tag display component
struct TagView: View {
    let tag: String
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Text(tag)
                .font(.caption)
                .foregroundColor(.primary)
            
            Button(action: onDelete) {
                Image(systemName: "xmark")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.secondary)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.secondary.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// Flow layout for tags
struct FlowLayout: View {
    let tags: [String]
    let content: (String) -> TagView
    
    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(tags, id: \.self) { tag in
                content(tag)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > 350) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == tags.last {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if tag == tags.last {
                            height = 0
                        }
                        return result
                    })
            }
        }
    }
}

#Preview {
    QuickCaptureView {
        print("Close preview")
    }
}