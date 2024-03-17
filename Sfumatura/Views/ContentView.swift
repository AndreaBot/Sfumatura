//
//  ContentView.swift
//  Sfumatura
//
//  Created by Andrea Bottino on 15/03/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingColorSheet = false
    @State private var gradientsArray = [GradientModel]()
    
    var columns = [GridItem(.adaptive(minimum: UIScreen.main.bounds.width/3))]
    
    var body: some View {
        NavigationStack {
            VStack {
                if gradientsArray.isEmpty {
                    ContentUnavailableView("Oops, nothing to see here", systemImage: "paintbrush", description: Text("Tap the + button to create a new gradient"))
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(gradientsArray.indices, id: \.self) { index in
                                NavigationLink(value: index) {
                                    CustomGradientView(gradient: gradientsArray[index])
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Sfumatura")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Create gradient", systemImage: "plus") {
                        showingColorSheet = true
                    }
                }
            }
            .fullScreenCover(isPresented: $showingColorSheet, content: {
                CustomSliderView(showingColorSheet: $showingColorSheet, gradientArray: $gradientsArray, editing: false, gradientToEdit: nil)
            })
            .navigationDestination(for: Int.self) { int in
                GradientFullScreenView(gradient: gradientsArray[int], gradientsArray: $gradientsArray)
            }
        }
    }
}


#Preview {
    ContentView()
}
