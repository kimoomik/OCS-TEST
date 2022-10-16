//
//  ShowTableCellViewModel.swift
//  OcsProgrames
//
//  Created by Abdelkarim MEDIANA on 11/10/2022.
//

import Foundation


class ShowTableCellViewModel {
    var id: String
    var name: String
    var types: String
    var detailsLink: String
    var duration: String
    var image: String
    
    init(show: Program.DisplayContent) {
        self.id = show.id
        self.name = show.title.first?.value ?? ""
        self.types = show.subtitle
        self.detailsLink = show.detaillink
        var showTime = show.duration.replacingOccurrences(of: "PT", with: "")
        showTime = showTime.replacingOccurrences(of: "M", with: ":")
        showTime = showTime.replacingOccurrences(of: "H", with: ":")
        showTime = showTime.replacingOccurrences(of: "S", with: "")
        self.duration = showTime
        self.image = GlobalConfiguration.baseImageUrl + show.imageurl
    }
   
}
