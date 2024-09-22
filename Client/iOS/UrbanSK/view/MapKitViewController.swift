import UIKit
import MapKit
 
class MapKitViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let baseOverlay = UrbanSKMapOverlay("ckvn0v5hc2dm915s2a937rt2j")
    let planOverlay = UrbanSKMapOverlay("ckvn0nq98b57g14nzijf5i8a4")

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
    }
    
    lazy var baseTileRenderer: MKTileOverlayRenderer = {
        return MKTileOverlayRenderer(tileOverlay: baseOverlay)
    }()
    
    lazy var planTileRenderer: MKTileOverlayRenderer = {
        return MKTileOverlayRenderer(tileOverlay: planOverlay)
    }()
    
    private func setupMap() {
        mapView.delegate = self
        mapView.mapType = .satellite
        baseOverlay.canReplaceMapContent = true
        let userCenter = CLLocationCoordinate2D(latitude: 42.02, longitude: 21.42)
        let region = MKCoordinateRegion(center: userCenter, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(region, animated: true)
        mapView.addOverlay(baseOverlay)
        mapView.addOverlay(planOverlay, level: .aboveLabels)
    }
    
    @IBAction func toggleSwitch(_ sender: UISwitch) {
        if (sender.isOn) {
            mapView.removeOverlay(baseOverlay)
            mapView.addOverlay(planOverlay)
        } else {
            mapView.removeOverlay(planOverlay)
            mapView.addOverlay(baseOverlay)
        }
    }
    
}

extension MapKitViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let overlayRenderer = MKTileOverlayRenderer(tileOverlay: overlay as! MKTileOverlay)
        overlayRenderer.alpha = 0.5
        return overlayRenderer
//        if (overlay.isEqual(planOverlay)) {
//            return planTileRenderer
//        }
//        return baseTileRenderer
    }
}

class UrbanSKMapOverlay: MKTileOverlay {
    
    var styleId: String
    
    init(_ styleId: String) {
        self.styleId = styleId
        super.init(urlTemplate: nil)
    }

    override func url(forTilePath path: MKTileOverlayPath) -> URL {
        let tileUrl =
        "https://api.mapbox.com/styles/v1/alexgizh/\(styleId)/tiles/256/\(path.z)/\(path.x)/\(path.y)@2x?access_token=pk.eyJ1IjoiYWxleGdpemgiLCJhIjoiY2l6aXQ2MnUzMDJ1djJ3bm51N3E2ajRjeCJ9.i9aOgYQbfzKMKcokFPeGMQ"
        return URL(string: tileUrl)!
    }

}
