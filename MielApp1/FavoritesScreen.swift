import SwiftUI
struct FavoritesScreen: View {
    @State private var favs: [Favorite] = []
    @State private var loading = false
    var body: some View {
        NavigationStack {
            if loading { ProgressView() } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(favs, id: \._id) { fav in
                            CandidateCard(candidate: fav.candidateInfo)
                                .overlay(alignment: .topTrailing) {
                                    Button { delete(fav.id) } label: { Image(systemName: "trash") }.padding(6)
                                }
                        }
                    }.padding()
                }.navigationTitle("Избранное")
            }
        }.onAppear { fetch() }
    }
    private func fetch() {
        loading = true
        FavoritesService().fetch { result in
            DispatchQueue.main.async {
                loading = false
                if case let .success(list) = result { favs = list }
            }
        }
    }
    private func delete(_ id: Int) {
        FavoritesService().delete(id: id) { _ in fetch() }
    }
}
