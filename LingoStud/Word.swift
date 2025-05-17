//
//  Word.swift
//  LingoStud
//
//  Created by Vladyslav Tarabunin on 17/05/2025.
//

import Foundation
import SwiftData

@Model
class Word {
    var id: UUID
    var original: String
    var translation: String
    var timesIncorrect: Int
    var lastAsked: Date?

    init(original: String, translation: String) {
        self.id = UUID()
        self.original = original
        self.translation = translation
        self.timesIncorrect = 0
        self.lastAsked = nil
    }
}

