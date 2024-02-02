//
//  CredCardsTableViewCell.swift
//  Pan CredCard
//
//  Created by Michael Bressiani on 20/01/24.

import UIKit

protocol convertBase64ToImage {
    func convertBase64ToImage(_ base64String: String) -> UIImage
}

class CredCardsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCardImageView: UIImageView!
    @IBOutlet weak var titleCardNameLabel: UILabel!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var titleCardAliasLabel: UILabel!
    @IBOutlet weak var cardAliasLabel: UILabel!
    @IBOutlet weak var titleCardNumberLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    private var viewModel: ListCredCardsViewModel = ListCredCardsViewModel()
    static let identifier: String = "CredCardsTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        elementsConfig()
    }
    
    private func elementsConfig() {
        
        titleCardNameLabel.text = "Cartão"
        titleCardNameLabel.font = UIFont.systemFont(ofSize: 11)
        titleCardNameLabel.textColor = UIColor.gray
        let titleCardNameAcessibitilityString = "Faz referência ao nome do cartão abaixo"
        accessibilityLabel(label: titleCardNameLabel, descriptionLabelString: titleCardNameAcessibitilityString)
        
        titleCardAliasLabel.text = "Bandeira"
        titleCardAliasLabel.font = UIFont.systemFont(ofSize: 11)
        titleCardAliasLabel.textColor = UIColor.gray
        let titleCardAliasAcessibitilityString = "Faz referência ao nome da bandeira abaixo"
        accessibilityLabel(label: titleCardAliasLabel, descriptionLabelString: titleCardAliasAcessibitilityString)
        
        titleCardNumberLabel.text = "Final do cartão"
        titleCardNumberLabel.font = UIFont.systemFont(ofSize: 11)
        titleCardNumberLabel.textColor = UIColor.gray
        let titleCardNumberAcessibitilityString = "Faz referência ao final do cartão abaixo"
        accessibilityLabel(label: titleCardNumberLabel, descriptionLabelString: titleCardNumberAcessibitilityString)
    }
    
    public func setupCell(card: Card) {
        
        let image = viewModel.convertBase64ToImage(base64String: card.image)
        imageCardImageView.image = image
        
        cardNameLabel.text = card.name
        cardNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        let cardNameAcessibitilityString = "Esse nome do cartão"
        accessibilityLabel(label: cardNameLabel, descriptionLabelString: cardNameAcessibitilityString)
        
        cardAliasLabel.text = card.alias
        cardAliasLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        let cardAliasAcessibitilityString = "Essa é a bandeira do cartão"
        accessibilityLabel(label: cardAliasLabel, descriptionLabelString: cardAliasAcessibitilityString)
        
        cardNumberLabel.text = viewModel.lastForDigits(cardNumber: card.number)
        cardNumberLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        let cardNumberAcessibitilityString = "Esses são os quatro ultimos digitos do cartão"
        accessibilityLabel(label: cardNumberLabel, descriptionLabelString: cardNumberAcessibitilityString)
    }
    
    private func accessibilityLabel(label: UILabel, descriptionLabelString: String) {
        label.isAccessibilityElement = true
        label.accessibilityHint = (label.text ?? "") + descriptionLabelString
    }
}

