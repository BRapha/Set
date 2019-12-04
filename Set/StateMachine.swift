//
//  StateMachine.swift
//  Set
//
//  Created by Raphael Blistein on 21.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import Foundation

struct State {
    let mode: GamePlayVCMode
    let visibleCards: Array<PlayingCard>
}

enum GamePlayVCMode {
    case newGame
    case continueGame(disabledPlayer: Int?)
    case playersTurn(player: Int)
    case checking
}

struct Player {
    let name: String
    var points: Int
}
