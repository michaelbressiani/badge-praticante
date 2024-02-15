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
    private var listCards: [Card] = [Card(id: 0, name: "", alias: "", credit: false, debit: false, number: "", codSec: "", image: "")]
    
    init?(coder: NSCoder, listCards: [Card]) {
        self.listCards = listCards
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfigs()
        configSeachBar()
        configTableView()
        accessibilitySearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fadeInListCredCards()
        
    }
    
    private func fadeInListCredCards() {
        UITableView.animate(withDuration: 2.0) {
            self.listCredCardsTableView.alpha = 1
        }
        UISearchBar.animate(withDuration: 2.0) {
            self.searchCardSearchBar.alpha = 1
        }
    }
    
    private func initialConfigs() {
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor.systemBackground
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
    
    private func navegationToDetailsCard(card: Card) {
        
        let dcString = String(describing: DetailsCardViewController.self)
        let vcString = UIStoryboard(name: dcString, bundle: nil).instantiateViewController(identifier: dcString) { coder -> DetailsCardViewController? in
            return DetailsCardViewController(coder: coder, card: card)
        }
        fadeOutLisCredtCards()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.navigationController?.pushViewController(vcString, animated: false)
        })
    }
    
    private func fadeOutLisCredtCards() {
        UITableView.animate(withDuration: 1.0) {
            self.listCredCardsTableView.alpha = 0
        }
        
        UISearchBar.animate(withDuration: 1.0) {
            self.searchCardSearchBar.alpha = 0
        }
    }
    
    private func accessibilitySearchBar() {
        searchCardSearchBar.isAccessibilityElement = true
        searchCardSearchBar.accessibilityHint = "Essa é a barra de busca de cartões"
    }
}

extension ListCredCardsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numbersOfRows = viewModel.numberOfRows(searching: searching, searchCardName: searchCardName, listCards: listCards)
        
        return numbersOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CredCardsTableViewCell.identifier, for: indexPath) as? CredCardsTableViewCell
        
        let resultCard = viewModel.cardFilterConfig(searching: searching, searchCardName: searchCardName, listCards: listCards, indexPath: indexPath)
        
        cell?.setupCell(card: resultCard)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        secureStorageCard.saveCardToKeychain(card: listCards[indexPath.row])
        
        let resultCard = viewModel.cardFilterConfig(searching: searching, searchCardName: searchCardName, listCards: listCards, indexPath: indexPath)
        
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
        searching = true
        searchCardName = viewModel.cardListFilterName(searchText: searchText, listCards: listCards)
        listCredCardsTableView.reloadData()
    }
}


