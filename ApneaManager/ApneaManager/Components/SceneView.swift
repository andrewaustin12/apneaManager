//
//  SceneView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/10/24.
//

import SwiftUI
import SceneKit

struct SceneView: UIViewRepresentable {
    @Binding var scene: SCNScene?
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling2X
        view.scene = scene
        view.backgroundColor = .clear
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        // update the view as needed
    }
}

//#Preview {
//    SceneView()
//}
