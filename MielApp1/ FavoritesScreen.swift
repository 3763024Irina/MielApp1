//
//   FavoritesScreen.swift
//  MielApp1
//
//  Created by Irina on 7/7/25.
//

import Foundation
import SwiftUI

struct FavoritesScreen: View {
    var body: some View {
        VStack {
            Text("Избранное")
                .font(.largeTitle.bold())
            Spacer()
            // Здесь добавь реальный список избранных, по аналогии с витриной
        }
        .navigationTitle("Избранное")
    }
}
