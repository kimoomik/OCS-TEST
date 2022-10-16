//
//  DetailViewController.swift
//  OcsProgrames
//
//  Created by Abdelkarim MEDIANA on 13/10/2022.
//

import UIKit
import Combine
import AVKit


class DetailViewController: BaseViewController {
    
    //IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    


    //ViewModel
    var viewModel: DetailViewModel = DetailViewModel()
    var programContent: Program.DisplayContent?
    
    //Variables:
    var showsDataSource: [SaisonTableCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.error.bind { err in
            guard let err = err else {
                return
            }
            DispatchQueue.main.async {
                self.showAlert(title: "Alert", message: err)
            }
        }
        
        viewModel.saisons.bind { [weak self] saison in
            guard let self = self,
                  let saison = saison else {
                return
            }
            self.showsDataSource = saison
            self.reloadTableView()
        }
    }
    
    func configView() {
        self.title = "Détail du Programme"
        self.view.backgroundColor = .systemBackground
        headerImage.loadFrom(URLAddress: "\(GlobalConfiguration.baseImageUrl)\(programContent?.fullscreenimageurl ?? "")")
        titleLabel.text = programContent?.title.first?.value ?? ""
        self.setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let array = programContent?.detaillink.split(separator: "/") ?? []
        let endPoint = array[array.count - 2] + "/" + array[array.count - 1]
        let request = Detail.Fetch.Request(id: String(endPoint))//programContent?.id ?? "")
        viewModel.getShowsOfProgram(id: request.id)
    }
    
    // Action
    
    @IBAction func playPressed(_ sender: UIButton) {
        
        guard let url = URL(string: "https://bitmovin-a.akamaihd.net/content/bbb/stream.m3u8") else {
            print("URL ne marche pas ..")
            return
        }
        let avPlayer = AVPlayer(url: url)
        let avController = AVPlayerViewController()
        avController.player = avPlayer
        present(avController, animated: true)
    }
    
}
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        
        self.registerCells()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func registerCells() {
        self.tableView.register(SaisonTableViewCell.register(), forCellReuseIdentifier: SaisonTableViewCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Sizes.saisonCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SaisonTableViewCell.identifier, for: indexPath) as? SaisonTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(viewModel: showsDataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Clique ICI")
    }
}
