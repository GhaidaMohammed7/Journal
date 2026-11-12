import SwiftUI

struct ContentView: View {

    // MARK: - Data
    @State private var journals: [Journal]

    // MARK: - UI State
    @State private var showNewJournal = false
    @State private var showDeleteAlert = false
    @State private var journalToDelete: Journal?

    // MARK: - Init
    init(journals: [Journal] = []) {
        _journals = State(initialValue: journals)
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
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: filterTapped) {
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
            ForEach(journals) { journal in
                JournalCard(journal: journal)
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
    private func filterTapped() {}

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
}

#Preview("With Journals") {
    ContentView(journals: Journal.mockData)
}

#Preview("Empty State") {
    ContentView()
}
