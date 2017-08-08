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

class Seach_Screen: UIViewController, UITableViewDelegate, UITableViewDataSource {

 
    @IBOutlet weak var tableView: UITableView!

    var posts = [Post]()
    var geoFire = GeoFire()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        self.tableView.reloadData()

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? DataCell {
//            let post = posts[indexPath.row]
//            cell.configureCell(post: post)
            return cell
        } else {
            return DataCell()
        }

    }

    

    



}
