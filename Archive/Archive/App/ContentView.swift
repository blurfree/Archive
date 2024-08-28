//
//  ContentView.swift
//  Archive
//
//  Created by blurfree on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationStack {
            
            List {
                
                Section {
                    
                    ForEach(Love.allCases, id: \.self) { proj in
                        
                        NavigationLink(destination: proj.destination) {
                            
                            Text(proj.rawValue)
                        }
                    }
                    
                } header: {
                    
                    Text("Love")
                        .font(.headline)
                        .foregroundStyle(.black)
                }
            }
            
        }
        .accentColor(.white)
    }
}

#Preview {
    ContentView()
}
