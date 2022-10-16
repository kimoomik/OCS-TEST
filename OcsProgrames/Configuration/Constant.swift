//
//  Constant.swift
//  OcsProgrames
//
//  Created by Abdelkarim MEDIANA on 06/10/2022.
//
import UIKit
import Foundation

public enum DateFormat: String {
    case universal = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
}

extension String {
    // MARK: - Webservice

    static let wsUrl = "WS_URL"
    static let wsMethod = "WS_METHOD"
    static let wsDemo = "WS_DEMO"

    // MARK: - WebService names

    static let wsGetProgram = "WS_GET_PROGRAM"
    static let wsGetProgramDetail = "WS_GET_PROGRAM_DETAILS"

}
