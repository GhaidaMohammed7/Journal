import SwiftUI

struct ContentView: View {
    @State private var journals: [Journal]

    init(journals: [Journal] = []) {
        _journals = State(initialValue: journals)
    }
    var body: some View {
        VStack(spacing: 0) {
            TopBar(title: "Journal", onFilter: filterTapped, onAdd: addTapped)

            if journals.isEmpty {
                EmptyStateView()
            } else {
                journalList
            }
        }
        .background(Theme.Colors.backgroundMain.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }

    private var journalList: some View {
        ScrollView {
            VStack(spacing: Theme.Spacing.medium) {
                ForEach(journals) { journal in
                    JournalCard(journal: journal)
                }
            }
            .padding(Theme.Spacing.large)
        }
    }

    private func filterTapped() {}

    private func addTapped() {}
}

struct JournalCard: View {
    let journal: Journal

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.small) {
            HStack {
                Text(journal.title)
                    .font(Theme.Fonts.titleCard)
                    .foregroundColor(Theme.Colors.textAccent)
                Spacer()
                Image(systemName: journal.isBookmarked ? Theme.Icons.bookmarkFilled : Theme.Icons.bookmark)
                    .foregroundColor(Theme.Colors.primaryAccent)
            }
            Text(journal.date.formatted(date: .numeric, time: .omitted))
                .font(Theme.Fonts.captionS)
                .foregroundColor(Theme.Colors.textSecondary)
            Text(journal.content)
                .font(Theme.Fonts.bodyM)
                .foregroundColor(Theme.Colors.textPrimary)
                .lineLimit(4)
        }
        .padding(Theme.Spacing.large)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.Colors.surfaceCard)
        .cornerRadius(Theme.Radius.card)
    }
}

#Preview {
    ContentView()
}
#Preview("With Journals") {
    ContentView(journals: Journal.mockData)
        .preferredColorScheme(.dark)
}

#Preview("Empty State") {
    ContentView()
        .preferredColorScheme(.dark)
}
