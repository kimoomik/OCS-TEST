//
//  DetailsViewModel.swift
//  OcsProgrames
//
//  Created by Abdelkarim MEDIANA on 13/10/2022.
//

import Foundation
import Combine

class DetailViewModel {
    
    var error : Observable<String> = Observable<String>(nil)
    var isLoadingData: Observable<Bool> = Observable(false)
    var dataSource: Detail.Show?
    var saisons: Observable<[SaisonTableCellViewModel]> = Observable(nil)
    
    private var cancellables = Set<AnyCancellable>()
    
    // Fetch Data
    func getShowsOfProgram(id: String) {
        Indicator.sharedInstance.showIndicator()
        NetworkManager.shared.getData(from: .wsGetProgramDetail, type: Detail.Show.self,path: id)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Erreur c'est \(err.localizedDescription)")
                    self.error.value = err.localizedDescription
                case .finished:
                    print("Terminer")
                }
                Indicator.sharedInstance.hideIndicator()
            }
            receiveValue: { programData in
                self.dataSource = programData
                self.mapSaisonData()
            }
            .store(in: &cancellables)
    }
    
    // Binding
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.contents.seasons?.count ?? 0
    }
    
    private func mapSaisonData() {
        saisons.value = self.dataSource?.contents.seasons?.compactMap({SaisonTableCellViewModel(saison: $0)})
    }
    
    func getSaisonTitle(_ saison: Detail.Season) -> String {
        return saison.menutitle.first?.value ?? ""
    }
    
    func retriveEpisodes(_ saison: Detail.Season) -> [Detail.Episode]? {
        guard let episodes = saison.episodes else {
            return nil
        }
        
        return episodes
    }

}
