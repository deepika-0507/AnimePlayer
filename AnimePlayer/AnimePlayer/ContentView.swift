//
//  ContentView.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 08/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeScreeViewModel = HomeScreenViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
