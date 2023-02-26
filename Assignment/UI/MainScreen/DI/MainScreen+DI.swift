//
//  MainScreen+DI.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

extension DependencyInjector {
    static let mainScreen = create { MainScreen() }
    static let mainViewModel = create { MainViewModel() }
}
