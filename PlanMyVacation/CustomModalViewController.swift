//
//  CustomModalViewController.swift
//  PlanMyVacation
//
//  Created by Simran Ajwani on 12/1/21.
//
// Yelp API Source: https://www.yelp.com/developers/documentation/v3/get_started

import UIKit

class CustomModalViewController: UIViewController {
    @IBOutlet weak var helpInfo: UILabel!
    
    var restaurants: Restaurants?
    var reviews: Reviews?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Need some help?"
        label.textColor =  UIColor(red: 0.40, green: 0.62, blue: 0.47, alpha: 1)
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var notesLabel: UILabel = {
        let label = UILabel()
        label.text = "For each location, you get provided additional information. Options include pricing, rating, address, phone number, and availability. For detailed information, feel free to click the Yelp button. To look at most recent reviews, click the reviews button. For any additional help, please contact +1 123-456-7890"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [titleLabel, notesLabel, spacer])
        stackView.axis = .vertical
        stackView.spacing = 12.0
        return stackView
    }()
    
    
    lazy var containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 16
            view.clipsToBounds = true
            return view
        }()
    
    
    let maxDimmedAlpha: CGFloat = 0.6
        lazy var dimmedView: UIView = {
            let view = UIView()
            view.backgroundColor = .black
            view.alpha = maxDimmedAlpha
            return view
        }()
        
        let defaultHeight: CGFloat = 300
    
    var containerViewHeightConstraint: NSLayoutConstraint?
        var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animateShowDimmedView()
        animatePresentContainer()
    }
    //source: https://betterprogramming.pub/how-to-present-a-bottom-sheet-view-controller-in-ios-a5a3e2047af9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        }

    @objc func handleCloseAction() {
        animateDismissView()
    }
    
    func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.view.layoutIfNeeded()
        }
                dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    //source: https://betterprogramming.pub/how-to-present-a-bottom-sheet-view-controller-in-ios-a5a3e2047af9
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func setupConstraints() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
        ])
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
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
