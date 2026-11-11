//
//  Journal.swift
//  Journal
//
//  Created by ghaida on 29/05/1448 AH.
//
import Foundation

struct Journal: Identifiable {
    let id = UUID()
    var title: String
    var content: String
    var date: Date
    var isBookmarked: Bool = false
}
extension Journal {
    static let mockData: [Journal] = [
        Journal(title: "First Day", content: "Started my journal today", date: Date()),
        Journal(title: "Trip", content: "We went to the beach", date: Date()),
        Journal(title: "Ideas", content: "New app idea", date: Date())
    ]
}
