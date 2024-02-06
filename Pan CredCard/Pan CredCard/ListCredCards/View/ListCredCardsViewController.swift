//
//  ListCredCardsViewController.swift
//  Pan CredCard
//
//  Created by Michael Bressiani on 20/01/24.

import UIKit

class ListCredCardsViewController: UIViewController {
    
    @IBOutlet weak var searchCardSearchBar: UISearchBar!
    @IBOutlet weak var listCredCardsTableView: UITableView!
    
    private var viewModel: ListCredCardsViewModel = ListCredCardsViewModel()
    private var secureStorageCard: SecureStorageCard = SecureStorageCard()
    private var searchCardName: [Card] = []
    private var searching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfigs()
        configSeachBar()
        configTableView()
        viewModel.delegate = self
        viewModel.fetchCardsMock()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UITableView.animate(withDuration: 0.5) {
            self.listCredCardsTableView.alpha = 1
        }
        UISearchBar.animate(withDuration: 0.5) {
            self.searchCardSearchBar.alpha = 1
        }
    }
    
    private func initialConfigs() {
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor.systemBackground
        navigationItem.backButtonTitle = ""
    }
    
    private func configTableView() {
        listCredCardsTableView.alpha = 0
        listCredCardsTableView.separatorStyle = .none
        listCredCardsTableView.delegate = self
        listCredCardsTableView.dataSource = self
        listCredCardsTableView.register(CredCardsTableViewCell.nib(), forCellReuseIdentifier: CredCardsTableViewCell.identifier)
        listCredCardsTableView.reloadData()
    }
    
    private func configSeachBar() {
        searchCardSearchBar.alpha = 0
        searchCardSearchBar.delegate = self
        searchCardSearchBar.backgroundImage = UIImage()
        searchCardSearchBar.placeholder = "Digite o nome do cartão"
    }
    
    private func errorRequestAPI() {
        
        let alert: UIAlertController  = UIAlertController(title: "Fora de serviço", message: "", preferredStyle: .alert)
        
        let action: UIAlertAction = UIAlertAction(title: "Sair", style: .default) {
            (action) in exit(0)
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func navegationToDetailsCard(card: Card) {
        
        let dcString = String(describing: DetailsCardViewController.self)
        let vcString = UIStoryboard(name: dcString, bundle: nil).instantiateViewController(identifier: dcString) { coder -> DetailsCardViewController? in
            return DetailsCardViewController(coder: coder, card: card)
        }
        
        self.navigationController?.pushViewController(vcString, animated: true)
    }
}

extension ListCredCardsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let cardList = viewModel.cardList()
        let numbersOfRows = viewModel.numberOfRows(searching: searching, searchCardName: searchCardName, cardList: cardList)
        
        return numbersOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CredCardsTableViewCell.identifier, for: indexPath) as? CredCardsTableViewCell
        
        let cardList = viewModel.cardList()
        let resultCard = viewModel.cardFilterConfig(searching: searching, searchCardName: searchCardName, cardList: cardList, indexPath: indexPath)
        
        cell?.setupCell(card: resultCard)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cardList = viewModel.cardList()
        secureStorageCard.saveCardToKeychain(card: cardList[indexPath.row])
        
        let resultCard = viewModel.cardFilterConfig(searching: searching, searchCardName: searchCardName, cardList: cardList, indexPath: indexPath)
        
        navegationToDetailsCard(card: resultCard)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension ListCredCardsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension ListCredCardsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCardName = viewModel.cardListFilterName(searchText: searchText)
        searching = true
        listCredCardsTableView.reloadData()
    }
}

extension ListCredCardsViewController: CardsViewModelProtocol {
    func errorRequest() {
        errorRequestAPI()
    }
    
    func successRequest() {
        configTableView()
    }
}


