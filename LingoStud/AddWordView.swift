//
//  AddWordView.swift
//  LingoStud
//
//  Created by Vladyslav Tarabunin on 17/05/2025.
//

import SwiftUI
import SwiftData

struct AddWordView: View {
    @Environment(\.modelContext) private var context
    @State private var original = ""
    @State private var translation = ""
    @State private var showSavedMessage = false

    var body: some View {
        VStack(spacing: 20) {
            TextField("What we are learning", text: $original)
                .textFieldStyle(.roundedBorder)
                .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2) // Custom border color and thickness
                    )
                    .cornerRadius(10)
            TextField("Translation", text: $translation)
                .textFieldStyle(.roundedBorder)
                .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2) // Custom border color and thickness
                    )
                    .cornerRadius(10)
            Button("💾 Save Word") {
                addWord()
            }
            .buttonStyle(.borderedProminent)

            if showSavedMessage {
                Text("✅ Successfully Saved!")
                    .foregroundColor(.green)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Add a word")
    }

    private func addWord() {
        guard !original.trimmingCharacters(in: .whitespaces).isEmpty,
              !translation.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }

        let newWord = Word(original: original, translation: translation)
        context.insert(newWord)
        try? context.save()

        // איפוס השדות
        original = ""
        translation = ""
        showSavedMessage = true

        // הסתרה של ההודעה אחרי 2 שניות
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showSavedMessage = false
        }
    }
}

