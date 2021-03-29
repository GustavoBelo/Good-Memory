//
//  Good_MemoryApp.swift
//  Good Memory
//
//  Created by Gustavo Belo on 20/03/21.
//

import SwiftUI

@main
struct Good_MemoryApp: App {
    var body: some Scene {
        WindowGroup {
//            EmojiMemoryGameView(viewModel:game)
            ChooseContentView(showingGame: false, mode: 2)
        }
    }
}
