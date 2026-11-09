import SwiftUI

struct ContentView: View {
    @State private var journals: [Journal] = [
        Journal(title: "دوام الاثنين", content: "اليوم تعبانة بس الجو حلو", date: Date(), isBookmarked: true),
        Journal(title: "Today's Journal", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.", date: Date()),
        Journal(title: "Great Day", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.", date: Date())
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Theme.Spacing.medium) {
                    ForEach(journals) { journal in
                        JournalCard(journal: journal)
                    }
                }
                .padding(Theme.Spacing.large)
            }
            .background(Theme.Colors.backgroundMain)
            .navigationTitle("Journal")
        }
        .preferredColorScheme(.dark)
    }
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
