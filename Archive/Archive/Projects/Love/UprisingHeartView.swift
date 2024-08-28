//
//  UprisingHeartView.swift
//  Archive
//
//  Created by blurfree on 8/28/24.
//

import SwiftUI

struct UprisingHeartView: View {
    
    var body: some View {
        UprisingHeart()
    }
}

struct UprisingHeart: View {

    @State private var newHeartLocation: CGPoint = .zero
    @State private var uprisingHearts: [UprisingHeartWithID] = []
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundStyle(.black)
            
            ForEach(uprisingHearts) {
                $0.uprisingHeart
            }
        }
        .ignoresSafeArea()
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    
                    self.newHeartLocation = value.location
                }
                .onEnded { value in
                     
                    self.newHeartLocation = value.location
                    addHeart(x: value.location.x, y: value.location.y)
                }
        )
    }
    
    private func addHeart(x: Double, y: Double) {
        
        let newHeartId = UUID()
        
        let heart = UpriseHeart(offSetX: x, offSetY: y)
        
        uprisingHearts.append(UprisingHeartWithID(id: newHeartId, uprisingHeart: heart))
        
        removeHeart(id: newHeartId)
    }
    
    private func removeHeart(id: UUID) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            guard let heartPosition = uprisingHearts.firstIndex(where: { $0.id == id}) else {return }
            
            uprisingHearts.remove(at: heartPosition)
        }
    }
}

fileprivate struct UprisingHeartWithID: Identifiable {
    
    let id: UUID
    let uprisingHeart: UpriseHeart
}

fileprivate struct UpriseHeart: View {
    
    let offSetX: CGFloat
    @State var offSetY: CGFloat
    
    init(offSetX: CGFloat, offSetY: CGFloat) {
        self.offSetX = offSetX
        self.offSetY = offSetY
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            Heart()
                .offset(x: offSetX, y: offSetY)
                .onAppear {
                    withAnimation(.easeIn(duration: 5)) {
                        offSetY = -100
                    }
                }
        }
    }
}

fileprivate struct Heart: View {
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple]
    
    var body: some View {
        
        HeartShape()
            .fill(LinearGradient(colors: [colors.randomElement()!, colors.randomElement()!],
                                 startPoint: .topLeading,
                                 endPoint: .bottomTrailing))
            .frame(width: screenWidth / 6, height: screenWidth / 5)
    }
}

fileprivate struct HeartShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        let midX = rect.width / 2
        let midY = rect.height / 2
        
        path.move(to: CGPoint(x: midX, y: midY))
        
        path.addCurve(to: CGPoint(x: midX, y: midY * 2),
                      control1: CGPoint(x: midX / 2, y: 0),
                      control2: CGPoint(x: -(midX), y: midY * (2/3)))
        
        path.addCurve(to: CGPoint(x: midX, y: midY),
                      control1: CGPoint(x: rect.width + midX, y: midY * (2/3)),
                      control2: CGPoint(x: midX * 3/2, y: 0))
        
        return path
    }
}


#Preview {
    UprisingHeartView()
}
