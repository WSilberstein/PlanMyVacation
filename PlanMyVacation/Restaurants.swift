//
//  Business.swift
//  PlanMyVacation
//
//  Created by Simran Ajwani on 11/13/21.
//
// Yelp API Source: https://www.yelp.com/developers/documentation/v3/get_started

import Foundation

struct Restaurants{
    var name: String?
    var id: String?
    var rating: Float?
    var price: String?
    var is_closed: Bool?
    var distance: Double?
    var address: String?
    var hours: [String]?
    var phone: String?
    var imageURL: String?
    var location: String?
    var url: String?
    var reviews: [Any]?
}
