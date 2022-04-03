//
//  MainViewModel.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Combine
import SafariServices

final class MainViewModel: BaseViewModel {
    // MARK: Properties

    let searchModelSubject = CurrentValueSubject<SearchModel, Never>(.init(items: []))
    let errorSubject = PassthroughSubject<Error, Never>()
    @Throttling(seconds: 0.66) var searchTerm: String = .init()
    private let pageHandler = PageHandler()

    // MARK: Initialization

    override init() {
        super.init()
        setup()
    }
}

// MARK: - Public methods

extension MainViewModel {
    /// Get the next page of the results.
    func getMoreResults() {
        guard pageHandler.fetchIfPossible() else { return }
        searchTermDidChange(searchTerm, newSearch: false)
    }

    /// Get the n-th repository.
    /// - Parameter index: the index of the desired repository.
    /// - Returns: the `SearchItemModel`.
    func getItem(with index: Int) -> SearchItemModel? {
        guard searchModelSubject.value.items.indices.contains(index) else { return nil }
        return searchModelSubject.value.items[index]
    }

    /// Call if the user selected a repository.
    /// - Parameter index: the index of the selected repository.
    /// - Note: the user wants to "see the repository’s website without leaving the application."
    /// With the current implementation the user definitely does not leave the app,
    /// but for a not well skilled user may think that they switched to Safari.
    func didSelect(index: Int) {
        guard let item = getItem(with: index), let url = URL(string: item.url) else { return }
        navigator.present(SFSafariViewController(url: url), animated: true)
    }
}

// MARK: - Setups

extension MainViewModel {
    private func setup() {
        $searchTerm.on { [weak self] in self?.searchTermDidChange($0) }
    }

    private func searchTermDidChange(_ searchTerm: String, newSearch: Bool = true) {
        guard !searchTerm.isEmpty else {
            resetModel()
            return
        }
        if newSearch {
            pageHandler.reset()
            resetModel()
        } else {
            pageHandler.incrementPage()
        }
        loadingService.loading { finished in
            self.networkService.searchRepositories(searchTerm: searchTerm,
                                                   perPage: self.pageHandler.objectsPerPage,
                                                   page: self.pageHandler.nextPage) { [weak self] in
                finished()
                self?.handle(searchResult: $0.map(\.mapped))
            }
        }
    }

    private func handle(searchResult: Result<SearchModel, Error>) {
        pageHandler.fetchFinished()
        switch searchResult {
        case let .success(result):
            var items = searchModelSubject.value.items
            items.append(contentsOf: result.items)
            searchModelSubject.send(.init(items: items))
        case let .failure(error):
            resetModel()
            errorSubject.send(error)
        }
    }

    private func resetModel() {
        searchModelSubject.send(.init(items: []))
    }
}
