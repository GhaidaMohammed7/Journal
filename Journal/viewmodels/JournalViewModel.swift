import Foundation
import SwiftData
import Observation

@Observable
class JournalViewModel {

    // MARK: - State
    var searchText = ""
    var selectedFilter: JournalFilter = .all

    // MARK: - Filtering (يستقبل القائمة من الـ View)
    func filteredJournals(from journals: [Journal]) -> [Journal] {
        var result = journals

        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
                || $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }

        switch selectedFilter {
        case .all:
            break
        case .date:
            result.sort { $0.date > $1.date }
        case .bookmarked:
            let bookmarked = result.filter { $0.isBookmarked }
            let others = result.filter { !$0.isBookmarked }
            result = bookmarked + others
        }

        return result
    }

    // MARK: - Actions
    func addJournal(title: String, content: String, context: ModelContext) {
        let journal = Journal(title: title, content: content)
        context.insert(journal)
    }

    func updateJournal(_ journal: Journal, title: String, content: String) {
        journal.title = title
        journal.content = content
    }

    func deleteJournal(_ journal: Journal, context: ModelContext) {
        context.delete(journal)
    }

    func toggleBookmark(_ journal: Journal) {
        journal.isBookmarked.toggle()
    }
}
