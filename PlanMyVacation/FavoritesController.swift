//
//  FavoritesController.swift
//  PlanMyVacation
//
//  Created by Katie Legan on 11/29/21.
//
// Yelp API Source: https://www.yelp.com/developers/documentation/v3/get_started

import Foundation
import UIKit

class FavoritesController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource
{
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    var numOfItems = 0
    var arrayToDisplay:[FavoritedCity] = [] as! [FavoritedCity]
    var selectedCity = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //print("reached")
        
        //source for this code: https://cocoacasts.com/ud-5-how-to-store-a-custom-object-in-user-defaults-in-swift
        if let data = UserDefaults.standard.data(forKey: "favPlaces") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let storedFavorites = try decoder.decode([FavoritedCity].self, from: data)
                numOfItems = storedFavorites.count
                arrayToDisplay = storedFavorites
                pickerView.delegate = self
                pickerView.dataSource = self
                favoritesTableView.dataSource = self
                favoritesTableView.delegate = self
                favoritesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
                favoritesTableView.reloadData()
                //print("reached here")
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
    }
    
    
    //source: https://medium.com/@raj.amsarajm93/create-dropdown-using-uipickerview-4471e5c7d898
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayToDisplay.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayToDisplay[row].cityName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity = row
        favoritesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedCity < arrayToDisplay.count
        {
            return arrayToDisplay[selectedCity].allPlaces.count
        }
        else
        {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = UITableViewCell(style: .default, reuseIdentifier: "tableViewCell")
        //print("trying to display")
        //print(arrayToDisplay[selectedCity].restaurants[indexPath.row])
        if selectedCity > 0
        {
            myCell.textLabel?.text = arrayToDisplay[selectedCity].allPlaces[indexPath.row]
        }
        if(indexPath.row % 2 == 0){
            myCell.backgroundColor = UIColor.lightGray
        }
        else{
            myCell.backgroundColor = UIColor.gray
        }
    
        myCell.textLabel?.numberOfLines = 0
        myCell.textLabel?.textColor = UIColor.white
        myCell.textLabel?.textAlignment = .center

        myCell.textLabel?.layer.shadowColor = UIColor.black.cgColor
        myCell.textLabel?.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        myCell.textLabel?.layer.shadowRadius = 1.0
        myCell.textLabel?.layer.shadowOpacity = 0.5

        myCell.layer.cornerRadius = 10
        
        return myCell
    }
}
