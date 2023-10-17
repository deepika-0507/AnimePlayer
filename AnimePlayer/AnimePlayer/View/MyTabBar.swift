//
//  MyTabBar.swift
//  AnimePlayer
//
//  Created by Deepika Ponnaganti on 15/10/23.
//

import SwiftUI

enum TabItems: String, CaseIterable {
    case house
    case magnifyingglass
    case calendar
}

struct MyTabBar: View {
    
    @Binding var selectedImage: TabItems
    var body: some View {
        HStack(spacing: 40.0){
            ForEach(TabItems.allCases, id: \.rawValue) { item in
                Image(systemName: item.rawValue)
                    .renderingMode(.template)
                    .foregroundColor(selectedImage == item ? .green : .white)
                    .onTapGesture {
                        selectedImage = item
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.black.opacity(0.8))
    }
}

struct MtTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MyTabBar(selectedImage: Binding.constant(.calendar))
    }
}
