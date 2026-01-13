import SwiftUI

struct Match: Identifiable {
    let id = UUID()
    let homeTeam: String
    let awayTeam: String
    let homeScore: Int
    let awayScore: Int
    let status: String
}

struct HomeView: View {

    let matches: [Match] = [
        Match(homeTeam: "Liverpool", awayTeam: "Manchester City", homeScore: 2, awayScore: 1, status: "Live"),
        Match(homeTeam: "Chelsea", awayTeam: "Arsenal", homeScore: 0, awayScore: 0, status: "Upcoming"),
        Match(homeTeam: "Real Madrid", awayTeam: "Barcelona", homeScore: 1, awayScore: 1, status: "Live")
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                // Rich background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.07, green: 0.07, blue: 0.10),
                        Color(red: 0.05, green: 0.05, blue: 0.08),
                        Color.black
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 10) {
                                Image(systemName: "soccerball.inverse")
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 28, weight: .semibold))
                                Text("GoalTracker")
                                    .font(.largeTitle.bold())
                                    .foregroundStyle(.white)
                            }
                            Text("Live scores, form, and status at a glance")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 4)

                        // Match List
                        VStack(spacing: 16) {
                            ForEach(matches) { match in
                                MatchCard(match: match)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Matches")
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.9))
                }
            }
        }
    }
}

struct MatchCard: View {
    let match: Match

    private var statusColor: Color {
        switch match.status.lowercased() {
        case "live": return .green
        case "upcoming": return .orange
        default: return .gray
        }
    }

    var body: some View {
        ZStack {
            // Glassy background with subtle border and inner highlight
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.white.opacity(0.06))
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.08), lineWidth: 1)
                )
                .overlay(
                    LinearGradient(colors: [Color.white.opacity(0.10), .clear], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                )
                .shadow(color: .black.opacity(0.35), radius: 10, x: 0, y: 8)

            HStack(alignment: .center, spacing: 14) {
                // Teams block
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Image(systemName: "house.fill")
                            .foregroundStyle(.white.opacity(0.85))
                        Text(match.homeTeam)
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
                    HStack(spacing: 8) {
                        Image(systemName: "airplane.departure")
                            .foregroundStyle(.white.opacity(0.85))
                        Text(match.awayTeam)
                            .font(.headline)
                            .foregroundStyle(.white.opacity(0.95))
                    }
                }

                Spacer(minLength: 8)

                // Score + status
                VStack(alignment: .trailing, spacing: 8) {
                    HStack(alignment: .firstTextBaseline, spacing: 6) {
                        Text("\(match.homeScore)")
                        Text("-")
                            .foregroundStyle(.white.opacity(0.7))
                        Text("\(match.awayScore)")
                    }
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                    // Status badge
                    Text(match.status.uppercased())
                        .font(.caption2.weight(.semibold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule().fill(statusColor.opacity(0.18))
                        )
                        .overlay(
                            Capsule().stroke(statusColor.opacity(0.6), lineWidth: 1)
                        )
                        .foregroundStyle(statusColor)
                        .animation(.easeInOut(duration: 0.25), value: match.status)
                }
            }
            .padding(16)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(match.homeTeam) versus \(match.awayTeam). Score \(match.homeScore) to \(match.awayScore). Status \(match.status)")
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
