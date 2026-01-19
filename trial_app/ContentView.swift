import SwiftUI

struct ContentView: View {

    @State private var showLogin = false
    @State private var showSignUp = false

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundView

                VStack(spacing: 32) {
                    Spacer(minLength: 10)

                    // Hero Card
                    HeroCard()
                        .padding(.horizontal, 24)

                    // Buttons
                    VStack(spacing: 14) {
                        PrimaryCTA(title: "Login", systemImage: "arrow.right.circle.fill") {
                            showLogin = true
                        }
                        .padding(.horizontal, 24)

                        SecondaryCTA(title: "Sign Up", systemImage: "person.badge.plus") {
                            showSignUp = true
                        }
                        .padding(.horizontal, 24)
                    }

                    Spacer(minLength: 20)

                    // Hidden Navigation Links
                    NavigationLink(destination: LoginView(), isActive: $showLogin) { EmptyView() }
                    NavigationLink(destination: SignUpView(), isActive: $showSignUp) { EmptyView() }

                    // Footer
                    Text("Follow football matches live")
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.72))
                        .padding(.bottom, 12)
                }
                .padding(.vertical, 24)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private var backgroundView: some View {
        let gradient = LinearGradient(colors: [
            Color(red: 0.06, green: 0.07, blue: 0.11),
            Color(red: 0.05, green: 0.06, blue: 0.10),
            Color.black
        ], startPoint: .topLeading, endPoint: .bottomTrailing)

        let vignette = RadialGradient(colors: [Color.white.opacity(0.08), .clear], center: .topLeading, startRadius: 10, endRadius: 460)

        let starNoise = Rectangle()
            .fill(
                AngularGradient(gradient: Gradient(colors: [
                    Color.white.opacity(0.10),
                    Color.white.opacity(0.02),
                    Color.white.opacity(0.10)
                ]), center: .center)
            )
            .blendMode(.softLight)
            .opacity(0.08)

        return ZStack {
            gradient
            vignette
            starNoise
        }
        .ignoresSafeArea()
    }
}

// MARK: - Hero Card
private struct HeroCard: View {
    @State private var animate = false

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 26, style: .continuous)

        VStack(spacing: 18) {
            ZStack {
                // Accent ring
                Circle()
                    .strokeBorder(
                        AngularGradient(gradient: Gradient(colors: [
                            Color.green.opacity(0.9),
                            Color.blue.opacity(0.9),
                            Color.purple.opacity(0.9),
                            Color.green.opacity(0.9)
                        ]), center: .center), lineWidth: 2
                    )
                    .frame(width: 118, height: 118)
                    .blur(radius: 0.2)
                    .opacity(0.9)
                    .shadow(color: .black.opacity(0.45), radius: 16, x: 0, y: 12)
                    .scaleEffect(animate ? 1.02 : 0.98)
                    .animation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true), value: animate)

                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 110, height: 110)
                    .overlay(Circle().stroke(Color.white.opacity(0.18), lineWidth: 1))
                    .shadow(color: .black.opacity(0.35), radius: 14, x: 0, y: 10)

                Image(systemName: "soccerball.inverse")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.white)
                    .font(.system(size: 50, weight: .semibold))
                    .rotationEffect(.degrees(animate ? 4 : -4))
                    .animation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true), value: animate)
            }

            VStack(spacing: 4) {
                Text("GoalTracker")
                    .font(.system(.largeTitle, design: .rounded).weight(.bold))
                    .foregroundStyle(.white)
                Text("Your home for live scores, stats, and more")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.78))
            }
        }
        .padding(24)
        .background(.ultraThinMaterial)
        .overlay(shape.strokeBorder(Color.white.opacity(0.16), lineWidth: 1))
        .clipShape(shape)
        .shadow(color: .black.opacity(0.45), radius: 20, x: 0, y: 16)
        .onAppear { animate = true }
    }
}

// MARK: - Buttons
private struct PrimaryCTA: View {
    let title: String
    let systemImage: String
    let action: () -> Void

    @State private var isPressed = false

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 16, style: .continuous)
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .semibold))
                Text(title)
                    .font(.headline.weight(.bold))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                LinearGradient(colors: [Color.white, Color.white.opacity(0.88)], startPoint: .top, endPoint: .bottom)
            )
            .foregroundStyle(.black)
            .clipShape(shape)
            .shadow(color: .black.opacity(0.35), radius: 12, x: 0, y: 10)
            .overlay(
                shape.strokeBorder(
                    LinearGradient(colors: [Color.white.opacity(0.6), Color.white.opacity(0.2)], startPoint: .top, endPoint: .bottom),
                    lineWidth: 1
                )
            )
        }
        .buttonStyle(.plain)
        .scaleEffect(isPressed ? 0.98 : 1)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.15)) { isPressed = pressing }
        }, perform: {})
    }
}

private struct SecondaryCTA: View {
    let title: String
    let systemImage: String
    let action: () -> Void

    @State private var isPressed = false

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 16, style: .continuous)
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: systemImage)
                Text(title)
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                Color.white.opacity(0.12)
                    .overlay(
                        LinearGradient(colors: [Color.white.opacity(0.08), Color.clear], startPoint: .top, endPoint: .bottom)
                    )
            )
            .foregroundStyle(.white)
            .clipShape(shape)
            .overlay(shape.strokeBorder(Color.white.opacity(0.28), lineWidth: 1))
        }
        .buttonStyle(.plain)
        .scaleEffect(isPressed ? 0.985 : 1)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.15)) { isPressed = pressing }
        }, perform: {})
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}

