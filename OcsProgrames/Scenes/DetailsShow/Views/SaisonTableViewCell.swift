//
//  SaisonTableViewCell.swift
//  OcsProgrames
//
//  Created by Abdelkarim MEDIANA on 13/10/2022.
//

import UIKit

class SaisonTableViewCell: UITableViewCell {
    
    static var identifier: String {
        get {
            "SaisonTableViewCell"
        }
    }
    
    static func register() -> UINib {
        UINib(nibName: "SaisonTableViewCell", bundle: nil)
    }
    
    //IBoutlets:
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var nbrEpisodeLabel: UILabel!
    @IBOutlet weak var showImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(viewModel: SaisonTableCellViewModel) {
        self.titleLabel.text = viewModel.name
        self.pitchLabel.text = viewModel.pitch
        self.nbrEpisodeLabel.text = viewModel.episodes
        self.showImageView.loadFrom(URLAddress: viewModel.image)
    }
    
}


