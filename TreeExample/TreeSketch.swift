//
//  TreeSketch.swift
//  TreeExample
//
//  Created by Yuki Kuwashima on 2024/08/26.
//

import SwiftUI
import SwiftyCreatives

final class TreeSketch: Sketch, ObservableObject {
    
    @Published var tipBoxColor: Color = Color(cgColor: CGColor(red: 1.0, green: 0.2, blue: 0.7, alpha: 1.0))
    @Published var tipBoxScale: Float = 0.15
    @Published var lineWidth: Float = 0.1
    @Published var branchTipColor: Color = Color(cgColor: CGColor(red: 1.0, green: 0.3, blue: 1.0, alpha: 1.0))
    @Published var lineColor: Color = Color(cgColor: CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    @Published var zPlus: Float = 0.3
    @Published var zMinus: Float = -0.3
    @Published var yPlus: Float = 0.15
    @Published var yMinus: Float = -0.15
    @Published var growGene: String = "FyF+[+FyF-yPA]-[-yF+YPA]"
    
    private var tree = "F"
    private var speeds: [Float] = [0.01, -0.015, 0.004, 0.008, -0.02]
    private var currentRotation: [Float] = [0, 0, 0, 0, 0]
    
    override init() {
        super.init()
        for _ in 0..<4 {
            grow()
        }
    }
    
    func reset() {
        tree = "F"
        for _ in 0..<4 {
            grow()
        }
    }
    
    private func grow() {
        var currentTree = ""
        for t in tree {
            if t == "F" {
                currentTree += growGene
            } else {
                currentTree += String(t)
            }
        }
        tree = currentTree
    }
    
    private func compile(char: Character) {
        switch char {
        case "A":
            color(tipBoxColor.f3Value, alpha: 1.0)
            box(tipBoxScale, tipBoxScale, tipBoxScale)
        case "P":
            color(branchTipColor.f3Value, alpha: 1.0)
            boldline(0, 0, 0, 0, 1, 0, width: lineWidth)
            translate(0, 1, 0)
        case "F":
            color(lineColor.f3Value, alpha: 0.8)
            boldline(0, 0, 0, 0, 1, 0, width: lineWidth)
            translate(0, 1, 0)
        case "+":
            rotateZ(zPlus)
        case "-":
            rotateZ(zMinus)
        case "[":
            pushMatrix()
        case "]":
            popMatrix()
        case "y":
            rotateY(yPlus)
        case "Y":
            rotateY(yMinus)
        default:
            break
        }
    }
    
    override func setupCamera(camera: MainCamera) {
        camera.setTranslate(0, -20, -40)
    }
    
    override func update(camera: MainCamera) {
        camera.rotateAroundY(0.01)
    }
    
    override func draw(encoder: SCEncoder) {
        push {
            for i in 0..<speeds.count {
                push {
                    currentRotation[i] += speeds[i]
                    rotateY(currentRotation[i])
                    translate(Float(i + 2) * 2, 0, 0)
                    color(1.0, 0.8, 1.0, 1.0)
                    box(0.3, 0.3, 0.3)
                }
                push {
                    rotateY(currentRotation[i])
                    for _ in 0..<10 {
                        rotateY(-speeds[i] * 20)
                        push {
                            translate(Float(i + 2) * 2, 0, 0)
                            box(0.15, 0.15, 0.15)
                        }
                    }
                }
            }
        }
        for t in tree {
            compile(char: t)
        }
    }
}
