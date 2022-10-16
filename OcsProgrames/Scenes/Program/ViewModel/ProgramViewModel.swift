//
//  ProgramViewModel.swift
//  OcsProgrames
//
//  Created by Abdelkarim MEDIANA on 06/10/2022.
//

import Foundation
import Combine

class ProgramViewModel {
    
    var isLoadingData: Observable<Bool> = Observable(false)
    var dataSource: Program.DisplayProgramData?
    var shows: Observable<[ShowTableCellViewModel]> = Observable(nil)
    
    private var cancellables = Set<AnyCancellable>()
    
    // Fetch Data
    func getProgramContents() {
        Indicator.sharedInstance.showIndicator()
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
                print(viewModel)
                self.dataSource = viewModel.program
                Indicator.sharedInstance.hideIndicator()
                self.mapShowData()
            }
            .store(in: &cancellables)
    }
    
    // Binding
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.contents.count ?? 0
    }
    
    private func mapShowData() {
        shows.value = self.dataSource?.contents.compactMap({ShowTableCellViewModel(show: $0)})
    }
    
    func getShowTitle(_ show: Program.DisplayContent) -> String {
        return show.title.first?.value ?? ""
    }
    
    func retriveShow(withId id: String) -> Program.DisplayContent? {
        guard let show = dataSource?.contents.first(where: {$0.id == id}) else {
            return nil
        }
        
        return show
    }

}
