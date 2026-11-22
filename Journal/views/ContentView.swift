import SwiftUI
import SwiftData
struct ContentView: View {

    // MARK: - Data
    @Environment(\.modelContext) private var modelContext
       @Query(sort: \Journal.date, order: .reverse) private var journals: [Journal]
       @State private var viewModel = JournalViewModel()

    // MARK: - UI State
    @State private var showNewJournal = false
    @State private var showDeleteAlert = false
    @State private var journalToDelete: Journal?
    @State private var journalToEdit: Journal?

    // MARK: - Body
    var body: some View {
        @Bindable var viewModel = viewModel

        NavigationStack {
            Group {
                if journals.isEmpty {
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
            NewJournalView { title, content in
                viewModel.addJournal(title: title, content: content, context: modelContext)
            }
        }
        .sheet(item: $journalToEdit) { journal in
            NewJournalView(journal: journal) { title, content in
                viewModel.updateJournal(journal, title: title, content: content)
            }
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
            ForEach(viewModel.filteredJournals(from: journals)) { journal in
                JournalCard(
                    journal: journal,
                    onBookmark: { viewModel.toggleBookmark(journal) }
                )
                .onTapGesture { editTapped(journal) }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        deleteTapped(journal)
                    } label: {
                        Image(systemName: Theme.Icons.trash)
                    }
                    .tint(Theme.Colors.destructive)
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }

    // MARK: - UI Actions
    
    private func editTapped(_ journal: Journal) {
        journalToEdit = journal
    }
    
    private func addTapped() {
        showNewJournal = true
    }

    private func deleteTapped(_ journal: Journal) {
        journalToDelete = journal
        showDeleteAlert = true
    }

    private func confirmDelete() {
        guard let journal = journalToDelete else { return }
        viewModel.deleteJournal(journal, context: modelContext)
        journalToDelete = nil
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Journal.self, inMemory: true)
}
