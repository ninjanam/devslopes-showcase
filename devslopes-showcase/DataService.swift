//
//  DataService.swift
//  devslopes-showcase
//
//  Created by Nam-Anh Vu on 21/10/2016.
//  Copyright © 2016 namdashann. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let ds = DataService()
    
    private var _REF_BASE = FIRDatabase.database().reference() // The DATABASE_URL in Google.plist file
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
}
