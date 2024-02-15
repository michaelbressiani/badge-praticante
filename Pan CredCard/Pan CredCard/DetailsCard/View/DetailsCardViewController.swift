//
//  DetailsCardViewController.swift
//  Pan CredCard
//
//  Created by Michael Bressiani on 20/01/24.


import UIKit

class DetailsCardViewController: UIViewController {
    
    @IBOutlet weak var contentViewUIView: UIView!
    @IBOutlet weak var cardImageImageView: UIImageView!
    @IBOutlet weak var titleCardNameLabel: UILabel!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var titleCardAliasLabel: UILabel!
    @IBOutlet weak var cardAliasLabel: UILabel!
    @IBOutlet weak var titleCardNumberLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var titleCardCodSecLabel: UILabel!
    @IBOutlet weak var cardCodSecLabel: UILabel!
    @IBOutlet weak var titleCardIsCreditOrIsDebitLabel: UILabel!
    @IBOutlet weak var cardIsCreditOrIsDebitLabel: UILabel!
    
    
    private var cardName: String = ""
    private var card: Card = Card(id: 0, name: "", alias: "", credit: false, debit: false, number: "", codSec: "", image: "")
    private var viewModel: DetailsCardViewModel = DetailsCardViewModel()
    
    init?(coder: NSCoder, card: Card) {
        self.card = card
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementsConfig()
        accessebilityLabels()
        backNavegationFadeOut()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fadeInDetailsCard()
    }
    
    private func fadeInDetailsCard() {
        UIView.animate(withDuration: 1.0) {
            self.contentViewUIView.alpha = 1
        }
    }
    
    private func backNavegationFadeOut() {
        let backButtonNavegation = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backActionNavegation))
        self.navigationItem.leftBarButtonItem = backButtonNavegation
    }
    
    @objc func backActionNavegation() {
        UIView.animate(withDuration: 1.0) {
            self.contentViewUIView.alpha = 0
        }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
        self.navigationController?.popViewController(animated: false)
        })
    }
    
    private func elementsConfig() {
        
        contentViewUIView.alpha = 0
        
        cardImageImageView.image = viewModel.convertBase64ToImage(base64String: card.image)
        
        let titleCardNameString = "Cartão"
        let cardNameString = card.name
        labelConfig(titleCardNameLabel, cardNameLabel, titleCardNameString, cardNameString)
        
        let titleCardAliasString = "Bandeira"
        let cardAliasString = card.alias
        labelConfig(titleCardAliasLabel, cardAliasLabel, titleCardAliasString, cardAliasString)
        
        let titleCardNumberString = "Número do cartão"
        let cardNumberString = card.number
        labelConfig(titleCardNumberLabel, cardNumberLabel, titleCardNumberString, cardNumberString)
        
        let titleCardCodSecString = "Código de segurança"
        let cardCodSecString = card.codSec
        labelConfig(titleCardCodSecLabel, cardCodSecLabel, titleCardCodSecString, cardCodSecString)
        
        let titleCardIsCreditOrIsDebitString = "Função"
        let cardIsCreditOrIsDebitString = viewModel.isDebitOrCredit(isDebit: card.credit, isCredit: card.debit)
        labelConfig(titleCardIsCreditOrIsDebitLabel, cardIsCreditOrIsDebitLabel, titleCardIsCreditOrIsDebitString, cardIsCreditOrIsDebitString)
        
    }
    
    private func labelConfig(_ titleLabel: UILabel,_ label: UILabel, _ textTitleLabel: String,_ textLabel: String) {
        titleLabel.text = textTitleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = UIColor.lightGray
        
        label.text = textLabel
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    private func accessibilityLabel(label: UILabel, descriptionLabelString: String) {
        label.isAccessibilityElement = true
        label.accessibilityHint = (label.text ?? "") + descriptionLabelString
    }
    
    private func accessebilityLabels() {
        
        let titleCardNameAcessibilityString = "Faz referência ao nome do cartão abaixo"
        accessibilityLabel(label: titleCardNameLabel, descriptionLabelString: titleCardNameAcessibilityString)
        let cardNameAcessibitilityString = "Esse nome do cartão"
        accessibilityLabel(label: cardNameLabel, descriptionLabelString: cardNameAcessibitilityString)
        
        let titleCardAliasAcessibitilityString = "Faz referência ao nome da bandeira abaixo"
        accessibilityLabel(label: titleCardAliasLabel, descriptionLabelString: titleCardAliasAcessibitilityString)
        let cardAliasAcessibitilityString = "Essa é a bandeira do cartão"
        accessibilityLabel(label: cardAliasLabel, descriptionLabelString: cardAliasAcessibitilityString)
        
        let titleCardIsCreditOrIsDebitAcessibilityString = "Faz referência a funcionalidade do cartão abaixo"
        accessibilityLabel(label: titleCardIsCreditOrIsDebitLabel, descriptionLabelString: titleCardIsCreditOrIsDebitAcessibilityString)
        let cardIsCreditOrIsDebitAcessibilityString = "Diz se o cartão é débito ou crédito"
        accessibilityLabel(label: cardIsCreditOrIsDebitLabel, descriptionLabelString: cardIsCreditOrIsDebitAcessibilityString)
        
        let titleCardNumberAcessibitilityString = "Faz referência ao número completo do cartão abaixo"
        accessibilityLabel(label: titleCardNumberLabel, descriptionLabelString: titleCardNumberAcessibitilityString)
        let cardNumberAcessibitilityString = "Esse é o número do cartão"
        accessibilityLabel(label: cardNumberLabel, descriptionLabelString: cardNumberAcessibitilityString)
        
        let titleCardCodSecAcessibitilityString = "Faz referência ao código de segurança do cartão abaixo"
        accessibilityLabel(label: titleCardCodSecLabel, descriptionLabelString: titleCardCodSecAcessibitilityString)
        let cardCodSecAcessibitilityString = "Esse é o código de segurança do cartão"
        accessibilityLabel(label: cardCodSecLabel, descriptionLabelString: cardCodSecAcessibitilityString)
    }
}

