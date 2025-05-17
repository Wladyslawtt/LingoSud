//
//  LingoStudApp.swift
//  LingoStud
//
//  Created by Vladyslav Tarabunin on 17/05/2025.
//

import SwiftUI
import SwiftData

@main
struct MyLanguageApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView() // Use the ContentView with VStack and MenuButtonLabel
                .modelContainer(for: Word.self)
        }
    }
}

