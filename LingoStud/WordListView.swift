//
//  WordListView.swift
//  LingoStud
//
//  Created by Vladyslav Tarabunin on 17/05/2025.
//

import SwiftUI
import SwiftData

struct WordListView: View {
    @Query private var words: [Word]
    @Environment(\.modelContext) private var context

    @State private var searchText = ""
    @State private var showOnlyIncorrect = false
    @State private var selectedWord: Word?
    @State private var isEditing = false

    var filteredWords: [Word] {
        words.filter { word in
            let matchesSearch = searchText.isEmpty ||
                word.original.localizedCaseInsensitiveContains(searchText) ||
                word.translation.localizedCaseInsensitiveContains(searchText)

            let matchesIncorrect = !showOnlyIncorrect || word.timesIncorrect > 0

            return matchesSearch && matchesIncorrect
        }
    }

    var body: some View {
        List {
            ForEach(filteredWords) { word in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("📝 \(word.original)")
                            .font(.headline)
                        Spacer()
                        Text("📖 \(word.translation)")
                            .foregroundColor(.secondary)
                    }

                    if word.timesIncorrect > 0 {
                        Text("❗ Mistakes: \(word.timesIncorrect)")
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    if let last = word.lastAsked {
                        Text("📅 Recent: \(last.formatted(date: .abbreviated, time: .shortened))")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Spacer()
                        Button("✏️ Edit") {
                            selectedWord = word
                            isEditing = true
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding(.vertical, 6)
            }
            .onDelete(perform: deleteWords)
        }
        .searchable(text: $searchText, prompt: "Search for a word")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Toggle("Incorrect", isOn: $showOnlyIncorrect)
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .navigationTitle("Word List")
        .sheet(item: $selectedWord) { word in
            EditWordView(word: word)
        }
    }

    private func deleteWords(at offsets: IndexSet) {
        for index in offsets {
            let word = filteredWords[index]
            context.delete(word)
        }
        try? context.save()
    }
}
