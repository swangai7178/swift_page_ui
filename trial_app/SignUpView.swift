import SwiftUI

struct SignUpView: View {

    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isSignedUp = false
    @State private var isSecure1 = true
    @State private var isSecure2 = true
    @FocusState private var focusedField: Field?

    enum Field { case username, email, password, confirm }

    private var isFormValid: Bool {
        !username.trimmingCharacters(in: .whitespaces).isEmpty &&
        !email.trimmingCharacters(in: .whitespaces).isEmpty &&
        !password.isEmpty &&
        password == confirmPassword
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(colors: [
                    Color(red: 0.08, green: 0.08, blue: 0.12),
                    Color(red: 0.05, green: 0.05, blue: 0.09),
                    Color.black
                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .overlay(
                    RadialGradient(colors: [Color.white.opacity(0.06), .clear], center: .topLeading, startRadius: 10, endRadius: 420)
                        .ignoresSafeArea()
                )

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 28) {
                        Spacer(minLength: 20)

                        // Header
                        VStack(spacing: 10) {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.06))
                                    .frame(width: 96, height: 96)
                                    .overlay(Circle().stroke(Color.white.opacity(0.12), lineWidth: 1))
                                    .shadow(color: .black.opacity(0.4), radius: 14, x: 0, y: 10)

                                Image(systemName: "person.badge.plus")
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 40, weight: .semibold))
                            }

                            Text("Create Account")
                                .font(.system(.largeTitle, design: .rounded).weight(.bold))
                                .foregroundStyle(.white)

                            Text("Join GoalTracker to follow your teams")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.75))
                        }
                        .padding(.top, 10)

                        // Card Container
                        VStack(spacing: 18) {
                            // Username
                            HStack(spacing: 12) {
                                Image(systemName: "person.fill")
                                    .foregroundStyle(.white.opacity(0.8))
                                TextField("Username", text: $username)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled(true)
                                    .foregroundStyle(.white)
                                    .focused($focusedField, equals: .username)
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .strokeBorder(focusedField == .username ? Color.white.opacity(0.6) : Color.white.opacity(0.25), lineWidth: 1)
                            )

                            // Email
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

                            // Password
                            HStack(spacing: 12) {
                                Image(systemName: "lock.fill")
                                    .foregroundStyle(.white.opacity(0.8))

                                Group {
                                    if isSecure1 {
                                        SecureField("Password", text: $password)
                                    } else {
                                        TextField("Password", text: $password)
                                    }
                                }
                                .foregroundStyle(.white)
                                .focused($focusedField, equals: .password)

                                Button(action: { withAnimation(.easeInOut(duration: 0.15)) { isSecure1.toggle() } }) {
                                    Image(systemName: isSecure1 ? "eye.slash.fill" : "eye.fill")
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

                            // Confirm Password
                            HStack(spacing: 12) {
                                Image(systemName: "lock.circle.fill")
                                    .foregroundStyle(.white.opacity(0.8))

                                Group {
                                    if isSecure2 {
                                        SecureField("Confirm Password", text: $confirmPassword)
                                    } else {
                                        TextField("Confirm Password", text: $confirmPassword)
                                    }
                                }
                                .foregroundStyle(.white)
                                .focused($focusedField, equals: .confirm)

                                Button(action: { withAnimation(.easeInOut(duration: 0.15)) { isSecure2.toggle() } }) {
                                    Image(systemName: isSecure2 ? "eye.slash.fill" : "eye.fill")
                                        .foregroundStyle(.white.opacity(0.8))
                                }
                                .buttonStyle(.plain)
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .strokeBorder(focusedField == .confirm ? Color.white.opacity(0.6) : Color.white.opacity(0.25), lineWidth: 1)
                            )

                            // Inline validation for password match
                            if !confirmPassword.isEmpty && password != confirmPassword {
                                HStack(spacing: 6) {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundStyle(.orange)
                                    Text("Passwords do not match")
                                        .font(.footnote)
                                        .foregroundStyle(.orange)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .transition(.opacity)
                            }

                            // Sign Up Button
                            Button(action: {
                                isSignedUp = true
                            }) {
                                HStack {
                                    Image(systemName: "checkmark.seal.fill")
                                        .font(.system(size: 18, weight: .semibold))
                                    Text("Create Account")
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

                        Spacer(minLength: 10)

                        // Navigation to Home
                        NavigationLink(destination: HomeView(), isActive: $isSignedUp) { EmptyView() }
                    }
                    .padding(.vertical, 24)
                }
            }
        }
    }
}

#Preview {
    SignUpView()
        .preferredColorScheme(.dark)
}
