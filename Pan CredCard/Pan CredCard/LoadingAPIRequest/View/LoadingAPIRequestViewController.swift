//
//  LoadingAnimationViewController.swift
//  Pan CredCard
//
//  Created by Michael Bressiani on 08/02/24.

import UIKit

class LoadingAPIRequestViewController: UIViewController {
    
    @IBOutlet weak var loadingViewActivityIndicatorView: UIActivityIndicatorView!
    
    private var viewModel: LoadingAPIRequestViewModel = LoadingAPIRequestViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfigs()
        viewModel.delegate = self
        viewModel.fetchCardsMock()
        loadingViewActivityIndicatorView.style = UIActivityIndicatorView.Style.large
        loadingViewActivityIndicatorView.startAnimating()
    }
    
    private func initialConfigs() {
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor.systemBackground
    }
    
    private func errorRequestAPI() {
        
        let alert: UIAlertController  = UIAlertController(title: "Fora de serviço", message: "", preferredStyle: .alert)
        
        let action: UIAlertAction = UIAlertAction(title: "Sair", style: .default) {
            (action) in exit(0)
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func navigationListCredCards(listCards: [Card]) {
        let dcString = String(describing: ListCredCardsViewController.self)
        let vc = UIStoryboard(name: dcString, bundle: nil).instantiateViewController(identifier: dcString) { coder -> ListCredCardsViewController? in
            return ListCredCardsViewController(coder: coder, listCards: listCards)
        }
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension LoadingAPIRequestViewController: CardsViewModelProtocol {
    func errorRequest() {
        errorRequestAPI()
    }
    
    func successRequest() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.loadingViewActivityIndicatorView.stopAnimating()
            self.navigationListCredCards(listCards: self.viewModel.getListCards())
        })
    }
}


