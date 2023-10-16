//
//  ContentView.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 08/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var selectedImage: TabItems = .house
    var body: some View {
        ZStack {
            TabView(selection: $selectedImage) {
                HomeScreenView()
                    .tag(TabItems.house)
                SearchView()
                    .tag(TabItems.magnifyingglass)
                NewReleasesView()
                    .tag(TabItems.calendar)
            }
            VStack{
                Spacer()
                MyTabBar(selectedImage: $selectedImage)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
