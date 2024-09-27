//
//  ProfileController.swift
//  PlanMyVacation
//
//  Created by William Silberstein on 12/1/21.
//
// Yelp API Source: https://www.yelp.com/developers/documentation/v3/get_started

import Foundation
import UIKit

class ProfileController {
    
    var username: String?
    var profilePicture: UIImage?
    var favoriteCities: [FavoritedCity]?
    var cityCount: Int?
    var hotelCount: Int?
    var resterauntCount: Int?
    var landmarkCount: Int?
    
    /*
     * getUserInfo: Gets all of the user's saved information from the user defaults
     *              and reloads all of the local variables
     */
    func getUserInfo() {
        
        // Make sure user data exists
        guard let userData = UserDefaults.standard.data(forKey: "userData") else {
            print("Could not get user data")
            return
        }
        
        do {
            
            let decoder = JSONDecoder()
            
            // Decode user profile and store the username
            let userProfile = try decoder.decode(Profile.self, from: userData)
            username = userProfile.username
            
            // Decode user profile picture and store the image
            if let safeProfilePicture = userProfile.profilePicture {
                profilePicture = UIImage(data: safeProfilePicture)
            }
            
            // Make sure user has saved favorite locations
            guard let favPlacesData = UserDefaults.standard.data(forKey: "favPlaces") else {
                print("Could not get favorite places")
                return
                
            }
            
            let storedFavorites = try decoder.decode([FavoritedCity].self, from: favPlacesData)
            
            favoriteCities = storedFavorites
            favoriteCities?.remove(at: 0)
            
            // Count the amount of cities, hotels, resteraunts, and landmarks
            guard let safeCities = favoriteCities else { return }
            
            var cities = 0
            var hotels = 0
            var resteraunts = 0
            var landmarks = 0
            
            for city in safeCities {
                cities+=1;
                for _ in city.restaurants {
                    resteraunts+=1
                }
                
                for _ in city.hotels {
                    hotels+=1
                }
                
                for _ in city.landmarks {
                    landmarks+=1
                }
            }
            
            cityCount = cities
            hotelCount = hotels
            resterauntCount = resteraunts
            landmarkCount = landmarks
            
        } catch {
            print(error)
        }
    }
    
    /*
     *  saveUserInfo: Attempts to save the user information into the user defaults
     */
    func saveUserInfo() -> Bool {
        let profile: Profile = Profile()
        profile.username = username
        profile.profilePicture = profilePicture?.pngData();

        do {
            
            // Encode user data and save to user defaults
            let encoder = JSONEncoder()
            let data = try encoder.encode(profile)
            UserDefaults.standard.setValue(data, forKey: "userData")
        } catch {
            return false
        }
        return true
    }
    
    /*
     *  getUsername: Returns an optional of the username
     */
    func getUsername() -> String? {
        return username
    }
    
    /*
     *  getProfilePicture: Returns an optional of the user's profile picture
     */
    func getProfilePicture() -> UIImage? {
        return profilePicture
    }
    
    /*
     *  getFavoriteCities: Returns an optional of the user's favorite cities
     */
    func getFavoriteCities() -> [FavoritedCity]? {
        return favoriteCities
    }
}
