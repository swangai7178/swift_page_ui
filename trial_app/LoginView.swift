import SwiftUI

struct LoginView: View {

    @State private var email = ""
    @State private var password = ""
    @State private var showSignUp = false
    @State private var isLoggedIn = false
    @State private var isSecure = true
    @FocusState private var focusedField: Field?

    enum Field { case email, password }

    private var isFormValid: Bool {
        !email.trimmingCharacters(in: .whitespaces).isEmpty && !password.isEmpty
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Rich background gradient with subtle vignette
                LinearGradient(colors: [
                    Color(red: 0.08, green: 0.08, blue: 0.12),
                    Color(red: 0.05, green: 0.05, blue: 0.09),
                    Color.black
                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .overlay(
                    RadialGradient(colors: [Color.white.opacity(0.06), .clear], center: .topLeading, startRadius: 10, endRadius: 400)
                        .ignoresSafeArea()
                )

                VStack(spacing: 28) {
                    Spacer(minLength: 20)

                    // App Logo / Header
                    VStack(spacing: 10) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.06))
                                .frame(width: 96, height: 96)
                                .overlay(
                                    Circle().stroke(Color.white.opacity(0.12), lineWidth: 1)
                                )
                                .shadow(color: .black.opacity(0.4), radius: 14, x: 0, y: 10)

                            Image(systemName: "soccerball.inverse")
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.white)
                                .font(.system(size: 42, weight: .semibold))
                        }

                        Text("GoalTracker")
                            .font(.system(.largeTitle, design: .rounded).weight(.bold))
                            .foregroundStyle(.white)

                        Text("Login to your account")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.75))
                    }
                    .padding(.top, 10)

                    // Card Container
                    VStack(spacing: 18) {
                        // Email Field
                        HStack(spacing: 12) {
                            Image(systemName: "envelope.fill")
                                .foregroundStyle(.white.opacity(0.8))
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled(true)
                                .foregroundStyle(.white)
                                .focused($focusedField, equals: .email)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .strokeBorder(focusedField == .email ? Color.white.opacity(0.6) : Color.white.opacity(0.25), lineWidth: 1)
                        )

                        // Password Field
                        HStack(spacing: 12) {
                            Image(systemName: "lock.fill")
                                .foregroundStyle(.white.opacity(0.8))

                            Group {
                                if isSecure {
                                    SecureField("Password", text: $password)
                                } else {
                                    TextField("Password", text: $password)
                                }
                            }
                            .foregroundStyle(.white)
                            .focused($focusedField, equals: .password)

                            Button(action: { withAnimation(.easeInOut(duration: 0.15)) { isSecure.toggle() } }) {
                                Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                            .buttonStyle(.plain)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .strokeBorder(focusedField == .password ? Color.white.opacity(0.6) : Color.white.opacity(0.25), lineWidth: 1)
                        )

                        // Forgot password
                        HStack {
                            Spacer()
                            Button("Forgot password?") {}
                                .font(.footnote.weight(.semibold))
                                .foregroundStyle(.white.opacity(0.85))
                        }
                        .padding(.top, 2)

                        // Login Button
                        Button(action: {
                            isLoggedIn = true
                        }) {
                            HStack {
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.system(size: 18, weight: .semibold))
                                Text("Login")
                                    .font(.headline)
                                    .fontWeight(.bold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                LinearGradient(colors: [Color.white, Color.white.opacity(0.85)], startPoint: .top, endPoint: .bottom)
                            )
                            .foregroundStyle(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                            .shadow(color: .black.opacity(0.35), radius: 10, x: 0, y: 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
                            )
                        }
                        .disabled(!isFormValid)
                        .opacity(isFormValid ? 1.0 : 0.6)
                        .animation(.easeInOut(duration: 0.2), value: isFormValid)
                    }
                    .padding(20)
                    .background(Color.white.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .strokeBorder(Color.white.opacity(0.12), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.35), radius: 16, x: 0, y: 12)
                    .padding(.horizontal, 24)

                    // Divider + social row (placeholder)
                    VStack(spacing: 14) {
                        HStack {
                            Rectangle().fill(Color.white.opacity(0.2)).frame(height: 1)
                            Text("or continue with")
                                .font(.footnote)
                                .foregroundStyle(.white.opacity(0.7))
                            Rectangle().fill(Color.white.opacity(0.2)).frame(height: 1)
                        }

                        HStack(spacing: 16) {
                            SocialButton(icon: "apple.logo", label: "Apple") {}
                            SocialButton(icon: "envelope", label: "Email") {
                                focusedField = .email
                            }
                        }
                    }
                    .padding(.horizontal, 24)

                    // Sign Up link
                    HStack(spacing: 6) {
                        Text("Don't have an account?")
                            .foregroundStyle(.white.opacity(0.75))
                        Button(action: { showSignUp = true }) {
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .underline()
                        }
                    }

                    Spacer(minLength: 10)

                    // NavigationLinks
                    NavigationLink(destination: SignUpView(), isActive: $showSignUp) { EmptyView() }
                    NavigationLink(destination: HomeView(), isActive: $isLoggedIn) { EmptyView() }
                }
                .padding(.vertical, 24)
            }
        }
    }
}

private struct SocialButton: View {
    let icon: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                Text(label)
            }
            .font(.subheadline.weight(.semibold))
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .background(Color.white.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.18), lineWidth: 1)
            )
            .foregroundStyle(.white)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LoginView()
        .preferredColorScheme(.dark)
}
