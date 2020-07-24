//
//  ViewController.swift
//  BJTrainer
//
//  Created by Daniel Davies on 4/5/20.
//  Copyright © 2020 Dan. All rights reserved.

import UIKit

let ACE:Int = 11

// to check if the app is being loaded for the first time
// if yes, a hand must be dealt
var is_first_load = true

// action string constants
let STAND = "Stand"
let HIT = "Hit"
let DOUBLE = "Double Down"
let SURRENDER = "Surrender"
let SPLIT = "Split"

// Regular Hands - no Ace, no pair
let regular_best_action_dict =
//   P   D
    [8: [2: HIT, 3: HIT, 4: HIT, 5: HIT, 6: HIT, 7: HIT, 8: HIT, 9: HIT, 10: HIT, ACE: HIT],
     9: [2: HIT, 3: DOUBLE, 4: DOUBLE, 5: DOUBLE, 6: DOUBLE, 7: HIT, 8: HIT, 9: HIT, 10: HIT, ACE: HIT],
     10:[2: DOUBLE, 3: DOUBLE, 4: DOUBLE, 5: DOUBLE, 6: DOUBLE, 7: DOUBLE, 8: DOUBLE, 9: DOUBLE, 10: HIT, ACE: HIT],
     11:[2: DOUBLE, 3: DOUBLE, 4: DOUBLE, 5: DOUBLE, 6: DOUBLE, 7: DOUBLE, 8: DOUBLE, 9: DOUBLE, 10: DOUBLE, ACE: HIT],
     12:[2: HIT, 3: HIT, 4: STAND, 5: STAND, 6: STAND, 7: HIT, 8: HIT, 9: HIT, 10: HIT, ACE: HIT],
     13:[2: STAND, 3: STAND, 4: STAND, 5: STAND, 6: STAND, 7: HIT, 8: HIT, 9: HIT, 10: HIT, ACE: HIT],
     14:[2: STAND, 3: STAND, 4: STAND, 5: STAND, 6: STAND, 7: HIT, 8: HIT, 9: HIT, 10: HIT, ACE: HIT],
     15:[2: STAND, 3: STAND, 4: STAND, 5: STAND, 6: STAND, 7: HIT, 8: HIT, 9: HIT, 10: SURRENDER, ACE: HIT],
     16:[2: STAND, 3: STAND, 4: STAND, 5: STAND, 6: STAND, 7: HIT, 8: HIT, 9: SURRENDER, 10: SURRENDER, ACE: SURRENDER],
     17:[2: STAND, 3: STAND, 4: STAND, 5: STAND, 6: STAND, 7: STAND, 8: STAND, 9: STAND, 10: STAND, ACE: STAND],
     18:[2: STAND, 3: STAND, 4: STAND, 5: STAND, 6: STAND, 7: STAND, 8: STAND, 9: STAND, 10: STAND, ACE: STAND]
    ]

// dummy values!! - not done yet
let soft_best_action_dict =
//   P   D
    [13:[2: HIT, 3: HIT, 4: HIT, 5: DOUBLE, 6: DOUBLE, 7: HIT, 8: HIT, 9: HIT, 10: HIT, ACE: HIT],
     14:[2: HIT, 3: HIT, 4: HIT, 5: DOUBLE, 6: DOUBLE, 7: HIT, 8: HIT, 9: HIT, 10: HIT, ACE: HIT],
     15:[2: HIT, 3: HIT, 4: DOUBLE, 5: DOUBLE, 6: DOUBLE, 7: HIT, 8: HIT, 9: HIT, 10: HIT, ACE: HIT],
     16:[2: HIT, 3: HIT, 4: DOUBLE, 5: DOUBLE, 6: DOUBLE, 7: HIT, 8: HIT, 9: HIT, 10: HIT, ACE: HIT],
     17:[2: HIT, 3: DOUBLE, 4: DOUBLE, 5: DOUBLE, 6: DOUBLE, 7: HIT, 8: HIT, 9: HIT, 10: HIT, ACE: HIT],
     18:[2: STAND, 3: DOUBLE, 4: DOUBLE, 5: DOUBLE, 6: DOUBLE, 7: STAND, 8: STAND, 9: HIT, 10: HIT, ACE: HIT],
     19:[2: STAND, 3: STAND, 4: STAND, 5: STAND, 6: STAND, 7: STAND, 8: STAND, 9: STAND, 10: STAND, ACE: STAND]
    ]
let pair_best_action_dict =
//   P   D
    [4: [2: SPLIT, 3: SPLIT, 4: SPLIT, 5: SPLIT, 6: SPLIT, 7: SPLIT, 8: HIT, 9: HIT, 10: HIT, ACE: HIT],
     6: [2: SPLIT, 3: SPLIT, 4: SPLIT, 5: SPLIT, 6: SPLIT, 7: SPLIT, 8: HIT, 9: HIT, 10: HIT, ACE: HIT],
     8: [2: HIT, 3: HIT, 4: HIT, 5: SPLIT, 6: SPLIT, 7: HIT, 8: HIT, 9: HIT, 10: HIT, ACE: HIT],
     10:[2: DOUBLE, 3: DOUBLE, 4: DOUBLE, 5: DOUBLE, 6: DOUBLE, 7: DOUBLE, 8: DOUBLE, 9: DOUBLE, 10: HIT, ACE: HIT],
     12:[2: SPLIT, 3: SPLIT, 4: SPLIT, 5: SPLIT, 6: SPLIT, 7: HIT, 8: HIT, 9: HIT, 10: HIT, ACE: HIT],
     14:[2: SPLIT, 3: SPLIT, 4: SPLIT, 5: SPLIT, 6: SPLIT, 7: SPLIT, 8: HIT, 9: HIT, 10: HIT, ACE: HIT],
     16:[2: SPLIT, 3: SPLIT, 4: SPLIT, 5: SPLIT, 6: SPLIT, 7: SPLIT, 8: SPLIT, 9: SPLIT, 10: SPLIT, ACE: SPLIT],
     18:[2: SPLIT, 3: SPLIT, 4: SPLIT, 5: SPLIT, 6: SPLIT, 7: STAND, 8: SPLIT, 9: SPLIT, 10: STAND, ACE: STAND],
     20:[2: STAND, 3: STAND, 4: STAND, 5: STAND, 6: STAND, 7: STAND, 8: STAND, 9: STAND, 10: STAND, ACE: STAND],
     22:[2: SPLIT, 3: SPLIT, 4: SPLIT, 5: SPLIT, 6: SPLIT, 7: SPLIT, 8: SPLIT, 9: SPLIT, 10: SPLIT, ACE: SPLIT]
    ]

// main trainer class that handles the training flow
let blackjack_trainer:BJTrainer = BJTrainer()

class ViewController: UIViewController {
        
    // card image views
    @IBOutlet weak var dealerUpCardImageView: UIImageView!
    @IBOutlet weak var dealerDownCardImageView: UIImageView!
    @IBOutlet weak var playerCard1ImageView: UIImageView!
    @IBOutlet weak var playerCard2ImageView: UIImageView!
    
    // labels
    @IBOutlet weak var youHaveLabel: UILabel!
    
    // buttons
    @IBOutlet weak var standButton: UIButton!
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var doubleButton: UIButton!
    @IBOutlet weak var surrenderButton: UIButton!
    @IBOutlet weak var splitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check if this is the first load
        if is_first_load {
        
            blackjack_trainer.setup() // setup blackjack_trainer and flashcard_manager
        
            blackjack_trainer.get_cards() // get the cards to show the user

            is_first_load = false // set to false so initial loading doesn't happen anymore

        }
        self.show_cards() // show the cards to the user

    }
    
    // button press events
    @IBAction func standButtonPressed(_ sender: Any) {
        // stand button was pressed
        self.check_user_answer(answer:STAND)
    }
    
    @IBAction func hitButtonPressed(_ sender: Any) {
        // hit button was pressed
        self.check_user_answer(answer:HIT)
    }
    
    @IBAction func doubleButtonPressed(_ sender: Any) {
        // double button was pressed
        self.check_user_answer(answer:DOUBLE)
    }
    @IBAction func surrenderButtonPressed(_ sender: Any) {
        // surrender button was pressed
        self.check_user_answer(answer:SURRENDER)
    }
    @IBAction func splitButtonPressed(_ sender: Any) {
        // split button was pressed
        self.check_user_answer(answer:SPLIT)
    }
    
    @IBAction func studyButton(_ sender: Any) {
        performSegue(withIdentifier: "mainToStudySegue", sender: self)
    }
    @IBAction func reviewButton(_ sender: Any) {
        performSegue(withIdentifier: "mainToReviewSegue", sender: self)
    }
    
    // get an array of hand combos that need review
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "mainToReviewSegue") {
            let hand_combos_for_review:[HandCombo] = blackjack_trainer.get_review_hand_combos()
            let nextViewController = segue.destination as! ReviewViewController
        nextViewController.review_hand_combos = hand_combos_for_review
        }
    }
    
    func show_cards() {
        
        // load the card images
        dealerUpCardImageView.image = UIImage(named:blackjack_trainer.dealer_up_card)
        dealerDownCardImageView.image = UIImage(named: "card_back")
        playerCard1ImageView.image = UIImage(named:blackjack_trainer.player_card1)
        playerCard2ImageView.image = UIImage(named:blackjack_trainer.player_card2)
        
        // show hand description
        youHaveLabel.text = blackjack_trainer.flashcard_manager.cur_hand_combo.description()
        
        // show the appropriate action buttons
        standButton.isHidden = false
        hitButton.isHidden = false
        doubleButton.isHidden = false
        surrenderButton.isHidden = false
        if blackjack_trainer.flashcard_manager.cur_hand_combo.is_pair {
            splitButton.isHidden = false
        }
        else {
            splitButton.isHidden = true
        }
    }
    
    func check_user_answer(answer:String) {
        // check answer
        
        // the user keeps trying until he gets the hand right, but moving the flashcard to the right box and keeping track of hands for review is based on ther first answer
        
        let result = blackjack_trainer.check_answer(answer:answer)

        self.show_result(user_answer:answer, result:result) // show result message
        // show result repeats until the user gets it right
        
        if result {
            // if correct, move the hand combo to appropriate flashcard box
            // if num_tries is 1, the user got it right on the first try
            if (blackjack_trainer.num_tries == 1) {
                blackjack_trainer.flashcard_manager.cur_hand_combo.needs_review = false
                blackjack_trainer.flashcard_manager.put_away_hand_combo(is_correct: true)
                
            } else {
                blackjack_trainer.flashcard_manager.cur_hand_combo.needs_review = true
                blackjack_trainer.flashcard_manager.put_away_hand_combo(is_correct: false)
            }
        }
    }
    
    func show_result(user_answer:String, result:Bool) {
        // show the user if his choice was correct or not
        let correct_answer:String = blackjack_trainer.flashcard_manager.cur_hand_combo.best_action

        print(blackjack_trainer.flashcard_manager.cur_hand_combo.description())
        print("best action: " + blackjack_trainer.flashcard_manager.cur_hand_combo.best_action)
        
        if result {
            // correct
            youHaveLabel.textColor = UIColor.green // text color to green
            youHaveLabel.text = "Correct!"
            
            // wait some time
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.youHaveLabel.textColor = UIColor.white // change text color back to White
                blackjack_trainer.get_cards() // get the next cards to show the user
                self.show_cards() // show the next cards to the user
            }
        }
        else {
            let hand_combo = blackjack_trainer.flashcard_manager.cur_hand_combo
            
            print(hand_combo.description())
            let message = "You should \(correct_answer) with " + hand_combo.description()
            
            // show alert to user
            let alert = UIAlertController(title: "You should \(correct_answer)!", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it", style: .default))
            self.present(alert, animated: true)
        }
    }
}

// min and max hands for player and dealer for training purposes
// hands under 8 are not included
let MIN_VAL:Int = 2 // minimum available card value
let MAX_VAL:Int = ACE // maximum available card value

// range of hands
let PLAYER_MIN_SUM:Int = regular_best_action_dict.keys.min()! // minimum player sum for training (anything less is an automatic hit)
let PLAYER_MAX_SUM:Int = regular_best_action_dict.keys.max()! // maximum player sum for training (anything higher is an automatic stand)
let PLAYER_SOFT_MIN:Int = soft_best_action_dict.keys.min()! // minimum soft sum for training (12 is included in pairs instead of soft hands)
let PLAYER_SOFT_MAX:Int = soft_best_action_dict.keys.max()! // maximum soft num for training (don't need to include 20 or 21)

let HANDS_TO_WAIT:Int = 5 // how many hands to wait (at least) before showing the same hand combo again

func card_val_to_string(val:Int) -> String {
    if (val == ACE) {
        return "Ace"
    }
    return String(val)
}

class BJTrainer {
    // Blackjack Training Program
    
    // initialize flashcard manager with an empty flashcard set
    var flashcard_manager:FlashcardManager = FlashcardManager(flashcard_set:[])
    
    // cards to show the user
    var dealer_up_card: String = ""
    var player_card1: String = ""
    var player_card2: String = ""
    
    var num_tries:Int = 0// to keep track of how many tries the user has tried to pick the right answer
    
    func setup () {
        // define hand combo set of all hand combos
        var hand_combo_set = self.get_all_hand_combos()
        
        // reduced hand combo set for debug
        //hand_combo_set = Array(hand_combo_set.prefix(upTo: 10))
        
        // shuffle all_hand_combos
        hand_combo_set.shuffle()
                
        // setup the flashcard manager
        self.flashcard_manager = FlashcardManager(flashcard_set:hand_combo_set)
    }
    
    func get_cards() {
        // get the next cards to show the user
        
        // debug
        print(self.flashcard_manager.contents_to_string())
        
        // draw the next hand combo
        self.flashcard_manager.draw_hand_combo()
        
        // select random cards to represent the next hand combo
        self.dealer_up_card = self.random_card_from_val(val:self.flashcard_manager.cur_hand_combo.dealer_val)
        let player_cards = self.flashcard_manager.cur_hand_combo.get_player_ranks()
        self.player_card1 = self.random_card_from_val(val:player_cards[0])
        self.player_card2 = self.random_card_from_val(val:player_cards[1])
        
        // reset num_tries
        num_tries = 0
    }
    
    func random_card_from_val(val:Int) -> String {
        // returns a card string with random suit given the rank value.  For a value of 10 this function randomly returns "10", "J", "Q", or "K"
        
        // rank and suit string arrays
        let ten_rank_array = ["T", "J", "Q", "K"]
        let suit_array = ["c", "d", "h", "s"]

        // get the rank string
        var rank_str:String
        switch val {
        case 2...9:
            rank_str = String(val)
        case 10:
            // pick a random rank with a value of 10
            rank_str = ten_rank_array[Int.random(in: 0...(ten_rank_array.count - 1))]
        case ACE:
            rank_str = "A"
        default:
            rank_str = ""
        }
        
        // pick a random suit
        let suit_str:String = suit_array[Int.random(in: 0...(suit_array.count - 1))]
        
        return rank_str + suit_str
    }
    
    func check_answer(answer:String) -> Bool {
        // check the user response to see if it's correct or incorrect and update the flashcard manager
        
        num_tries += 1 // increment num_tries
        print("num tries: \(num_tries)")
        
        let hand_combo:HandCombo = self.flashcard_manager.cur_hand_combo

        return answer == hand_combo.best_action
    }
        
    func get_all_hand_combos() -> [HandCombo] {
        // return a list of all hand combos, including expected values for each action and best action
        
        var all_hand_combos = [HandCombo]() // output of all hand combos
        
        // build all hand combos
        // iterate through dealer up card first
        // then separate no-ace no-pair, pair, soft
        for dealer_val in (MIN_VAL...MAX_VAL) {
            
            // no ace, no pair
            for player_sum in (PLAYER_MIN_SUM...PLAYER_MAX_SUM) {
                all_hand_combos.append(HandCombo(dealer_val:dealer_val, player_sum:player_sum, is_soft:false, is_pair:false))
            }
            
            // soft hands (with ace), exclued AA
            for player_sum in (PLAYER_SOFT_MIN...PLAYER_SOFT_MAX) {
                all_hand_combos.append(HandCombo(dealer_val:dealer_val, player_sum:player_sum, is_soft:true, is_pair:false))
            }
            
            // pairs
            for pair_val in (MIN_VAL...MAX_VAL) {
                if (pair_val == ACE) {
                    // pair of aces is a special case that is both soft and a pair
                    all_hand_combos.append(HandCombo(dealer_val:dealer_val, player_sum:ACE*2, is_soft:true, is_pair:true))
                }
                else {
                    all_hand_combos.append(HandCombo(dealer_val:dealer_val, player_sum:pair_val * 2, is_soft:false, is_pair:true))
                }
            }
        }
        
        return all_hand_combos
    }
    
    func random_card_image(val:Int) -> String {
        // returns the filename of the card image for the value with random suit
        // if the value is 10, a random rank is selected
        
        // rank and suit string arrays
        let ten_rank_array = ["T", "J", "Q", "K"]
        let suit_array = ["C", "D", "H", "S"]

        // get the rank string
        var rank_str:String
        switch val {
        case 2...9:
            rank_str = String(val)
        case 10:
            rank_str = ten_rank_array[Int.random(in: 0...(ten_rank_array.count - 1))]
        case ACE:
            rank_str = "A"
        default:
            rank_str = ""
        }
     
        // pick a random suit
        let suit_str:String = suit_array[Int.random(in: 0...(suit_array.count - 1))]
        
        return rank_str + suit_str
    }
    
    func get_review_hand_combos() -> [HandCombo] {
        // return all hand combos that need review
        var review_hand_combos:[HandCombo] = []
        for hand_combo in flashcard_manager.all_hand_combos() {
            if hand_combo.needs_review {
                review_hand_combos.append(hand_combo)
            }
        }
        return review_hand_combos
    }
    
}

class HandCombo {
    // a combination of dealer up card and player's hand (sum), along with the type of hand the player has: soft (with Ace) or pair (two of the same card)
    var dealer_val:Int // value of dealer's up card
    var player_sum:Int // sum of player's two cards
    var is_soft:Bool // contains an Ace?
    var is_pair:Bool // two of the same rank?
        
    var best_action:String = "" // best action
    
    var needs_review:Bool = false
    
    init(dealer_val:Int = 0, player_sum:Int = 0, is_soft:Bool = false, is_pair:Bool = false) {
        self.dealer_val = dealer_val
        self.player_sum = player_sum
        self.is_soft = is_soft
        self.is_pair = is_pair
        
        // get best action
        // select appropriate dictionary
        var best_action_dict = regular_best_action_dict
        if self.is_pair {
            // pair - this dictionary contains AA (soft_ev_dict does not contain AA)
            best_action_dict = pair_best_action_dict
        } else if self.is_soft {
            // soft hand containing an A (excluding AA)
            best_action_dict = soft_best_action_dict
        }

        // read best action from best_action_dictionary
        self.best_action = best_action_dict[self.player_sum]?[self.dealer_val] ?? String()
    }
    
    func get_player_ranks() -> [Int] {
        // returns two ranks that add up to the player's hand sum, in an array
        
        // check if the player has a pair
        if (self.is_pair) {
            if (self.is_soft) {
                // Aces
                return [ACE, ACE]
            }
            else {
                return [self.player_sum / 2, self.player_sum / 2]
            }
        }
        
        // check if the player has a soft hand (Ace)
        if (self.is_soft) {
            return [ACE, self.player_sum - ACE].shuffled()
        }
        
        // no ace no pair
        var sum_pairs = [[Int]]() // array of two-number arrays from which to choose
        
        // an odd integer divided by 2 will be floored
        for n in ((self.player_sum / 2) + 1)...10 {
            if ((self.player_sum - n) > 1) {
                // omit two-number pairs where one number is 1 (non-soft hands only)
                sum_pairs.append([n, self.player_sum - n])
            }
        }
        // choose a random two-number pair
        return sum_pairs.randomElement()!.shuffled()
    }
    
    func description() -> String {
        // returns a description of the hand combo in the form:
        // "Soft 16 against a Dealer Ace"
        
        var description = ""
        
        if (self.is_pair) {
            description += "Pair of "
            if (self.is_soft) {
                description += "Aces"
            }
            else {
                description += "\(self.player_sum / 2)'s"
            }
        }
        else {
            if (self.is_soft) {
                description += "Soft "
            }
            description += String(self.player_sum)
        }
        
        description += " against a Dealer \(card_val_to_string(val:self.dealer_val))"
        
        return description
        
    }
    
    func short_description() -> String {
        // return a shortened version of the hand description (for debug)
        
        var short_description = ""
        
        if (self.is_pair) {
            if (self.is_soft) {
                short_description += "AA"
            }
            else {
                short_description += "\(self.player_sum / 2)\(self.player_sum / 2)"
            }
        }
        else {
            if (self.is_soft) {
                short_description += "S"
            }
            short_description += String(self.player_sum)
        }
        
        short_description += " v \(card_val_to_string(val:self.dealer_val))"
        
        return short_description
    }
}

class FlashcardManager {
    // FlashcardManagermanages 3 boxes of flashcards, which are hand combos
    // All flashcards start in the first box.  When the user gets a flashcard correct, the flashcard is moved to the next box.  If the user gets a flashcord wrong, that flashcard is moved back by one box.
    // The next flashcard to show is randomly selected from one of the three boxes, with the highest probability of drawing a flashcard from the first box, and the lowest probability of drawing a flashcard from the third box.
    // The same flashcard should not be shown twice within 5 hands.
    
    let DRAW_PROBABILITY_WEIGHTS:[Int] = [60, 30, 10] // the probability weights of drawing from each flashcard box
    //let NUM_BOXES:Int // the number of boxes of flashcards (set this to the size of DRAW_PROBABILITIES in init()
    var flashcard_boxes = [FlashcardBox]() // an array of flashcard boxes
    let QUEUE_COUNTDOWN:Int = 5 // how many hands before the same hand combo should be shown again to the user
    var cur_hand_combo:HandCombo // the current hand combo to show the user.
    var cur_hand_combo_box:Int // the index of the flashcard box the current hand combo came from.  This is needed to know where to put it afterwards
    
    init(flashcard_set:[HandCombo]) {
        
        cur_hand_combo = HandCombo() // start with an empty hand combo
        cur_hand_combo_box = -1 // represents no value
        
        // create flashcard boxes
        for _ in 0..<self.DRAW_PROBABILITY_WEIGHTS.count {
            flashcard_boxes.append(FlashcardBox())
        }
        
        // start by putting all the hand combo flashcards into the first box
        for hand_combo in flashcard_set {
            flashcard_boxes[0].flashcards.append(hand_combo)
        }
    }
    
    func clear_cur_hand_combo () {
        // reset next hand combo to initial empty value
        cur_hand_combo = HandCombo() // start with an empty hand combo
        cur_hand_combo_box = -1 // represents no value
    }
    
    func select_random_box() -> Int {
        // selects and returns a random box
                
        let random_int = Int.random(in: 0..<self.DRAW_PROBABILITY_WEIGHTS.reduce(0,+)) // random number between 0 and the sum of all numbers in DRAW_PROBABILITY_WEIGHTS
        var probability_threshold = 0
        for index in 0..<self.DRAW_PROBABILITY_WEIGHTS.count {
            probability_threshold += self.DRAW_PROBABILITY_WEIGHTS[index]
            if (random_int < probability_threshold) {
                // choose this box
                return index
            }
        }
        return 0 // this won't happen
    }
    
    func draw_hand_combo() {
        // draw a random hand combo from the flashcard boxes and store it into self.cur_hand_combo
        
        // TODO: what if all flashcard boxes are empty?  Make sure they aren't, if they are return an empty hand combo.
        
        // select a flashcard box that has cards at random
        var selected_box = -1
        while (selected_box < 0) {
            let random_box = self.select_random_box()
            if (flashcard_boxes[random_box].flashcards.count > 0) {
                selected_box = random_box
            }
        }
              
        // select a hand combo from that flashcard box
        self.cur_hand_combo = flashcard_boxes[selected_box].pick_flashcard()
        self.cur_hand_combo_box = selected_box
        
        // debug
        print("selected box: \(selected_box)")
        print("selected hand combo: \(self.cur_hand_combo.short_description())")
        print("(best action: \(self.cur_hand_combo.best_action))")
        
        // decrement queue countdowns for all flashcard boxes
        for flashcard_box in flashcard_boxes {
            flashcard_box.decrement_queue_counts()
        }
    }
    
    func put_away_hand_combo(is_correct:Bool) {
        // put the hand combo back into the appropriate flashcard box queue
        // if is_correct is true, put the hand combo into the next box
        // if is_correct is false, put the hand combos into the previous box
        
        // get the box to put the hand combo away to
        var target_box = self.cur_hand_combo_box
        if is_correct {
            target_box += 1
        }
        else {
            target_box -= 1
        }
        if (target_box < 0) {
            target_box = 0
        }
        if (target_box >= self.flashcard_boxes.count) {
            target_box = self.flashcard_boxes.count - 1
        }
        
        // move the hand combo to the target box queue
        self.flashcard_boxes[target_box].queue.append(self.cur_hand_combo)
        self.flashcard_boxes[target_box].queue_countdown.append(QUEUE_COUNTDOWN)
        self.clear_cur_hand_combo() // clear the next hand combo
        
    }
    
    func all_hand_combos() -> [HandCombo] {
        // return all hand combos in the flashcard box manager
        
        var all_hand_combos:[HandCombo] = []
        for flashcard_box in flashcard_boxes {
            for hand_combo in flashcard_box.flashcards {
                all_hand_combos.append(hand_combo)
            }
            for hand_combo in flashcard_box.queue {
                all_hand_combos.append(hand_combo)
            }
        }
        return all_hand_combos
    }
    
    func contents_to_string() -> String {
        // output the contents of all flashcard boxes to a string
        var output_string:String = "[All Flashcard Boxes]\n"
    
        for index in 0..<flashcard_boxes.count {
            output_string += "Box \(index)\n"
            output_string += "Hand Combos: "
            for hand_combo in flashcard_boxes[index].flashcards {
                output_string += "[" + hand_combo.short_description() + "]; "
            }
            output_string += "\n"
            output_string += "Queue: "
            for queue_index in 0..<flashcard_boxes[index].queue.count {
                output_string += "[" + flashcard_boxes[index].queue[queue_index].short_description() + "](\(flashcard_boxes[index].queue_countdown[queue_index])); "
            }
            output_string += "\n"
        }
        return output_string
    }
}
    
class FlashcardBox {
    var flashcards = [HandCombo]() // set of hand combo flashcards to draw from
    var queue = [HandCombo]() // hand combos that were previously shown to the user and should not be shown again for queue_size hands
    
    var queue_countdown = [Int]() // the number of hands remaining until the hand combo can enter the main flashcard box
    
    func pick_flashcard() -> HandCombo{
        // randomly select a hand combo from the flashcard box. Remove it from the flashcard box.
        
        let index = Int.random(in: 0..<self.flashcards.count)
        let hand_combo = self.flashcards[index]
        self.flashcards.remove(at: index)
        return hand_combo
    }

    func decrement_queue_counts() {
        // function to decrement in_queue_countdown and add the flashcard to the main flashcard box when the countdown reaches 0
        
        for index in (0..<self.queue.count).reversed() { // iterate backwards so no elements are skipped when they're removed
            self.queue_countdown[index] -= 1
            if (self.queue_countdown[index] == 0) {
                // this hand combo has waited the required number of hands and is ready to be shown to the user again - move it to the flashcard array
                self.flashcards.append(self.queue[index]) // add the hand combo to the flashcard array for this box
                self.queue.remove(at:index) // remove the hand combo from the queue
                self.queue_countdown.remove(at:index) // remove the countdown as well
            }
        }
    }
    
}

