//
//  GlobalConfiguration.swift
//  OcsProgrames
//
//  Created by Abdelkarim MEDIANA on 06/10/2022.
//

import Foundation



private var configSharedInstance: GlobalConfiguration!

enum HTTPMethod {
    case get
    case post
    case patch
    case delete
}

class GlobalConfiguration {

    
    static var baseUrl = "https://api.ocs.fr/apps/"
    static var baseImageUrl = "https://api.ocs.fr"

    var webServices = [String: Any]()

    // MARK: - Setup

    class func setup() {
        configSharedInstance = GlobalConfiguration()
        configSharedInstance.initWebServices()
    }

    class var sharedInstance: GlobalConfiguration! {
        if configSharedInstance == nil {
            print("error: shared called before setup")
        }
        return configSharedInstance
    }

    // MARK: - Webservice

    func initWebServices() {
        
        // Program
        addWebService(name: .wsGetProgram, url: "v2/contents?search=title%3DGame", method: .get, demo: "getProgram")
        addWebService(name: .wsGetProgramDetail, url: "v2/details/%@", method: .get, demo: "getDetails")

    }

    func addWebService(name: String, baseUrl: String = baseUrl, url: String, method: HTTPMethod, demo: String = "") {
        var dic: [String: Any] = [:]

        dic[.wsUrl] = baseUrl + url
        dic[.wsMethod] = method
        dic[.wsDemo] = demo

        configSharedInstance.webServices[name] = dic
    }
}
