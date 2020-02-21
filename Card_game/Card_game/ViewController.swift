//
//  ViewController.swift
//  Card_game
//
//  Created by 이가영 on 2020/02/20.
//  Copyright © 2020 이가영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardarray.count + 1)/2)
    var number: Int = 0
    
    var emojiChoices = ["🦇", "😱", "🙀", "👿", "🎃", "👻", "🍭", "🍬", "🍎"]
    
    var emoji = [Int:String]()
    
    @IBAction func ghost_but(_ sender: UIButton) {
        flipcount()
        if let cardnumber = cardarray.firstIndex(of:sender){
            game.chooseCard(at: cardnumber)
            updateviewfrommodel()
        }else {
            print("was not in card")
        }
        
    }
    
    func updateviewfrommodel(){
        for index in cardarray.indices{
            let button = cardarray[index]
            let card = game.cards[index]
            if card.isFaceup{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0): #colorLiteral(red: 0.7121074796, green: 0.5914553404, blue: 1, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
     
    @IBOutlet var cardarray: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var numbercounting: UILabel!
    
    func flipcount(){
        number+=1
        numbercounting.text = "Flip : \(number)"
    }
}

