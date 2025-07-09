import SwiftUI

struct SupervisorHeaderView: View {
    let fullName: String
    let date: String
    let photoURL: URL?
    let onNotifications: () -> Void
    let onLogout: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            // Фото
            AsyncImage(url: photoURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 48, height: 48)
            .clipShape(Circle())

            // Имя и дата
            VStack(alignment: .leading, spacing: 4) {
                Text(fullName)
                    .font(.headline)
                Text(date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Кнопки
            HStack(spacing: 12) {
                Button(action: onNotifications) {
                    Image(systemName: "bell")
                        .font(.title2)
                }

                Button(action: onLogout) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.title2)
                }
            }
        }
        .padding()
    }
}
