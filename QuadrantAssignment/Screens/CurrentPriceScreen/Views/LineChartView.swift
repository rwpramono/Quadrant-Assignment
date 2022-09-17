//
//  LineChartView.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 17/09/22.
//

import SwiftUI

struct LineChartView: View {
    var data: [CGFloat]
    
    @State var currentPlot = ""
    @State var offset: CGSize = .zero
    @State var showPlot = false
    @State var stateTranslation: CGFloat = 0
    var body: some View {
        GeometryReader { proxy in
            let height = proxy.size.height
            let width = (proxy.size.width) / CGFloat(data.count - 1)
            
            let maxPoint = (data.max() ?? 0) + 100
            let points = data.enumerated().compactMap { item -> CGPoint in
                let progress = item.element / maxPoint
                let pathHeight = progress * height
                let pathWidth = width * CGFloat(item.offset)
                return CGPoint(x: pathWidth, y: -pathHeight + height)
            }
            
            ZStack {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLines(points)
                    
                }
                .strokedPath(
                    StrokeStyle(
                        lineWidth: 2.5,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .fill(
                    LinearGradient(
                        colors: [Color(uiColor: .blue)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                
                
            }
            .overlay(
                VStack(spacing: 0) {
                    Text(currentPlot)
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(Color(uiColor: .gray), in: Capsule())
                        .offset(x: stateTranslation < 10 ? 30 : 0)
                        .offset(x: stateTranslation > (proxy.size.width - 60) ? -30 : 0)
                    Rectangle()
                        .fill(Color(uiColor: .blue))
                        .frame(width: 1, height: 40)
                        .padding(.top)
                    
                    Circle()
                        .fill(Color(uiColor: .blue))
                        .frame(width: 22, height: 22)
                        .overlay(
                            Circle()
                                .fill(.white)
                                .frame(width: 10, height: 10)
                        )
                    
                    Rectangle()
                        .fill(Color(uiColor: .blue))
                        .frame(width: 1, height: 50)
                }
                    .frame(width: 80, height: 170)
                    .offset(y: 70)
                    .offset(offset)
                    .opacity(showPlot ? 1 : 0),
                alignment: .bottomLeading
            )
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation {
                            showPlot = true
                        }
                        
                        let translation = value.location.x - 40
                        let index = max(min(Int((translation / width).rounded() + 1), data.count - 1), 0)
                        currentPlot = "$ \(data[index])"
                        stateTranslation = translation
                        offset = CGSize(
                            width: points[index].x - 40,
                            height:points[index].y - height
                        )
                    }.onEnded { value in
                        withAnimation {
                            showPlot = false
                        }
                    }
            )
        }
        .overlay(
            VStack(alignment: .leading) {
                let max = data.max() ?? 0
                
                Text("\(max)")
                    .font((.caption.bold()))
                
                Spacer()
                
                Text("$ 0")
                    .font((.caption.bold()))

            }
                .frame(maxWidth: .infinity, alignment: .leading)
        )
        .padding(.horizontal, 10)
    }
}

public let samplePlot: [CGFloat] = [
    100, 200, 300, 400, 500, 120, 230, 603
]
