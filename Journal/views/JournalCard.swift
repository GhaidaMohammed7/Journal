import SwiftUI

struct JournalCard: View {

    // MARK: - Properties
    let journal: Journal

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.small) {
            header

            Text(journal.date.formatted(date: .numeric, time: .omitted))
                .font(.footnote)
                .foregroundStyle(.secondary)

            Text(journal.content)
                .font(.body)
                .lineLimit(4)
                .padding(.top, Theme.Spacing.small)
        }
        .padding(Theme.Spacing.large)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.Colors.surfaceCard)
        .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.card))
    }

    // MARK: - Subviews
    private var header: some View {
        LabeledContent {
            Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                .foregroundStyle(Theme.Colors.primaryAccent)
        } label: {
            Text(journal.title)
                .font(.title2.weight(.semibold))
                .foregroundStyle(Theme.Colors.textAccent)
        }
    }
    
}

#Preview {
    JournalCard(journal: Journal.mockData[0])
        .padding()
        .preferredColorScheme(.dark)
}
