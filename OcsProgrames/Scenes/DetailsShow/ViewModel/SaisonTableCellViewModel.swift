//
//  SaisonTableCellViewModel.swift
//  OcsProgrames
//
//  Created by Abdelkarim MEDIANA on 13/10/2022.
//

import Foundation

class SaisonTableCellViewModel {
    var id: String
    var name: String
    var pitch: String
    var episodes: String
    var image: String
    
    init(saison: Detail.Season) {
        self.id = saison.id
        self.name = saison.menutitle.first?.value ?? ""
        self.pitch = saison.pitch
        var _nbr = 0
        if let nbr = saison.episodes?.count {
            _nbr = nbr
        }
        self.episodes = "nombre des épisodes : \(String(describing: _nbr))"
        self.image = GlobalConfiguration.baseImageUrl + saison.imageurl
    }
   
}
