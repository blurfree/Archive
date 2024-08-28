//
//  SplashView.swift
//  Archive
//
//  Created by blurfree on 8/28/24.
//

import SwiftUI

struct SplashView: View {
    
    @State private var goToNextView: Bool = false
    
    @State private var backscreenColor: Color = .black
    
    var body: some View {
        
        ZStack {
            
            if goToNextView {
                
                ContentView()
                
            } else {
                
                Text("Archive")
                    .foregroundStyle(backscreenColor == .black ? .white : .black)
                    .font(.largeTitle)
                
            }
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                withAnimation {
                    backscreenColor = .white
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                
                goToNextView = true
            }
        }
    }
}

#Preview {
    SplashView()
}
