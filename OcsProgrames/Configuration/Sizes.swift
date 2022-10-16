//
//  Sizes.swift
//  OcsProgrames
//
//  Created by Abdelkarim MEDIANA on 13/10/2022.
//

import UIKit

let isIpad = UIDevice.current.userInterfaceIdiom == .pad

enum Sizes {
    static var showCellHeight: CGFloat {
        if isIpad {
            return 200
        }else {
            return 120
        }
    }
    
    static var saisonCellHeight: CGFloat {
        if isIpad {
            return 160
        }else {
            return 100
        }
    }
}
