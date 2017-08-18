//
//  Post.swift
//  Relief
//
//  Created by New on 7/3/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import Foundation
import Firebase

class Post {

    private var _locationName: String!
    private var _address: String!
    private var _handicapAccessible: String!
    private var _hours: String!
    private var _postKey: String!
    private var _postREF: DatabaseReference!


    var locationName: String {
        return _locationName
    }

    var address: String {
        return _address
    }

    var handicapAccessible: String {
        return _handicapAccessible
    }

    var hours: String {
        return _hours
    }

    var postKey:String {
        return _postKey
    }


    init(postKey: String, postData: Dictionary<String, Any>) {
        self._postKey = postKey


        if let address = postData["ADDRESS"] as? String {
            self._address = address
        }

        if let handicapAccessible = postData["HANDICAP ACCESSIBLE?"] as? String {
            self._handicapAccessible = handicapAccessible
        }

        if let hours = postData["HOURS"] as? String {
            self._hours = hours
        }

        if let locationName = postData["NAME"] as? String {
            self._locationName = locationName
        }

        _postREF = Dataservice.ds.REF_VENUE.child(_postKey)

    }

    init(locationName: String, address: String) {
        self._locationName = locationName
        self._address = address
//        self._hours = hours
//        self._handicapAccessible = handicapAccessible
    }

}
