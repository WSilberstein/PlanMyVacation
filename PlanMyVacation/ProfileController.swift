//
//  ProfileController.swift
//  PlanMyVacation
//
//  Created by William Silberstein on 12/1/21.
//

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
        guard let userData = UserDefaults.standard.data(forKey: "userData") else {
            print("Could not get user data")
            return
            
        }
        
        do {
            
            let decoder = JSONDecoder()
            let userProfile = try decoder.decode(Profile.self, from: userData)
            username = userProfile.username
            
            guard let favPlacesData = UserDefaults.standard.data(forKey: "favPlaces") else {
                print("Could not get favorite places")
                return
                
            }
            
            let storedFavorites = try decoder.decode([FavoritedCity].self, from: favPlacesData)
            
            if let safeProfilePicture = userProfile.profilePicture {
                profilePicture = UIImage(data: safeProfilePicture)
            }
            
            favoriteCities = storedFavorites
            //favoriteCities[1].restaurants
            guard let safeCities = favoriteCities else { return }
            
            var cities = 0
            var hotels = 0
            var resteraunts = 0
            var landmarks = 0
            
            for city in safeCities {
                cities+=1;
                for resteraunt in city.restaurants {
                    resteraunts+=1
                }
                
                for hotel in city.hotels {
                    hotels+=1
                }
                
                for landmark in city.landmarks {
                    landmarks+=1
                }
            }
            
            cityCount = cities - 1
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
            let encoder = JSONEncoder()
            let data = try encoder.encode(profile)
            UserDefaults.standard.setValue(data, forKey: "userData")
        } catch {
            print(error)
            return false
        }
        print("Success")
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
