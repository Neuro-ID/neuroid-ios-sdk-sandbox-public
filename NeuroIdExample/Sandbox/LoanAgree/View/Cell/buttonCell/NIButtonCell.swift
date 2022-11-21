//
//  NIButtonCell.swift
//  NeuroIdExample
//
//  Created by jose perez on 09/11/22.
//
import UIKit
import Neuro_ID

protocol NIButtonCellDelagate {
    func click()
}
final class NIButtonCell : UITableViewCell {
    @IBOutlet weak var button: UIButton!
    var delegate: NIButtonCellDelagate?
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func setupCell(title: String) {
        button.id = title.filter({ !$0.isWhitespace })
        button.setTitle(title, for: .normal)
    }
    @IBAction func buttonAction(_ sender: Any) {
        delegate?.click()
    }
}
