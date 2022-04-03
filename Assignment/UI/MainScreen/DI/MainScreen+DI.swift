//
//  MainScreen+DI.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

extension DependencyInjector {
    static func registerMainModule() {
        resolver.register { MainScreen() }
        resolver.register { MainViewModel() }
    }
}
