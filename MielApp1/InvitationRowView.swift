import SwiftUI

extension AdminInvitation {
    var statusText: String {
        status?.rawValue.capitalized ?? "—"
    }
    var createdAtText: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: createdAt)
    }
}

struct InvitationRowView: View {
    let item: AdminInvitation

    var body: some View {
        HStack(spacing: 12) {
            // Можно использовать иконку вместо фото
            Image(systemName: "person.crop.square")
                .resizable()
                .foregroundColor(.gray.opacity(0.4))
                .frame(width: 56, height: 56)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text("Офис: \(item.officeName)")
                    .font(.headline)
                Text("Супервайзер: \(item.supervisor)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Статус: \(item.statusText)")
                    .font(.caption2)
                Text("Создано: \(item.createdAtText)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 6)
    }
}
