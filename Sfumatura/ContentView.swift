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
    
    var body: some View {
        NavigationStack {
            VStack {
                if gradientsArray.isEmpty {
                    ContentUnavailableView("Oops, nothing to see here", systemImage: "paintbrush", description: Text("Tap the + button to create a new gradient"))
                } else {
                    List {
                        ForEach(gradientsArray, id: \.self) { gradient in
                            NavigationLink(value: gradient) {
                                CustomGradientView(gradient: gradient)
                            }
                            
                        }
                        .onDelete(perform: { indexSet in
                            deleteGradient(indexSet)
                        })
                        .listRowSeparator(.hidden)
                        
                    }
                    .listStyle(.plain)
                    .environment(\.defaultMinListRowHeight, 100)
                }
            }
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
            .navigationDestination(for: GradientModel.self) { gradient in
                GradientFullScreenView(gradient: gradient, gradientsArray: $gradientsArray)
            }
        }
    }
    
    func deleteGradient(_ indexSet: IndexSet) {
        for index in indexSet {
            gradientsArray.remove(at: index)
        }
    }
}


#Preview {
    ContentView()
}
