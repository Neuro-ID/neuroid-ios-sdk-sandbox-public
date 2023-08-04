//
//  NIOnbardingVC.swift
//  NeuroIdExample
//
//  Created by jose perez on 12/05/22.
//
import UIKit
import Neuro_ID
final class NIOnbardingVC: UIViewController {
    @IBOutlet weak var sessionidlbl: UITextField!
    @IBOutlet weak var firstNamelbl: UITextField!
    @IBOutlet weak var lastNamelbl: UITextField!
    @IBOutlet weak var dateBirthlbl: UITextField!
    @IBOutlet weak var emaillbl: UITextField!
    @IBOutlet weak var homeCitylbl: UITextField!
    @IBOutlet weak var homeZipCodelbl: UITextField!
    @IBOutlet weak var phoneNumberlbl: UITextField!
    @IBOutlet weak var employerlbl: UITextField!
    @IBOutlet weak var employerAddresslbl: UITextField!
    @IBOutlet weak var employerPhoneNumberlbl: UITextField!
    
    override func viewDidLoad() {
        let id = NeuroID.getSessionID()
        sessionidlbl.id = "sessionidlbl"
        firstNamelbl.id = "firstName"
        lastNamelbl.id = "lastName"
        dateBirthlbl.id = "dobMonth"
        emaillbl.id = "email"
        homeCitylbl.id = "city"
        homeZipCodelbl.id = "homeZipCode"
        phoneNumberlbl.id = "phoneNumber"
        employerlbl.id = "employerlbl"
        employerAddresslbl.id = "streetAddressLine1"
        employerPhoneNumberlbl.id = "employerPhoneNumberlbl"

        super.viewDidLoad()
        setupKeyboardHiding()
        setupNavBarImage()
        setupTextFieldDelegate()
        setupDateBirthPicker()
        sessionidlbl.text = id
//      NeuroID.setUserID("nid_ios_\(NSDate().timeIntervalSince1970)")
    }
    /// Create and setup the date picker as the input for date birth
    private func setupDateBirthPicker() {
        // Create Data picker and add to the input view
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: view.frame.width,
                                                    height: 216))
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        self.dateBirthlbl.inputView = datePicker
        // Create Toolbar to select date and add to the input accessory view
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.frame.width,
                                              height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction)),
                          UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
                          UIBarButtonItem(barButtonSystemItem: .done, target: self, action:  #selector(doneAction))],
                         animated: true)
        self.dateBirthlbl.inputAccessoryView = toolBar
    }
    /// Setup navigation bar image with logo
    private func setupNavBarImage() {
        self.navigationController?.isNavigationBarHidden = false
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFill
        let image = UIImage(named: "NeuroID_logo")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    /// Asing the view delegae to textfields
    private func setupTextFieldDelegate() {
        self.sessionidlbl.delegate = self
        self.firstNamelbl.delegate = self
        self.lastNamelbl.delegate = self
        self.dateBirthlbl.delegate = self
        self.emaillbl.delegate = self
        self.homeCitylbl.delegate = self
        self.homeZipCodelbl.delegate = self
        self.phoneNumberlbl.delegate = self
        self.employerlbl.delegate = self
        self.employerAddresslbl.delegate = self
        self.employerPhoneNumberlbl.delegate = self
    }
    /// Hide the date picker
    @objc func cancelAction() {
        self.dateBirthlbl.resignFirstResponder()
    }
    /// Transform date into text and show it
    @objc func doneAction() {
        if let datePickerView = self.dateBirthlbl.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let dateString = dateFormatter.string(from: datePickerView.date)
            self.dateBirthlbl.text = dateString
            self.dateBirthlbl.resignFirstResponder()
        }
    }
    @IBAction func continueAction(_ sender: Any) {
        let vc = NILoanOptionsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension NIOnbardingVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
