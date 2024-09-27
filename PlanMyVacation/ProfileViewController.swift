//
//  ProfileViewController.swift
//  PlanMyVacation
//
//  Created by William Silberstein on 12/1/21.
//
// Yelp API Source: https://www.yelp.com/developers/documentation/v3/get_started

import Foundation
import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    /*
     * tableView: Returns the amount of rows for the table. Default set to 10 rows
     *            If there is user data then the rows will equal the amount of cities
     *            the user has saved.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cityCount = profileController.cityCount {
            return cityCount
        }
        return 10
    }
    
    /*
     * tableView: Displays all of the table data for each cell.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = UITableViewCell(style: .default, reuseIdentifier: "tableViewCell")
        
        // Alternate cell color
        if(indexPath.row % 2 == 0){
            myCell.backgroundColor = UIColor.lightGray
        }
        else{
            myCell.backgroundColor = UIColor.gray
        }
    
        // Style cell
        myCell.textLabel?.numberOfLines = 0
        myCell.textLabel?.textColor = UIColor.white
        myCell.textLabel?.textAlignment = .center

        myCell.textLabel?.layer.shadowColor = UIColor.black.cgColor
        myCell.textLabel?.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        myCell.textLabel?.layer.shadowRadius = 1.0
        myCell.textLabel?.layer.shadowOpacity = 0.5
        myCell.layer.cornerRadius = 10
        
        // Set the text of the cell to the name of the city
        if let cityName = profileController.favoriteCities {
            myCell.textLabel?.text = cityName[indexPath.row].cityName
        }
        
        return myCell
    }
    
    /*
     *  editBtn: Action that displays the EditProfileController to the user
     *           so they can input new data to edit their account
     */
    @IBAction func editBtn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let editProfileController = storyBoard.instantiateViewController(identifier: "EditProfileController") as! EditProfileViewController
        
        editProfileController.addProfileViewController(profileViewController: self)
        
        self.present(editProfileController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var citiesCount: UILabel!
    @IBOutlet weak var ResterauntsCount: UILabel!
    @IBOutlet weak var hotelsCount: UILabel!
    @IBOutlet weak var landMarksCount: UILabel!
    @IBOutlet weak var favoritesTableview: UITableView!
    
    let profileController: ProfileController = ProfileController()
    
    /*
     *  viewDidLoad: Called when the view first loads. Sets table data sources and
     *               initializes UI values
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableview.delegate = self;
        favoritesTableview.dataSource = self;
        profileController.getUserInfo()
        reload()
    }
    
    /*
     *  viewWillAppear: Reloads the UI when the view is reentered
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reload()
    }
    
    /*
     *  reload: Reloads all UI Components if they exist.
     */
    func reload() {
        profileController.getUserInfo()
        if let username = profileController.getUsername() {
            usernameLabel.text = username
        }
        
        if let cities = profileController.cityCount {
            citiesCount.text = String(cities)
        }
        
        if let resteraunts = profileController.resterauntCount {
            ResterauntsCount.text = String(resteraunts)
        }
        
        if let hotels = profileController.hotelCount {
            hotelsCount.text = String(hotels)
        }
        
        if let landmarks = profileController.landmarkCount {
            landMarksCount.text = String(landmarks)
        }
        
        if let profilePicture = profileController.profilePicture {
            profilePictureView.image = profilePicture
        }
        
        // Reload the table data
        favoritesTableview.reloadData()

    }
    
}
