import SwiftUI

struct EmptyStateView: View {

    // MARK: - Body

    var body: some View {
        VStack(spacing: Theme.Spacing.medium) {
            Image(Theme.Images.emptyState)
                .resizable()
                .scaledToFit()
                .frame(width: 180)

            Text("Begin Your Journal")
                .font(Theme.Fonts.emptyTitle)
                .foregroundColor(Theme.Colors.textAccent)

            Text("Craft your personal diary, tap the plus icon to begin")
                .font(Theme.Fonts.emptyBody)
                .foregroundColor(Theme.Colors.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Theme.Spacing.large * 3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView()
        .background(Theme.Colors.backgroundMain)
}
