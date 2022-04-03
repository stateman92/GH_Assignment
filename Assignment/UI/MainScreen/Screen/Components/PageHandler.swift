//
//  PageHandler.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 03..
//

final class PageHandler {
    let objectsPerPage = 10

    private(set) var nextPage = 1
    private var fetchingInProgress = false
}

extension PageHandler {
    func fetchIfPossible() -> Bool {
        guard !fetchingInProgress else { return false }
        fetchingInProgress = true
        return true
    }

    func reset() {
        nextPage = 1
    }

    func incrementPage() {
        nextPage += 1
    }

    func fetchFinished() {
        fetchingInProgress = false
    }
}
