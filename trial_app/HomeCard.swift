import SwiftUI

struct HomeCard: View {

    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 16) {
            
            // Icon
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .frame(width: 50)
            
            // Title & Subtitle
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            // Chevron
            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.05)) // subtle glass effect
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
        )
    }
}

#Preview {
    HomeCard(
        icon: "person.crop.circle.fill",
        title: "Profile",
        subtitle: "View your account"
    )
    .padding()
}
