//
//  Utility.swift
//  Pokedex
//
//  Created by Fuu on 2021/09/12.
//

import Foundation

func fillId(id: String) -> String {
    if id.count == 0 {
        return ""
    }
    
    if Int(id)! < 10 {
        return "00" + id
    } else if (Int(id)! < 100) {
        return "0" + id
    } else {
        return id
    }
}
