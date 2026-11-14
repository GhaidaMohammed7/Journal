import SwiftUI

struct SplashView: View {

    // MARK: - Body
    var body: some View {
        VStack(spacing: Theme.Spacing.medium) {
            Image(Theme.Images.splashLogo)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100)

            Text("Journali")
                .font(.largeTitle.weight(.black))

            Text("Your thoughts, your story")
                .font(.body.weight(.light))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
        .preferredColorScheme(.dark)
}

