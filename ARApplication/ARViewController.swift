//
//  ARViewController.swift
//  ARApplication
//
//  Created by Hassan Alkhafaji on 2/25/24.
//

import Foundation
import RealityKit
import ARKit

final class ARViewController: ObservableObject {
    
    static var shared = ARViewController()
    private var modelAnchor: AnchorEntity?
    @Published var arView: ARView
    
    init() {
        arView = ARView(frame: .zero)
    }
    
    public func startARSession() {
        
        startPlaneDetection()
        
        startTapDetection()
        
        
    }
    
    //MARK: setup
    
    private func startPlaneDetection() {
        
        arView.automaticallyConfigureSession = true
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        
        arView.session.run(configuration)
        
    }
    
    private func startTapDetection() {
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
    }
    
    @objc
    func handleTap(recognizer: UITapGestureRecognizer) {
        
        // Touch location
        let tapLocation = recognizer.location(in: arView)
        
        // Raycast 2d -> 3d pos
        let results = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        // If plane detected
        if let firstResults = results.first {
            
            //3D pos(x, y, z)
            let worldPosition = simd_make_float3(firstResults.worldTransform.columns.3)
            
            //Create 3D model
            let modelEntity = try! ModelEntity.loadModel(named: "PictureFrame.usdz")
//            let mesh = MeshResource.generateBox(width: 0.5, height: 2, depth: 0.2)
//            let materials = SimpleMaterial(color: .black, isMetallic: true)
            
            //Place Object
            placeObject(object: modelEntity, at: worldPosition)
        }
    }
    
    // Place Object
    private func placeObject(object modelEntity: ModelEntity, at position: SIMD3<Float>) {
        
        //1. Create an anchor (at a 3D Position)
        modelAnchor = AnchorEntity(world: position)
        
        //2. Tie model to anchor
        modelAnchor!.addChild(modelEntity)
        
        //3. Add anchor to scene
        arView.scene.addAnchor(modelAnchor!)
        
    }
}


