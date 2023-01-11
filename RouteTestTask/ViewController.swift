//
//  ViewController.swift
//  RouteTestTask
//
//  Created by Sergii Miroshnichenko on 10.01.2023.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addAdressButton: UIButton!
    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var annotationArray = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
    }

    @IBAction func addAdressButtonTapped(_ sender: UIButton) {
        alertAddAdress(title: "Add", placeholder: "Enter adress") { [self] text in
            setupPlacemark(adressPlace: text)
        }
    }
    
    @IBAction func routeButtonTapped(_ sender: UIButton) {
        for index in 0..<annotationArray.count - 1 {
            createDirectionRequest(startCoordinate: annotationArray[index].coordinate, destinationCoordinate: annotationArray[index + 1].coordinate)
        }
        
        mapView.showAnnotations(annotationArray, animated: true)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        annotationArray = []
        routeButton.isHidden = true
        resetButton.isHidden = true
    }
    
    private func setupPlacemark(adressPlace: String) {
        let gc = CLGeocoder()
        
        gc.geocodeAddressString(adressPlace) { [self] placemarks, error in
            if let error = error {
                print(error)
                alertError(title: "Error", message: "This location wasn't found, please try another one")
                return
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            
            guard let placemarkLocation = placemark?.location else { return }
            
            let annotation = MKPointAnnotation()
            annotation.title = "\(adressPlace)"
            annotation.coordinate = placemarkLocation.coordinate
            
            annotationArray.append(annotation)
            
            if annotationArray.count > 2 {
                routeButton.isHidden = false
                resetButton.isHidden = false
            }
            
            mapView.showAnnotations(annotationArray, animated: true)
        }
    }
    
    private func createDirectionRequest(startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        
        let startLocation = MKPlacemark(coordinate: startCoordinate)
        let destinationLocation = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: destinationLocation)
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        
        let direction = MKDirections(request: request)
        direction.calculate { [self] responce, error in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let responce = responce else {
                self.alertError(title: "Error", message: "Route is not available")
                return
            }
            
            let minRoute = responce.routes.sorted { $0.distance < $1.distance }[0]
            
            self.mapView.addOverlay(minRoute.polyline)
        }
    }
    
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .green
        return renderer
    }
}
