import SwiftUI

struct ContentView: View {

    @State private var showLogin = false
    @State private var showSignUp = false

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundView

                VStack(spacing: 36) {
                    Spacer(minLength: 10)

                    // Hero Card
                    HeroCard()
                        .padding(.horizontal, 24)

                    // Buttons
                    VStack(spacing: 16) {
                        PrimaryCTA(title: "Login", systemImage: "arrow.right.circle.fill") {
                            showLogin = true
                        }
                        .padding(.horizontal, 24)

                        SecondaryCTA(title: "Sign Up", systemImage: "person.badge.plus") {
                            showSignUp = true
                        }
                        .padding(.horizontal, 24)
                    }

                    Spacer()

                    // Hidden Navigation Links
                    NavigationLink(destination: LoginView(), isActive: $showLogin) { EmptyView() }
                    NavigationLink(destination: SignUpView(), isActive: $showSignUp) { EmptyView() }

                    // Footer
                    Text("Follow football matches live")
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.7))
                        .padding(.bottom, 12)
                }
                .padding(.vertical, 24)
            }
        }
    }

    private var backgroundView: some View {
        let gradient = LinearGradient(colors: [
            Color(red: 0.08, green: 0.08, blue: 0.12),
            Color(red: 0.05, green: 0.05, blue: 0.09),
            Color.black
        ], startPoint: .topLeading, endPoint: .bottomTrailing)
        let vignette = RadialGradient(colors: [Color.white.opacity(0.06), .clear], center: .topLeading, startRadius: 10, endRadius: 420)
        return ZStack {
            gradient.ignoresSafeArea()
            vignette.ignoresSafeArea()
        }
    }
}

// MARK: - Hero Card
private struct HeroCard: View {
    @State private var animate = false

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 26, style: .continuous)
        VStack(spacing: 18) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.06))
                    .frame(width: 110, height: 110)
                    .overlay(Circle().stroke(Color.white.opacity(0.12), lineWidth: 1))
                    .shadow(color: .black.opacity(0.4), radius: 16, x: 0, y: 12)
                    .scaleEffect(animate ? 1 : 0.98)
                    .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: animate)

                Image(systemName: "soccerball.inverse")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.white)
                    .font(.system(size: 48, weight: .semibold))
                    .rotationEffect(.degrees(animate ? 2 : -2))
                    .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: animate)
            }

            Text("GoalTracker")
                .font(.system(.largeTitle, design: .rounded).weight(.bold))
                .foregroundStyle(.white)

            Text("Your home for live scores, stats, and more")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.75))
        }
        .padding(24)
        .background(Color.white.opacity(0.06))
        .clipShape(shape)
        .overlay(shape.strokeBorder(Color.white.opacity(0.12), lineWidth: 1))
        .shadow(color: .black.opacity(0.35), radius: 18, x: 0, y: 14)
        .onAppear { animate = true }
    }
}

// MARK: - Buttons
private struct PrimaryCTA: View {
    let title: String
    let systemImage: String
    let action: () -> Void

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 16, style: .continuous)
        Button(action: action) {
            HStack {
                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .semibold))
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                LinearGradient(colors: [Color.white, Color.white.opacity(0.85)], startPoint: .top, endPoint: .bottom)
            )
            .foregroundStyle(.black)
            .clipShape(shape)
            .shadow(color: .black.opacity(0.35), radius: 10, x: 0, y: 8)
            .overlay(shape.strokeBorder(Color.white.opacity(0.2), lineWidth: 1))
        }
    }
}

private struct SecondaryCTA: View {
    let title: String
    let systemImage: String
    let action: () -> Void

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 16, style: .continuous)
        Button(action: action) {
            HStack {
                Image(systemName: systemImage)
                Text(title)
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color.white.opacity(0.10))
            .foregroundStyle(.white)
            .clipShape(shape)
            .overlay(shape.strokeBorder(Color.white.opacity(0.22), lineWidth: 1))
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
