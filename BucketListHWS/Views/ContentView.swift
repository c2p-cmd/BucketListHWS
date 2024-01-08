//
//  ContentView.swift
//  BucketListHWS
//
//  Created by Sharan Thakur on 08/01/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                
                NavigationLink("MainView", destination: MainView.init)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
