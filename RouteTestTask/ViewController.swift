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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func addAdressButtonTapped(_ sender: UIButton) {
        alertAddAdress(title: "Add", placeholder: "Enter adress", completionHandler: { text in
            print(text)
        })
    }
    
    @IBAction func routeButtonTapped(_ sender: UIButton) {
        print("Route Button tepped")
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        print("Reset Button tepped")
    }
}
