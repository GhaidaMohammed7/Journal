import SwiftUI

struct ContentView: View {

    // MARK: - Data
    @State private var journals: [Journal]

    // MARK: - UI State
    @State private var showNewJournal = false
    @State private var showDeleteAlert = false
    @State private var journalToDelete: Journal?
    @State private var searchText = ""
    @State private var selectedFilter: JournalFilter = .all
    // MARK: - Init
    init(journals: [Journal] = []) {
        _journals = State(initialValue: journals)
    }
    // MARK: - Computed
   
    // MARK: - Computed

    private var filteredJournals: [Journal] {

        var result = journals

        // Search
        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
                || $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }

        // Filter
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
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Group {
                if journals.isEmpty {
                    EmptyStateView()
                } else {
                    journalList
                }
            }
            .navigationTitle("Journal")
            .searchable(text: $searchText, prompt: "Search")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {

                    Menu {
                        Picker("Filter", selection: $selectedFilter) {
                            ForEach(JournalFilter.allCases) { filter in
                                Text(filter.title)
                                    .tag(filter)
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }

                    Button(action: addTapped) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .tint(.white)
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showNewJournal) {
            NewJournalView(onSave: addJournal)
        }
        .alert("Delete Journal?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {
                journalToDelete = nil
            }
            Button("Delete", role: .destructive) {
                confirmDelete()
            }
        } message: {
            Text("Are you sure you want to delete this journal?")
        }
    }

    // MARK: - Subviews
    private var journalList: some View {
        List {
            ForEach(filteredJournals) { journal in
                JournalCard(journal: journal, onBookmark: { toggleBookmark(journal) })
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            deleteTapped(journal)
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                        .tint(Theme.Colors.destructive)
                    }
            }
        }
        .listStyle(.plain)
    }

    // MARK: - UI Actions

    private func addTapped() {
        showNewJournal = true
    }

    private func deleteTapped(_ journal: Journal) {
        journalToDelete = journal
        showDeleteAlert = true
    }

    // MARK: - Actions
    private func addJournal(title: String, content: String) {
        let journal = Journal(title: title, content: content, date: Date())
        journals.insert(journal, at: 0)
    }

    private func confirmDelete() {
        guard let journal = journalToDelete else { return }
        journals.removeAll { $0.id == journal.id }
        journalToDelete = nil
    }
    private func toggleBookmark(_ journal: Journal) {
        guard let index = journals.firstIndex(where: { $0.id == journal.id }) else { return }
        journals[index].isBookmarked.toggle()
    }
}

#Preview("With Journals") {
    ContentView(journals: Journal.mockData)
}

#Preview("Empty State") {
    ContentView()
}
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
