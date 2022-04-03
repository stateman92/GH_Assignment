//
//  MainScreen+Localization.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

extension MainScreen {
    enum Localized {
        static var title: String {
            L10n.Main.title
        }

        // swiftlint:disable:next identifier_name
        static var ok: String {
            L10n.Main.Search.ok
        }

        static var error: String {
            L10n.Main.Search.error
        }
    }
}
