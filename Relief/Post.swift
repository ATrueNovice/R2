//
//  Post.swift
//  Relief
//
//  Created by New on 7/3/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import Foundation

class Post {

    private var _venue: String!
    private var _address: String!
    //private var _postKey: String!


    var venue: String {
        if _venue == nil {
            _venue = ""
        }
        return _venue
    }

    var address: String {
        if _address == nil {
            _address = ""
        }
        return _address
    }

    init(venue: String, address: String) {
        self._venue = venue
        self._address = address
    }

}
