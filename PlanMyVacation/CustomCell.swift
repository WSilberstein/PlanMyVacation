//
//  CustomCell.swift
//  PlanMyVacation
//
//  Created by Simran Ajwani on 11/13/21.
//
// Yelp API Source: https://www.yelp.com/developers/documentation/v3/get_started

import UIKit

class CustomCell: UITableViewCell {

    var restaurants: Restaurants?
    var image: UIImage?
    var locationName: String?
    var categoryType: String?
    var numRestaurants: Int = 0
    var numHotels: Int = 0
    var numLandmarks: Int = 0
    var numLocations: Int = 0
    var restaurantExists = false
    var hotelExists = false
    var landmarkExists = false
    var allPlacesExist = false
    
    @IBOutlet weak var addedYes: UILabel!
    @IBOutlet weak var cell: UILabel!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        favButton.layer.zPosition = 1
        self.bringSubviewToFront(favButton);
        favButton.isUserInteractionEnabled = true
        selectionStyle = .none
        // Initialization code
        nameLabel.layer.shadowColor = UIColor.darkGray.cgColor
        nameLabel.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        nameLabel.layer.shadowOpacity = 0.5
        nameLabel.layer.shadowRadius = 2
        nameLabel.layer.cornerRadius = 13
        nameLabel.layer.masksToBounds = true
    }
    
    @IBAction func insertFav(_ sender: UIButton!) {
        favButton.setImage(UIImage(named:"starAfter"), for: UIControl.State.highlighted)
        //source for below code: https://cocoacasts.com/ud-5-how-to-store-a-custom-object-in-user-defaults-in-swift
        var cityExists = false
        var cityIndex = 0
        if let data = UserDefaults.standard.data(forKey: "favPlaces") {
            //print("FAVE PLACES EXISTS")
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                // Decode Note
                var storedFavorites = try decoder.decode([FavoritedCity].self, from: data)
                for (index, place) in storedFavorites.enumerated()
                    {
                        if place.cityName == locationName
                        {
                            cityExists = true
                            cityIndex = index
                        }
                    }
                    if cityExists
                    {
                        if categoryType == "restaurants"
                        {
                            
                            for restaurant in storedFavorites[cityIndex].restaurants
                            {
                                if restaurant == nameLabel.text
                                {
                                    print("checking our restaurants" + restaurant)
                                    //print(nameLabel.text)
                                    restaurantExists = true
                                }
                            }
                            if !restaurantExists
                            {
                               //print("restaurant doesn't exist")
                                storedFavorites[cityIndex].restaurants.append(nameLabel.text ?? "")
                                numRestaurants = numRestaurants + 1
                            }
                        }
                        if categoryType == "hotels"
                        {
                            for hotel in storedFavorites[cityIndex].hotels
                            {
                                if hotel == nameLabel.text
                                {

                                    hotelExists = true
                                }
                            }
                            if !hotelExists
                            {
                                storedFavorites[cityIndex].hotels.append(nameLabel.text ?? "")

                            }
                        }
                        if categoryType == "landmarks"
                        {
                            for landmark in storedFavorites[cityIndex].landmarks
                            {
                                if landmark == nameLabel.text
                                {

                                    landmarkExists = true
                                }
                            }
                            if !landmarkExists
                            {
                                storedFavorites[cityIndex].landmarks.append(nameLabel.text ?? "")

                            }
                        }
                        for place in storedFavorites[cityIndex].allPlaces
                        {
                            if place == nameLabel.text
                            {
                                allPlacesExist = true
                            }
                        }
                        if !allPlacesExist
                        {
                            storedFavorites[cityIndex].allPlaces.append(nameLabel.text ?? "")
//                            let pop: UITextField = UITextField(frame: CGRect(x: 5, y: 0, width: 300.00, height: 30.00));
//                            pop.text = "Saved to Favorites"
//                            pop.backgroundColor = UIColor.lightGray
//                            pop.textAlignment = .center
//                            pop.textColor = UIColor.white
//                            self.addSubview(pop)
//                            self.bringSubviewToFront(pop);
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
//                                pop.isHidden = true
//                             }
                        } else {
//                            let pop: UITextField = UITextField(frame: CGRect(x: 5, y: 0, width: 300.00, height: 30.00));
//                            pop.text = "Already Saved to Favorites"
//                            pop.backgroundColor = UIColor.lightGray
//                            pop.textAlignment = .center
//                            pop.textColor = UIColor.white
//                            self.addSubview(pop)
//                            self.bringSubviewToFront(pop);
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
//                                pop.isHidden = true
//                             }
                        }
                       
                        do {
                            // Create JSON Encoder
                            let encoder = JSONEncoder()
                            // Encode Note
                            let data = try encoder.encode(storedFavorites)
                            UserDefaults.standard.set(data, forKey: "favPlaces")
                        } catch {
                            print("Unable to Encode Note (\(error))")
                        }
                    }
                    else
                    {
                        let currCity = FavoritedCity()
                        currCity.cityName = locationName!
                        if categoryType == "restaurants"
                        {
                            for restaurant in storedFavorites[cityIndex].restaurants
                            {
                                if restaurant == nameLabel.text
                                {
                                    print("checking our restaurants" + restaurant)
                                    restaurantExists = true
                                }
                            }
                            if !restaurantExists
                            {
                                print("restaurant doesn't exist")
                                currCity.restaurants.append(nameLabel.text ?? "")
                                numRestaurants = numRestaurants + 1
                            }
                        }
                        if categoryType == "hotels"
                        {
                            for hotel in storedFavorites[cityIndex].hotels
                            {
                                if hotel == nameLabel.text
                                {
                                    hotelExists = true
                                }
                            }
                            if !hotelExists
                            {
                                currCity.hotels.append(nameLabel.text ?? "")
                            }
                        }
                        if categoryType == "landmarks"
                        {
                            for landmark in storedFavorites[cityIndex].landmarks
                            {
                                if landmark == nameLabel.text
                                {
                                    landmarkExists = true
                                }
                            }
                            if !landmarkExists
                            {
                                currCity.landmarks.append(nameLabel.text ?? "")
                            }
                        }
                        for place in storedFavorites[cityIndex].allPlaces
                        {
                            if place == nameLabel.text
                            {
                                allPlacesExist = true
                            }
                        }
                        if !allPlacesExist
                        {
                            currCity.allPlaces.append(nameLabel.text ?? "")
//                            let pop: UITextField = UITextField(frame: CGRect(x: 5, y: 0, width: 300.00, height: 30.00));
//                            pop.text = "Saved to Favorites"
//                            pop.backgroundColor = UIColor.lightGray
//                            pop.textAlignment = .center
//                            pop.textColor = UIColor.white
//                            self.addSubview(pop)
//                            self.bringSubviewToFront(pop);
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
//                                pop.isHidden = true
//                             }
                        } else {
//                            let pop: UITextField = UITextField(frame: CGRect(x: 5, y: 0, width: 300.00, height: 30.00));
//                            pop.text = "Already Saved to Favorites"
//                            pop.backgroundColor = UIColor.lightGray
//                            pop.textAlignment = .center
//                            pop.textColor = UIColor.white
//                            self.addSubview(pop)
//                            self.bringSubviewToFront(pop);
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
//                                pop.isHidden = true
//                             }
                        }
                        
                        do {
                            // Create JSON Encoder
                            let encoder = JSONEncoder()

                            // Encode Note
                            storedFavorites.append(currCity)
                            let data = try encoder.encode(storedFavorites)
                            UserDefaults.standard.set(data, forKey: "favPlaces")
                        } catch {
                            print("Unable to Encode Note (\(error))")
                        }
                    }
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
    }
}
