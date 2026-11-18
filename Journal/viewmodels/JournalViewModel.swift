import SwiftUI
import Observation

@Observable
class JournalViewModel {

    // MARK: - Data
    var journals: [Journal]
    var searchText = ""
    var selectedFilter: JournalFilter = .all

    // MARK: - Init
    init(journals: [Journal] = []) {
        self.journals = journals
    }

    // MARK: - Computed
    var filteredJournals: [Journal] {
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
            result = result.filter { $0.isBookmarked }
        }

        return result
    }

    // MARK: - Actions
    func addJournal(title: String, content: String) {
        let journal = Journal(title: title, content: content, date: Date())
        journals.insert(journal, at: 0)
    }

    func deleteJournal(_ journal: Journal) {
        journals.removeAll { $0.id == journal.id }
    }
    func toggleBookmark(_ journal: Journal) {
        guard let index = journals.firstIndex(where: { $0.id == journal.id }) else { return }
        journals[index].isBookmarked.toggle()
    }

    func updateJournal(_ journal: Journal, title: String, content: String) {
        guard let index = journals.firstIndex(where: { $0.id == journal.id }) else { return }
        journals[index].title = title
        journals[index].content = content
    }
}   
