//
//  JournalFilter.swift
//  Journal
//
//  Created by ghaida on 06/06/1448 AH.
//

import Foundation
enum JournalFilter: String, CaseIterable, Identifiable {
    case all
    case date
    case bookmarked

    var id: Self { self }

    var title: String {
        switch self {
        case .all:
            return "All Entries"
        case .date:
            return "Entry Date"
        case .bookmarked:
            return "Bookmarked"
        }
    }
}
