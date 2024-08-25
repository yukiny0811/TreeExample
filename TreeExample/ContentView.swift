//
//  ContentView.swift
//  TreeExample
//
//  Created by Yuki Kuwashima on 2024/08/26.
//

import SwiftUI
import SwiftyCreatives

struct ContentView: View {
    
    @StateObject var sketch = TreeSketch()
    
    var body: some View {
        HStack {
            SketchView(sketch)
            VStack(alignment: .leading) {
                Group {
                    Text("Tree Designer").font(.largeTitle)
                    ColorPicker("Tip Box Color", selection: $sketch.tipBoxColor)
                    Slider(value: $sketch.tipBoxScale, in: 0...1) { Text("Tip Box Scale") }
                    Slider(value: $sketch.lineWidth, in: 0...1) { Text("Line Width") }
                    ColorPicker("Branch Tip Color", selection: $sketch.branchTipColor)
                    ColorPicker("Line Color", selection: $sketch.lineColor)
                    Slider(value: $sketch.zPlus, in: 0...1) { Text("Z+") }
                    Slider(value: $sketch.zMinus, in: -1...0) { Text("Z-") }
                    Slider(value: $sketch.yPlus, in: 0...1) { Text("Y+") }
                    Slider(value: $sketch.yMinus, in: -1...0) { Text("Y-") }
                }
                HStack {
                    TextField("Gene", text: $sketch.growGene)
                    Button("Update") {
                        sketch.growGene = sketch.growGene
                        sketch.reset()
                    }
                }
            }
            .frame(width: 400)
            .padding(30)
        }
        .background(.black)
    }
}
