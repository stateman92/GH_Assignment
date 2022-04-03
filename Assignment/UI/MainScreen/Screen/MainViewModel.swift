//
//  MainViewModel.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Combine
import SafariServices

final class MainViewModel: BaseViewModel {
    @LazyInjected private var networkService: NetworkServiceProtocol
    @LazyInjected private var loadingService: LoadingServiceProtocol

    @Throttling(seconds: 0.66) var searchTerm: String = .init()

    let searchModelSubject = CurrentValueSubject<SearchModel, Never>(.init(items: []))
    let errorSubject = PassthroughSubject<Error, Never>()

    private var nextPage = 1
    private let perPage = 10
    private var fetchingInProgress = false

    override init() {
        super.init()
        setup()
    }
}

extension MainViewModel {
    func getMoreResults() {
        guard !fetchingInProgress else { return }
        fetchingInProgress = true
        searchTermDidChange(searchTerm, newSearch: false)
    }

    func getItem(with index: Int) -> SearchItemModel? {
        guard searchModelSubject.value.items.indices.contains(index) else { return nil }
        return searchModelSubject.value.items[index]
    }

    func didSelect(index: Int) {
        guard let item = getItem(with: index), let url = URL(string: item.url) else { return }
        navigator.present(SFSafariViewController(url: url), animated: true)
    }
}

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
            nextPage = 1
            resetModel()
        } else {
            nextPage += 1
        }
        loadingService.loading { finished in
            networkService.searchRepositories(searchTerm: searchTerm,
                                              perPage: perPage,
                                              page: nextPage) { [weak self] in
                finished()
                self?.handle(searchResult: $0.map(\.mapped))
            }
        }
    }

    private func handle(searchResult: Result<SearchModel, Error>) {
        fetchingInProgress = false
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
