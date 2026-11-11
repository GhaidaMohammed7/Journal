import SwiftUI

struct TopBar: View {

    // MARK: - Properties

    let title: String
    let onFilter: () -> Void
    let onAdd: () -> Void

    // MARK: - Body

    var body: some View {
        HStack {
            Text(title)
                .font(Theme.Fonts.headingL)
                .foregroundColor(Theme.Colors.textPrimary)

            Spacer()

            actionsCapsule
        }
        .padding(.horizontal, Theme.Spacing.large)
        .padding(.vertical, Theme.Spacing.medium)
    }

    // MARK: - Subviews

    private var actionsCapsule: some View {
        HStack(spacing: Theme.Spacing.large) {
            Button(action: onFilter) {
                Image(systemName: Theme.Icons.filter)
            }

            Button(action: onAdd) {
                Image(systemName: Theme.Icons.plus)
            }
        }
        .font(.system(size: 17, weight: .semibold))
        .foregroundColor(.white)
        .padding(.horizontal, Theme.Spacing.large)
        .padding(.vertical, Theme.Spacing.medium)
        .background(Theme.Colors.surfaceCard)
        .clipShape(Capsule())
    }
}

// MARK: - Preview

#Preview {
    TopBar(title: "Journal", onFilter: {}, onAdd: {})
        .background(Theme.Colors.backgroundMain)
}
