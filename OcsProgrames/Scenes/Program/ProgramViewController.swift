//
//  ProgramViewController.swift
//  OcsProgrames
//
//  Created by Abdelkarim MEDIANA on 13/10/2022.
//

import UIKit
import Combine


class ProgramViewController: BaseViewController {
    
    //IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //ViewModel
    var viewModel: ProgramViewModel = ProgramViewModel()
    
    //Variables:
    var showsDataSource: [ShowTableCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        overrideUserInterfaceStyle = .dark
        configView()
        bindViewModel()
    }

    func configView() {
        self.title = "Program"
        self.view.backgroundColor = .systemBackground
        self.setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getProgramContents()
    }
    
    func bindViewModel() {
        viewModel.shows.bind { [weak self] shows in
            guard let self = self,
                  let shows = shows else {
                return
            }
            self.showsDataSource = shows
            self.reloadTableView()
        }
    }
    
    func openDetails(showId: String) {
        guard let show = viewModel.retriveShow(withId: showId) else {
            return
        }
        
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        controller.programContent = show
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ProgramViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        self.tableView.register(ShowTableViewCell.register(), forCellReuseIdentifier: ShowTableViewCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Sizes.showCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowTableViewCell.identifier, for: indexPath) as? ShowTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(viewModel: showsDataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showId = showsDataSource[indexPath.row].id
        self.openDetails(showId: showId)
    }
}
