import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        ContentUnavailableView {
            Label {
                Text("Begin Your Journal")
                    .foregroundStyle(Theme.Colors.textAccent)
            } icon: {
                Image(Theme.Images.emptyState)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140)
            }
        } description: {
            Text("Craft your personal diary, tap the plus icon to begin")
        }
    }
}
   
