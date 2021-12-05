//
//  EditProfileViewController.swift
//  PlanMyVacation
//
//  Created by William Silberstein on 12/1/21.
//

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
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
        profilePicture.addGestureRecognizer(tapGestureRecognizer)
        reload()
    }
    
    @objc func didTapImageView(_ sender: UITapGestureRecognizer) {
        print("did tap image view", sender)

        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        profilePicture.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
    
    /*
     *  addProfileViewController: Adds a ProfileViewController to this view
     */
    func addProfileViewController(profileViewController: ProfileViewController) {
        self.profileViewController = profileViewController
    }
    
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
        print("Saving user data")
        guard let safeProfileViewController = profileViewController else { return }
        if let safeUsername = userNameInput.text {
            profileController.username = safeUsername
        }
        
        if let safeProfilePicture = profilePicture.image {
            profileController.profilePicture = safeProfilePicture
        }
        if(profileController.saveUserInfo()) {
            safeProfileViewController.reload()
        }
    }
}
