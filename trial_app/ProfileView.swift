import SwiftUI

struct ProfileView: View {

    var body: some View {
        VStack(spacing: 20) {

            Text("Profile Page")
                .font(.largeTitle)
                .fontWeight(.bold)

            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 120, height: 120)
                .foregroundColor(.blue)

            Text("Username: FlutterDev")
                .font(.title2)

        }
        .padding()
        .navigationTitle("Profile")
    }
}

#Preview {
    ProfileView()
}
