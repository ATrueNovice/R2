//
//  Seach Screen.swift
//  Relief
//
//  Created by New on 6/6/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class Seach_Screen: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate {

 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager()

    var locationData = [venueData]()
    var centerMapped = false

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        self.tableView.reloadData()

        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow

        Dataservice.ds.REF_VENUE.observeSingleEvent(of: .value, with: { snapshot in

            if snapshot.children.allObjects is [DataSnapshot] {
                for snap in snapshot.children {


                    if let postDict = snap as? Dictionary<String, Any> {
                        let key = snapshot.key
                        let post = venueData(postKey: key, postData: postDict)
                        self.locationData.append(post)
                    }
                }
            }
            self.tableView.reloadData()
    })
    }

    //Brings up the user on the map after authorization
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }


    //Checks if app is authorized to get user's location data.
    func locationAuthStatus () {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {

            mapView.showsUserLocation = true

        } else {
            locationManager.requestWhenInUseAuthorization()
        }

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)

        mapView.setRegion(coordinateRegion, animated: true)
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            if !centerMapped {
                centerMapOnLocation(location: loc)
                centerMapped = true
            }

        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        var annotationView: MKAnnotationView?

        if annotation.isKind(of: MKUserLocation.self) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView?.image = UIImage(named: "icon")
        }

        return annotationView
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationData.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let post = locationData[indexPath.row]

        if let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? DataCell {
            cell.configureCell(post: post)
            
            return cell

        }  else {
            return DataCell()
        }

    }
}
