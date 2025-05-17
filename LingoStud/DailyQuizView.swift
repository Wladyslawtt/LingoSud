//
//  DailyQuizView.swift
//  LingoStud
//
//  Created by Vladyslav Tarabunin on 17/05/2025.
//

import SwiftUI
import SwiftData

struct DailyQuizView: View {
    @Environment(\.modelContext) private var context
    @Query private var words: [Word]

    @State private var quizWords: [Word] = []
    @State private var currentIndex = 0
    @State private var userAnswer = ""
    @State private var showResult = false
    @State private var isCorrect = false

    var body: some View {
        VStack {
            if currentIndex < quizWords.count {
                Text("Translate: \(quizWords[currentIndex].original)")
                    .font(.title)

                TextField("Your translation", text: $userAnswer)
                    .textFieldStyle(.roundedBorder)

                Button("Check") {
                    checkAnswer()
                }
            } else {
                Text("Youre Finished!")
            }
        }
        .padding()
        .onAppear {
            generateQuiz()
        }
        .alert(isPresented: $showResult) {
            Alert(
                title: Text(isCorrect ? "RIGHT!" : "WRONG!"),
                message: Text(isCorrect ? "GOOD JOB!" : "The right one is: \(quizWords[currentIndex].translation)"),
                dismissButton: .default(Text("NEXT")) {
                    currentIndex += 1
                    userAnswer = ""
                }
            )
        }
    }

    func generateQuiz() {
        let incorrectWords = words.filter { $0.timesIncorrect > 0 }
        var selected = incorrectWords

        let remainingCount = 20 - selected.count
        if remainingCount > 0 {
            let others = words.filter { $0.timesIncorrect == 0 }.shuffled().prefix(remainingCount)
            selected += others
        }

        quizWords = selected.shuffled()
    }

    func checkAnswer() {
        let currentWord = quizWords[currentIndex]
        isCorrect = userAnswer.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == currentWord.translation.lowercased()

        if !isCorrect {
            currentWord.timesIncorrect += 1
        } else if currentWord.timesIncorrect > 0 {
            currentWord.timesIncorrect -= 1
        }

        currentWord.lastAsked = Date()
        try? context.save()
        showResult = true
    }
}
