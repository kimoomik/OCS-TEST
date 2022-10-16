//
//  ProgramViewModelTests.swift
//  OcsProgramesTests
//
//  Created by Abdelkarim MEDIANA on 14/10/2022.
//


@testable import OcsProgrames
import XCTest
import Combine

private let PROGRAMS_LIST_COUNT = 2


final class ProgramViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    var response: Program.DisplayProgramData?

    override func setUp() {
        super.setUp()

        NetworkManager.shared.getData(from: .wsGetProgram, type: Program.ProgramData.self)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Erreur c'est \(err.localizedDescription)")
                case .finished:
                    print("Terminer")
                }
                
            }
            receiveValue: { programData in
                let viewModel =  Program.Fetch.ViewModel(response: programData)
                self.response = viewModel.program
            }
            .store(in: &cancellables)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testProgramsFromJSONNotNil() {
        XCTAssertNotNil(5)
    }

    func testProgramsFromJSONCountCorrect() {
        XCTAssertGreaterThan(response?.contents.count ?? 0, PROGRAMS_LIST_COUNT)
    }

   
}
