//
//  Program.swift
//  OcsProgrames
//
//  Created by Abdelkarim MEDIANA on 06/10/2022.
//

import Foundation


enum Program {
    
    
    // MARK: - Program Details
    struct ProgramData: Decodable, Hashable {
        let template: String?
        let parentalrating: UInt64?
        let title: String?
        let offset: UInt64?
        let limit, next, previous: String?
        let total, count: UInt64?
        let filter, sort: String?
        let contents: [Content]?
    }
    
    // MARK: - Display Program Details
    struct DisplayProgramData: Decodable, Hashable {
        let template: String
        let parentalrating: UInt64
        let title: String
        let offset: UInt64
        let limit, next, previous: String
        let total, count: UInt64
        let filter, sort: String
        let contents: [DisplayContent]
        
        init(program: ProgramData) {
            template = program.template ?? ""
            parentalrating = program.parentalrating ?? 0
            title = program.title ?? ""
            offset = program.offset ?? 0
            limit = program.limit ?? ""
            next = program.next ?? ""
            previous = program.previous ?? ""
            total = program.total ?? 0
            count = program.count ?? 0
            filter = program.filter ?? ""
            sort = program.sort ?? ""
            contents = program.contents?.map{ DisplayContent(content: $0) }  ?? []
        }
    }
    
    // MARK: - Content
    struct Content:  Decodable, Hashable, Identifiable{
        let id: String
        let title: [Title]?
        let subtitle: String?
        let subtitlefocus: [String]?
        let highlefticon, highrighticon, lowrightinfo: String?
        let imageurl, fullscreenimageurl, detaillink: String?
        let duration: String?
        let playinfoid: Playinfoid?
    }
    
    // MARK: - Display Content
    struct DisplayContent:  Decodable, Hashable, Identifiable{
        let id: String
        let title: [DisplayTitle]
        let subtitle: String
        let subtitlefocus: [String]
        let highlefticon, highrighticon, lowrightinfo: String
        let imageurl, fullscreenimageurl, detaillink: String
        let duration: String
        let playinfoid: DisplayPlayinfoid
        
        init(content: Content){
            id = content.id
            title = content.title?.map{ DisplayTitle(title: $0)} ?? []
            subtitle = content.subtitle ?? ""
            subtitlefocus = content.subtitlefocus ?? []
            highlefticon = content.highlefticon ?? ""
            highrighticon = content.highrighticon ?? ""
            lowrightinfo = content.lowrightinfo ?? ""
            imageurl = content.imageurl ?? ""
            fullscreenimageurl = content.fullscreenimageurl ?? ""
            detaillink = content.detaillink ?? ""
            duration = content.duration ?? ""
            playinfoid =  DisplayPlayinfoid(playInfoId: content.playinfoid!)
        }
    }
    
    

    // MARK: - Playinfoid
    struct Playinfoid: Decodable, Hashable {
        let idHd, idSd, idUhd : String?
        
        enum CodingKeys: String, CodingKey {
            case idHd = "hd"
            case idSd = "sd"
            case idUhd = "uhd"
        }
    }
    
    // MARK: - Display Playinfoid
    struct DisplayPlayinfoid: Decodable, Hashable {
        let idHd, idSd, idUhd : String
        
        init(playInfoId: Playinfoid) {
            idHd = playInfoId.idHd ?? ""
            idSd = playInfoId.idSd ?? ""
            idUhd = playInfoId.idUhd ?? ""
        }
    }

    // MARK: - Title
    struct Title:  Decodable, Hashable {
        let color: String?
        let type: String?
        let value: String?
    }

    // MARK: - Display Title
    struct DisplayTitle:  Decodable, Hashable {
        let color: String
        let type: String
        let value: String
        
        init(title: Title) {
            color = title.color ?? ""
            type = title.type ?? ""
            value = title.value ?? ""
        }
    }

    
    enum Fetch {
        struct Request {}

        typealias Response = ProgramData

        struct ViewModel {
            var program : DisplayProgramData
            
            init(response: Response) {
                program = DisplayProgramData(program: response)
            }
        }
    }



    
}
