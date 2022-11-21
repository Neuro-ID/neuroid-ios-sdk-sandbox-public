//
//  NILoanOptionsVC.swift
//  NeuroIdExample
//
//  Created by jose perez on 12/05/22.
//
import UIKit
import Neuro_ID
final class NILoanOptionsVC: UIViewController {
    @IBOutlet weak var contentTableView: UITableView!
    private var dataSource: [String] = ["Welcome!", "Hidden" ,"First Name", "Last Name", "Next"]
    private var newInfo: [String] = ["Address", "Employer Address"]
    override func viewDidLoad() {
        contentTableView.id = "contentTableView"
        super.viewDidLoad()
        setupTableView()
        setupKeyboardHiding()
        setupNavBarImage()
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
    @IBAction func onClick(_ sender: Any) {
        NeuroID.closeSession()
        NeuroID.groupAndPOST()
        NeuroID.clearSession()
        
        print("Session Stop")
    }
    func setupTableView() {
        contentTableView.separatorStyle = .none
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.register(UINib(nibName: "NISimpleCell", bundle: Bundle.main), forCellReuseIdentifier: "simpleCell")
        contentTableView.register(UINib(nibName: "NITextCell", bundle: Bundle.main), forCellReuseIdentifier: "textCell")
        contentTableView.register(UINib(nibName: "NIButtonCell", bundle: Bundle.main), forCellReuseIdentifier: "buttonCell")
        contentTableView.tableFooterView = UIView()
    }
}
extension NILoanOptionsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 ,let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell", for: indexPath) as? NISimpleCell {
            let title = dataSource[indexPath.row]
            cell.setupCell(title: title)
            return cell
        } else if indexPath.row == dataSource.count - 1 ,let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as? NIButtonCell {
            let title = dataSource[indexPath.row]
            cell.setupCell(title: title)
            cell.delegate = self
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as? NITextCell {
            let title = dataSource[indexPath.row]
            cell.setupCell(title: title)
            cell.textfield.delegate
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
extension NILoanOptionsVC: NIButtonCellDelagate {
    func click() {
        if !newInfo.isEmpty {
            let data = newInfo[0]
            newInfo.removeFirst()
            dataSource.insert(data, at: dataSource.count - 1)
            contentTableView.reloadData()
        } else {
            newInfo.append("Random\(Int.random(in: 0...1000))")
            addNewSubview(tag: 1)
        }
    }
    private func addNewSubview(tag: Int) {
        let newView = UIView(frame: CGRect(x: 0, y: contentTableView.frame.size.height + 16, width: self.view.frame.width, height: 70))
        newView.tag = tag
        let newtf = UITextField(frame: CGRect(x: 16, y: 16, width: newView.frame.width - 32, height: 40))
        /// UI TEXTFIELD
        newtf.font = UIFont.systemFont(ofSize: 15)
        newtf.borderStyle = UITextField.BorderStyle.roundedRect
        newtf.autocorrectionType = UITextAutocorrectionType.no
        newtf.keyboardType = UIKeyboardType.default
        newtf.returnKeyType = UIReturnKeyType.done
        newtf.clearButtonMode = UITextField.ViewMode.whileEditing
        newtf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        /// END
        newtf.id = "codeInsertTF\(tag)"
        newView.addSubview(newtf)
        newView.backgroundColor = .clear
        self.view.addSubview(newView)
    }
}
extension NILoanOptionsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
