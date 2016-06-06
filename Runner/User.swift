//
//  User.swift
//  Runner
//
//  Created by Kasper Løkke Hansen on 25/05/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import Foundation

struct User {
    var id: Int
    var firstName: String
    var surName: String
    var address: String
    var city: String
    var zipCode: String
    var phoneNumber: String
    var email: String
    var password: String
    var activities: [Activity]
    
    
    init(id: Int, firstName: String, surName: String, address: String, city: String, zipCode: String, phoneNumber: String, email: String, password: String) {
        self.id = id
        self.firstName = firstName
        self.surName = surName
        self.address = address
        self.city = city
        self.zipCode = zipCode
        self.phoneNumber = phoneNumber
        self.email = email
        self.password = password
        self.activities = [Activity]()
    }
    
    init(id: Int) {
        self.init(id: id, firstName: "Kasper", surName: "Løkke", address: "Søndergade 62", city: "Aalborg", zipCode: "9000", phoneNumber: "40528283", email: "min_email@email.com", password: "hest")
    }
}