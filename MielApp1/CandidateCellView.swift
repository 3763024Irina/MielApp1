//карточка кандидата
import SwiftUI
struct AchievementView: View {
    let label: String
    let value: Int

    var body: some View {
        HStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color(red: 150/255, green: 0/255, blue: 71/255))
                .frame(width: 12, height: 12)
            Text("\(label): \(value)")
                .font(.subheadline)
        }
    }
}

struct CandidateCellView: View {
    let candidate: CandidateInfo
    let onInvite: () -> Void
    let onToggleFavorite: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                AsyncImage(url: URL(string: candidate.photo ?? "")) { img in
                    img.resizable()
                } placeholder: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.gray.opacity(0.5))
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text("\(candidate.name ?? "") \(candidate.surname ?? "")")
                        .font(.headline)

                    HStack(spacing: 8) {
                        if let age = candidate.age {
                            Text("\(age) лет")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        if let city = candidate.city {
                            Text(city)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }

                Spacer()

                Button(action: onToggleFavorite) {
                    Image(systemName: candidate.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.pink)
                        .font(.system(size: 24))
                }
            }

            // Ссылка на резюме
            if let resume = candidate.resume,
               !resume.isEmpty,
               let resumeURL = URL(string: resume) {
                Link("Ссылка на резюме", destination: resumeURL)
                    .font(.subheadline)
                    .foregroundColor(.pink)
            }

            // Курсы
            if let courses = candidate.courses, !courses.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Курсы").bold().font(.subheadline)

                    ForEach(courses, id: \.id) { course in
                        HStack(spacing: 6) {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color(red: 176/255, green: 7/255, blue: 87/255))
                                .frame(width: 12, height: 12)
                            Text(course.name)
                                .font(.subheadline)
                        }
                    }
                }
            }

            // Достижения
            VStack(alignment: .leading, spacing: 4) {
                Text("Достижения").bold().font(.subheadline)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                    AchievementView(label: "Объекты", value: candidate.achivmentObjects ?? 0)
                    AchievementView(label: "Покупатели", value: candidate.achivmentClients ?? 0)
                    AchievementView(label: "Лиды", value: candidate.achivmentLeads ?? 0)
                    AchievementView(label: "Эксклюзивы", value: candidate.achivmentExclusives ?? 0)
                    AchievementView(label: "Сделки", value: candidate.achivmentDeals ?? 0)
                }
            }

            // Кнопка "Пригласить"
            Button(action: onInvite) {
                Text("Пригласить")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color(red: 176/255, green: 7/255, blue: 87/255))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}
