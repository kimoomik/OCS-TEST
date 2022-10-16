//
//  Details.swift
//  OcsProgrames
//
//  Created by Abdelkarim MEDIANA on 13/10/2022.
//

import Foundation

enum Detail {
    
    
    struct Show: Decodable, Hashable {
        let template: String
        let parentalrating, categoryID: Int
        let contents: Contents
    }

    // MARK: - Contents
    struct Contents: Decodable, Hashable {
        let title: [Program.Title]
        let id: String
        let highlightid, selectid: String?
        let isbookmarkable: Bool
        let detaillink: String?
        let seasons: [Season]?
        let acontents: [ContentsAcontent]?
    }

    // MARK: - ContentsAcontent
    struct ContentsAcontent: Decodable, Hashable {
        let type: String
        let acontentDescription: [Title]
        let link, imageurl: String
        let contents: [Content]

        enum CodingKeys: String, CodingKey {
            case type
            case acontentDescription = "description"
            case link, imageurl, contents
        }
    }

    // MARK: - Title
    struct Title: Decodable, Hashable {
        let type: String
        let value: String
        let color: String?
    }

    // MARK: - Content
    struct Content: Decodable, Hashable {
        let title: [Title]
        let subtitle: String?
        let subtitlefocus: String?
        let playinfoid: Program.Playinfoid
        let duration: String
        let playinfo: Playinfo
        let highrighticon: String?
        let highlefticon: [String]?
        let lowrightinfo: String?
        let imageurl, fullscreenimageurl, detaillink, id: String?
    }

    // MARK: - Playinfo
    struct Playinfo: Decodable, Hashable {
        let tokenurl, url: String?
    }


    // MARK: - Season
    struct Season: Decodable, Hashable {
        let menutitle: [Program.Title]
        let subtitle: String
        let number: Int
        let id, pitch, imageurl: String
        let isbookmarkable: Bool
        let episodes: [Episode]?
        let highlefticon: [String]
        let acontents: [SeasonAcontent]
    }

    // MARK: - SeasonAcontent
    struct SeasonAcontent: Decodable, Hashable {
        let type: String
        let acontentDescription: [Program.Title]
        let contents: [Content]

        enum CodingKeys: String, CodingKey {
            case type
            case acontentDescription = "description"
            case contents
        }
    }

    // MARK: - Episode
    struct Episode: Decodable, Hashable {
        let parentalrating: Int
        let isbookmarkable, isdownloadable: Bool
        let number: Int
        let title: [Program.Title]
        let duration: String
        let availability, menutitle, menutitlefocus: [Program.Title]
        let summary: String
        let highlefticon: [String]
        let highrighticon, subtitle, subtitlefocus: String?
        let pitch: String
        let bannerinfo: [Program.Title]
        let episodeDescription: [[String?]]
        let imageurl, fullscreenimageurl: String
        let linearplanning: String?
        let acontents: [EpisodeAcontent]?
        let playinfoid: Program.Playinfoid
        let playinfo: Playinfo
        let id: String
        let zonesinfo: Zonesinfo

        enum CodingKeys: String, CodingKey {
            case parentalrating, isbookmarkable, isdownloadable, number, title, duration, availability, menutitle, menutitlefocus, summary, highlefticon, highrighticon, subtitle, subtitlefocus, pitch, bannerinfo
            case episodeDescription = "description"
            case imageurl, fullscreenimageurl, linearplanning, acontents, playinfoid, playinfo, id, zonesinfo
        }
    }

    // MARK: - EpisodeAcontent
    struct EpisodeAcontent: Decodable, Hashable {
        let type: AcontentType
        let acontentDescription: [Program.Title]
        let contents: [Content]

        enum CodingKeys: String, CodingKey {
            case type
            case acontentDescription = "description"
            case contents
        }
    }

    enum AcontentType: String, Codable {
        case reco = "reco"
        case teasers = "teasers"
    }

    // MARK: - Zonesinfo
    struct Zonesinfo: Decodable, Hashable {
        let duration: Int
        let endcreditsautocompleted: Bool
        let previouslytcin, previouslytcout: String?
        let startcreditstcin, startcreditstcout, endcreditstcin, endcreditstcout: Int
    }



    enum Fetch {
        struct Request {
            var id: String
        }

        typealias Response = Show

        struct ViewModel {}
    }
    
}
