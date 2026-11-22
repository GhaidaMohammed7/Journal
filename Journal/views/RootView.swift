import SwiftUI
import SwiftData
struct RootView: View {

    // MARK: - UI State
    @State private var showSplash = true

    // MARK: - Body
    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
            } else {
                ContentView()
                    .transition(.opacity)
            }
        }
        .task {
            await splashFinished()
        }
    }

    // MARK: - Actions
    private func splashFinished() async {
        try? await Task.sleep(for: .seconds(2))
        withAnimation {
            showSplash = false
        }
    }
}

#Preview {
    RootView()
        .modelContainer(for: Journal.self, inMemory: true)
}
