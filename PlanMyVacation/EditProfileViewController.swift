//
//  EditProfileViewController.swift
//  PlanMyVacation
//
//  Created by William Silberstein on 12/1/21.
//
// Yelp API Source: https://www.yelp.com/developers/documentation/v3/get_started

import Foundation
import UIKit
class EditProfileViewController: UIViewController,  UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    /*
     *  saveBtnPressed: Action that dismisses the edit view controller and
     *                  saves the user's data when pressed
     */
    @IBAction func saveBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: save)
    }
    
    /*
     *  cancelBtnPressed: Action that dismisses the edit view controller and
     *                    does not save the user information
     */
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var citiesCount: UILabel!
    @IBOutlet weak var resterauntCount: UILabel!
    @IBOutlet weak var hotelsCount: UILabel!
    @IBOutlet weak var test: UIImageView!
    @IBOutlet weak var landmarksCount: UILabel!
    
    let profileController: ProfileController = ProfileController()
    var profileViewController: ProfileViewController?
    var imagePicker = UIImagePickerController()
    
    /*
     *  viewDidLoad: Instantiates profile controller and all UI components
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self;
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false

        profileController.getUserInfo()
    
        userNameInput.text = profileController.getUsername()
        
        // Add tep gesture recognizer to profile picture view to allow user to set image
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(didTapAnywhere(_:)))
        
        profilePicture.addGestureRecognizer(tapGestureRecognizer)
        view.addGestureRecognizer(tapGestureRecognizer2)
        reload()
    }
    
    /*
     *  didTapImageView: Action that displays the image picker when the user taps on the profile picture
     */
    @objc func didTapImageView(_ sender: UITapGestureRecognizer) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func didTapAnywhere(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    /*
     *  imagePickerController: Sets the user profile image when image is selected and dismisses the image picker
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        profilePicture.image = image
        dismiss(animated: true, completion: nil)
    }
    
    /*
     *  imagePickerControllerDidCancel: Dismisses the image picker when user closes the picker
     */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
    
    /*
     *  addProfileViewController: Adds a ProfileViewController to this view
     */
    func addProfileViewController(profileViewController: ProfileViewController) {
        self.profileViewController = profileViewController
    }
    
    /*
     *  reload: Reloads the view UI.
     */
    func reload() {
        if let safeProfilePicture = profileController.getProfilePicture() {
            profilePicture.image = safeProfilePicture
        }
        
        if let safeUsername = profileController.getUsername() {
            userNameInput.text = safeUsername
        }
        
        if let cities = profileController.cityCount {
            citiesCount.text = String(cities)
        }
        
        if let resteraunts = profileController.resterauntCount {
            resterauntCount.text = String(resteraunts)
        }
        
        if let hotels = profileController.hotelCount {
            hotelsCount.text = String(hotels)
        }
        
        if let landmarks = profileController.landmarkCount {
            landmarksCount.text = String(landmarks)
        }
    }
    
    /*
     *  save: Saves the user's info using the ProfileController. Reloads the
     *        user's profile page with the new data on success
     */
    func save() {
        
        // Make sure profileViewController exists
        guard let safeProfileViewController = profileViewController else { return }
        if let safeUsername = userNameInput.text {
            profileController.username = safeUsername
        }
        
        if let safeProfilePicture = profilePicture.image {
            profileController.profilePicture = safeProfilePicture
        }
        
        // If successful save reload view UI
        if(profileController.saveUserInfo()) {
            safeProfileViewController.reload()
        }
    }
}
