//
//  AlramMD.swift
//  Watch
//
//  Created by 이가영 on 2020/05/07.
//  Copyright © 2020 이가영. All rights reserved.
//

import Foundation

struct AlramMD {
    var clock: Timer
    var repeatAlram: String
    var nameAlram: String
    
    init(clock: Timer, repeatAlram: String, nameAlram: String) {
        self.clock = clock
        self.repeatAlram = repeatAlram
        self.nameAlram = nameAlram
    }
}