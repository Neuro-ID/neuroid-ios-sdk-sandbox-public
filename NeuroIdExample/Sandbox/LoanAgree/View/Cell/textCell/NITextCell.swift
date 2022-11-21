//
//  NITextCell.swift
//  NeuroIdExample
//
//  Created by jose perez on 09/11/22.
//

import UIKit
final class NITextCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var button: UIButton!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func setupCell(title: String) {
        showTextField(false)
        textfield.id = title.filter({ !$0.isWhitespace })
        textfield.delegate = self
        self.title.text = title
        if title == "Hidden" {
            showTextField(true)
        }
    }
    @IBAction func showTextField() {
        showTextField(false)
    }
    private func showTextField(_ isON: Bool) {
        self.title.isHidden = isON
        self.textfield.isHidden = isON
        self.button.isHidden = !isON
    }
}
extension NITextCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
