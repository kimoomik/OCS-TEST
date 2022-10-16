//
//  ProgramTableViewCell.swift
//  OcsProgrames
//
//  Created by Abdelkarim MEDIANA on 11/10/2022.
//

import UIKit

class ShowTableViewCell: UITableViewCell {

    static var identifier: String {
        get {
            "ShowTableViewCell"
        }
    }
    
    static func register() -> UINib {
        UINib(nibName: "ShowTableViewCell", bundle: nil)
    }
    
    //IBoutlets:
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(viewModel: ShowTableCellViewModel) {
        self.nameLabel.text = viewModel.name
        self.timeLable.text = viewModel.duration
        self.typesLabel.text = viewModel.types
        self.movieImageView.loadFrom(URLAddress: viewModel.image)
    }
}
