import SwiftUI

struct NewJournalView: View {

    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @State private var title: String
    @State private var content: String
    @State private var showDiscardDialog = false

    let journal: Journal?
    var onSave: (_ title: String, _ content: String) -> Void

    // MARK: - Init
    init(journal: Journal? = nil,
         onSave: @escaping (_ title: String, _ content: String) -> Void) {
        self.journal = journal
        self.onSave = onSave
        _title = State(initialValue: journal?.title ?? "")
        _content = State(initialValue: journal?.content ?? "")
    }

    // MARK: - Computed
    private var isSaveDisabled: Bool {
        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var hasChanges: Bool {
        if let journal {
            return title != journal.title || content != journal.content
        }
        return !title.isEmpty || !content.isEmpty
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: Theme.Spacing.small) {
                TextField("Title", text: $title)
                    .font(.title.bold())

                Text((journal?.date ?? Date()).formatted(date: .numeric, time: .omitted))
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
            .alert(
                "Are you sure you want to discard changes on this journal?",
                isPresented: $showDiscardDialog
            ) {
                Button("Discard Changes", role: .destructive) {
                    dismiss()
                }
                Button("Keep Editing", role: .cancel) { }
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
        if hasChanges {
            showDiscardDialog = true
        } else {
            dismiss()
        }
    }

    private func saveTapped() {
        onSave(title, content)
        dismiss()
    }
}

#Preview("New") {
    NewJournalView(onSave: { _, _ in })
        .preferredColorScheme(.dark)
}

#Preview("Edit") {
    NewJournalView(
        journal: Journal(title: "My Birthday", content: "Lorem ipsum dolor sit amet"),
        onSave: { _, _ in }
    )
    .preferredColorScheme(.dark)
}
