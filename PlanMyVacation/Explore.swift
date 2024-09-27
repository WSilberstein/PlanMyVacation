//
//  ExplorePage.swift
//  PlanMyVacation
//
//  Created by Simran Ajwani on 11/27/21.
//
// Yelp API Source: https://www.yelp.com/developers/documentation/v3/get_started

import UIKit
import MapKit
import CoreLocation

class Explore: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,MKMapViewDelegate, CLLocationManagerDelegate, UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
        return self.createContextMenu()
            }
    }
    @IBOutlet weak var exploreTitle: UILabel!
    
    @IBOutlet weak var cityName: UILabel!
        
    var timer = Timer()
    var counter = 0
    var imgArr = [ UIImage(named: "us1"),
                   UIImage(named: "us2"),
                   UIImage(named: "us3"),
                   UIImage(named: "us4"),
                   UIImage(named: "us5"),
                   UIImage(named: "us6"),
                   UIImage(named: "us7"),
                   UIImage(named: "us8"),
                   UIImage(named: "us9"),
                   UIImage(named: "us10")
    ]
    var text = ["San Francisco", "Las Vegas", "St. Louis", "Manhattan", "Denver", "Flagstaff", "Salt Lake City", "Detroit", "Seattle", "Miami"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    //citation: https://www.youtube.com/watch?v=cbeE3OQlU3c
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.image = imgArr[indexPath.row]
        }
        return cell
    }
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var sliderCollectionView: UICollectionView!

    //citation: https://www.youtube.com/watch?v=cbeE3OQlU3c
    override func viewDidLoad() {
        super.viewDidLoad()
        exploreTitle.text = "Explore US!"
        cityName.text = "Visit San Francisco"
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        pageController.numberOfPages = imgArr.count
        pageController.currentPage = 0

        let interaction = UIContextMenuInteraction(delegate: self)
        view.addInteraction(interaction)
        view.isUserInteractionEnabled = true
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createContextMenu() -> UIMenu {
    let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
        print("Share")
        self.shareButtonClicked()
    }
    let exploreUS = UIAction(title: "Explore US", image: UIImage(systemName: "doc.on.doc")) { _ in
        self.imgArr = [ UIImage(named: "us1"),
                       UIImage(named: "us2"),
                       UIImage(named: "us3"),
                       UIImage(named: "us4"),
                       UIImage(named: "us5"),
                       UIImage(named: "us6"),
                       UIImage(named: "us7"),
                       UIImage(named: "us8"),
                       UIImage(named: "us9"),
                       UIImage(named: "us10")
        ]
        self.text = ["San Francisco", "Las Vegas", "St. Louis", "Manhattan", "Denver", "Flagstaff", "Salt Lake City", "Detroit", "Seattle", "Miami"]
        self.exploreTitle.text = "Explore US!"

    }
    let exploreCanada = UIAction(title: "Explore Canada", image: UIImage(systemName: "doc.on.doc")) { _ in
        self.imgArr = [ UIImage(named: "canada1"),
                           UIImage(named: "canada2"),
                           UIImage(named: "canada3"),
                           UIImage(named: "canada4"),
                           UIImage(named: "canada5"),
                           UIImage(named: "canada1"),
                           UIImage(named: "canada2"),
                           UIImage(named: "canada3"),
                           UIImage(named: "canada4"),
                           UIImage(named: "canada5")
            ]
        self.text = ["Vancouver", "Montreal", "Toronto", "Calgary", "Ottawa","Vancouver", "Montreal", "Toronto", "Calgary", "Ottawa"]
        self.exploreTitle.text = "Explore Canada!"
        }
    let saveToPhotos = UIAction(title: "Add To Photos", image: UIImage(systemName: "photo")) { _ in
        for image in self.imgArr{
            if let savedimage = image {
            UIImageWriteToSavedPhotosAlbum(savedimage, nil, nil, nil)
            }
        }
        let alertController = UIAlertController(title: "Saved!", message: "All the images have been saved to your camera roll", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title:"Ok", style: .default))
        self.present(alertController, animated: true)
    }
    
        return UIMenu(title: "", children: [shareAction, exploreUS, exploreCanada, saveToPhotos])
    }
    
    func shareButtonClicked(){
        if(self.exploreTitle.text == "Explore US!"){
            let message = "Check out this info on top US cities!"
            if let link = NSURL(string: "https://travel.usnews.com/rankings/best-usa-vacations/")
            {
                let objectsToShare = [message,link] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                self.present(activityVC, animated: true, completion: nil)
            }
        }
        
        else{
            let message = "Check out this info on top Canadian cities!"
            if let link = NSURL(string: "https://travel.usnews.com/rankings/best-canada-vacations/")
            {
                let objectsToShare = [message,link] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                self.present(activityVC, animated: true, completion: nil)
            }
        }
    }
    
    func notifyUser(heading: String, note: String){
        let alertController = UIAlertController(title: heading, message: note, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title:"Ok", style: .default))
        present(alertController, animated: true)
       }
    
    //citation: https://www.youtube.com/watch?v=cbeE3OQlU3c
    @objc func changeImage() {
     if counter < imgArr.count {
         let index = IndexPath.init(item: counter, section: 0)
         self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
         pageController.currentPage = counter
        cityName.text = "Visit " + text[counter]
        counter += 1
     } else {
         counter = 0
         let index = IndexPath.init(item: counter, section: 0)
         self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
         pageController.currentPage = counter
        cityName.text = "Visit " + text[counter]
         counter = 1
     }
         
     }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension Explore: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
