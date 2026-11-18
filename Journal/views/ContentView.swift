import SwiftUI

struct ContentView: View {

    // MARK: - Data
    @State private var viewModel: JournalViewModel

    // MARK: - UI State
    @State private var showNewJournal = false
    @State private var showDeleteAlert = false
    @State private var journalToDelete: Journal?

    // MARK: - Init
    init(journals: [Journal] = []) {
        _viewModel = State(initialValue: JournalViewModel(journals: journals))
    }

    // MARK: - Body
    var body: some View {
        @Bindable var viewModel = viewModel

        NavigationStack {
            Group {
                if viewModel.journals.isEmpty {
                    EmptyStateView()
                } else {
                    journalList
                }
            }
            .navigationTitle("Journal")
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $viewModel.selectedFilter) {
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
            NewJournalView(onSave: viewModel.addJournal)
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
            ForEach(viewModel.filteredJournals) { journal in
                JournalCard(
                    journal: journal,
                    onBookmark: { viewModel.toggleBookmark(journal) }
                )
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

    private func confirmDelete() {
        guard let journal = journalToDelete else { return }
        viewModel.deleteJournal(journal)
        journalToDelete = nil
    }
}

#Preview("With Journals") {
    ContentView(journals: Journal.mockData)
}

#Preview("Empty State") {
    ContentView()
}
