//
//  MapViewController.swift
//  0610
//
//  Created by Chris on 2019/7/2.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var cafes: [Cafe] = []

    var geoCoder = CLGeocoder()

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupMapView()
        getJSON()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.barStyle = .black
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = UIColor(named: "Green 2")
        navigationController?.navigationBar.barTintColor = UIColor(named: "Green 2")
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    func setupMapView() {
//        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
    }

    func getJSON() {
        cafes = []

        requestManager.getYilanCafe { [weak self] (cafes) in
            guard let strongSelf = self else { return }
            strongSelf.cafes = cafes
            strongSelf.showCafes()
        }
    }

    func showCafes() {
        var annotations: [MKPointAnnotation] = []
        for cafe in cafes {
            let location = CLLocation(latitude: Double(cafe.latitude)!, longitude: Double(cafe.longitude)!)
            let annotation = MKPointAnnotation()
            annotation.title = cafe.name
            annotation.subtitle = cafe.address
            annotation.coordinate = location.coordinate
            annotations.append(annotation)
        }
        mapView.showAnnotations(annotations, animated: true)
//        if annotations.count > 0 {
//            mapView.selectAnnotation(annotations.last!, animated: true)
//        }
    }

}
