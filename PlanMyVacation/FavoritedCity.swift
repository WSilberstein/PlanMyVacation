//
//  FavoritedCity.swift
//  PlanMyVacation
//
//  Created by Katie Legan on 11/29/21.
//
// Yelp API Source: https://www.yelp.com/developers/documentation/v3/get_started

import Foundation
import UIKit

class FavoritedCity : Codable
{
    var cityName = ""
    var restaurants: [String] = []
    var landmarks: [String] = []
    var hotels: [String] = []
    var allPlaces: [String] = []
    
}
