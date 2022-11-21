//
//  NISimpleCell.swift
//  NeuroIdExample
//
//  Created by jose perez on 09/11/22.
//
import UIKit
import Neuro_ID
final class NISimpleCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func setupCell(title: String) {
        self.title.text = title
    }
}
