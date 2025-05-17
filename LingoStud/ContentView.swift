//
//  ContentView.swift
//  LingoStud
//
//  Created by Vladyslav Tarabunin on 17/05/2025.
//
import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("🧠 LingoSud")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)

                NavigationLink(destination: AddWordView()) {
                    MenuButtonLabel(title: "➕ Add Word", color: .blue)
                }

                NavigationLink(destination: DailyQuizView()) {
                    MenuButtonLabel(title: "🧪 Daily Test", color: .green)
                }

                NavigationLink(destination: WordListView()) {
                    MenuButtonLabel(title: "📚 Your Vocab", color: .orange)
                }

                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct MenuButtonLabel: View {
    var title: String
    var color: Color

    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color.opacity(0.15))
            .foregroundColor(color)
            .font(.title3.bold())
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(color.opacity(0.3), lineWidth: 1)
            )
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Word.self, inMemory: true)
    
}


