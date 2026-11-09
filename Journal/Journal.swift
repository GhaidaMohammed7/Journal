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
