//
//  NILoanOptionsVC.swift
//  NeuroIdExample
//
//  Created by jose perez on 12/05/22.
//
import UIKit
import Neuro_ID
final class NILoanOptionsVC: UIViewController {
    @IBOutlet weak var ageAtWorklbl: UITextField!
    @IBOutlet weak var economicDependentslbl: UITextField!
    
    override func viewDidLoad() {
        ageAtWorklbl.id = "ageAtWorklbl"
        economicDependentslbl.id = "economicDependentslbl"
        super.viewDidLoad()
        setupKeyboardHiding()
        setupNavBarImage()
    }
    @IBAction func onClick(_ sender: Any) {
        NeuroID.closeSession()
        NeuroID.groupAndPOST()
        NeuroID.clearSession()
        
        print("Session Stop")
    }
    /// Setup navigation bar image with logo
    private func setupNavBarImage() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imageView.contentMode = .scaleAspectFill
            let image = UIImage(named: "NeuroID_logo")
            imageView.image = image
            navigationItem.titleView = imageView
    }
}
