//
//  EditWordView.swift.swift
//  LingoStud
//
//  Created by Vladyslav Tarabunin on 17/05/2025.
//

import SwiftUI
import SwiftData

struct EditWordView: View {
    @Bindable var word: Word
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Word")) {
                    TextField("Word", text: $word.original)
                }

                Section(header: Text("Translation")) {
                    TextField("Translation", text: $word.translation)
                }

                Section(header: Text("Number Of mistakes")) {
                    Stepper(value: $word.timesIncorrect, in: 0...100) {
                        Text("Mistakes: \(word.timesIncorrect)")
                    }
                }
            }
            .navigationTitle("Edit Word")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        try? context.save()
                        dismiss()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}
