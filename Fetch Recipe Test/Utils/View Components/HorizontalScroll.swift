//
//  HorizontalScroll.swift
//  Fetch Recipe Test
//
//  Created by Mustafa Qutbuddin on 2024-10-06.
//

import SwiftUI

struct HorizontalScroll<T: Identifiable, Content: View>: View {
    var data: [T]
    var content: (T) -> Content
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(data) { item in
                    content(item)
                }
            }
        }
    }
}
