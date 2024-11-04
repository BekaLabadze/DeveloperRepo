//
//  LoginScreenViewModel.swift
//  Assignmentest123
//
//  Created by Beka on 02.11.24.
//

class LoginScreenViewModel {
    func save(password: String) {
        KeyChainManager.save(key: "password", password: password)
    }
    
    func load() -> String? {
        let password = KeyChainManager.load(key: "password")
        return password
    }
}
