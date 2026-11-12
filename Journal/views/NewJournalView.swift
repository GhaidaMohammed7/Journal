import SwiftUI

struct NewJournalView: View {

    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var content = ""

    var onSave: (_ title: String, _ content: String) -> Void

    // MARK: - Computed
    private var isSaveDisabled: Bool {
        title.trimmingCharacters(in: .whitespaces).isEmpty
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: Theme.Spacing.small) {
                TextField("Title", text: $title)
                    .font(.title.bold())

                Text(Date().formatted(date: .numeric, time: .omitted))
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                contentEditor
                    .padding(.top, Theme.Spacing.medium)
            }
            .padding(.horizontal, Theme.Spacing.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: cancelTapped) {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: saveTapped) {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.circle)
                    .tint(Theme.Colors.primaryAccent)
                    .disabled(isSaveDisabled)
                }
            }
        }
    }

    // MARK: - Subviews
    private var contentEditor: some View {
        ZStack(alignment: .topLeading) {
            if content.isEmpty {
                Text("Type your Journal...")
                    .foregroundStyle(.secondary)
                    .padding(.top, 8)
                    .padding(.leading, 5)
            }
            TextEditor(text: $content)
                .scrollContentBackground(.hidden)
        }
        .font(.body)
    }

    // MARK: - Actions
    private func cancelTapped() {
        dismiss()
    }

    private func saveTapped() {
        onSave(title, content)
        dismiss()
    }
}

#Preview {
    NewJournalView(onSave: { _, _ in })
        .preferredColorScheme(.dark)
}
