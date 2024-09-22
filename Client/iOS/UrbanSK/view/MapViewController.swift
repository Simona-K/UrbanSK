//
//  MapViewController.swift
//  UrbanSK
//
//  Created by Simona Kostovska on 6.09.24.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!

    @IBOutlet weak var tilesetsControl: UISegmentedControl! {
        didSet {
            tilesetsControl.removeAllSegments()
            if let urbanPlan = urbanPlan {
                for tileset in urbanPlan.tilesets {
                    tilesetsControl.insertSegment(withTitle: tileset.released, at: tilesetsControl.numberOfSegments, animated: false)
                }
            }
            tilesetsControl.selectedSegmentIndex = tilesetsControl.numberOfSegments - 1
        }
    }
    
    var urbanPlan: UrbanPlan? {
        didSet {
            if let urbanPlan = urbanPlan,
               !urbanPlan.tilesets.isEmpty {
                currentTileset = urbanPlan.tilesets.last
            }
        }
    }
    var currentTileset: Tileset?

    var overlayLayer: GMSURLTileLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .satellite
        addOverlay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let urbanPlan = urbanPlan {
            let camera = GMSCameraPosition.camera(withLatitude: Double(urbanPlan.latitude)!,
                                                  longitude: Double(urbanPlan.longitude)!,
                                                  zoom: Float(urbanPlan.zoom)!)
            mapView.camera = camera
            title = urbanPlan.name
        }
    }
    
    private func addOverlay() {
        if let overlayLayer = overlayLayer {
            overlayLayer.map = nil
        }
        
        let urls: GMSTileURLConstructor = { (x, y, zoom) in
            guard let currentTileset = self.currentTileset else {
                return URL(string:"")
            }
            let accessToken = "pk.eyJ1IjoiYWxleGdpemgiLCJhIjoiY2l6aXQ2MnUzMDJ1djJ3bm51N3E2ajRjeCJ9.i9aOgYQbfzKMKcokFPeGMQ"
            let url = "https://a.tiles.mapbox.com/v4/\(currentTileset.tilesetId)/\(zoom)/\(x)/\(y)@2x.png?access_token=\(accessToken)"
            return URL(string: url)
        }

        overlayLayer = GMSURLTileLayer(urlConstructor: urls)
        overlayLayer?.clearTileCache()
        
        guard let overlayLayer = overlayLayer else {
            return
        }

        overlayLayer.zIndex = 100
        overlayLayer.map = mapView
    }
    
    @IBAction func tilesetChanged(segmentedControl: UISegmentedControl) {
        let index = segmentedControl.selectedSegmentIndex
        currentTileset = urbanPlan?.tilesets[index]
        addOverlay()
    }
    
    @IBAction func opacityValueChanged(slider: UISlider) {
        overlayLayer?.opacity = slider.value
    }
    
    @IBAction func baseMapChanged(segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .satellite
        case 1:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .normal
        }
    }

}
