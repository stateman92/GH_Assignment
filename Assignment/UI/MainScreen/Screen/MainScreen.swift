//
//  MainScreen.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

final class MainScreen: BaseTableScreen<MainViewModel> {
    // MARK: Properties

    private let searchController = UISearchController(searchResultsController: nil)
    private let emptyStateView = EmptyStateView()
}

// MARK: - Lifecycle

extension MainScreen {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deselectTableViewCells()
    }
}

// MARK: - Setups

extension MainScreen {
    private func setupUI() {
        title = Localized.title
        view.backgroundColor = .systemBackground

        setupSearchBar()
        setupTableView()
        setupEmptyStateView()
    }

    private func setupSearchBar() {
        searchController.configure {
            $0.searchBar.delegate = self
            navigationItem.searchController = $0
        }
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func setupTableView() {
        tableView.configure {
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .none
            $0.register(MainTableViewCell.self)
        }
    }

    private func setupEmptyStateView() {
        emptyStateView.configure {
            view.addSubview($0)

            $0.anchorToCenter()
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        }
    }

    private func setupBindings() {
        viewModel.searchModelSubject
            .sink { [unowned self] _ in searchModelDidChange() }
            .store(in: &cancellables)

        viewModel.errorSubject
            .sink { [unowned self] in
                let alertController = UIAlertController(title: Localized.error,
                                                        message: $0.localizedDescription,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: Localized.ok, style: .default))
                present(alertController, animated: true)
            }
            .store(in: &cancellables)
    }
}

// MARK: - UISearchBarDelegate

extension MainScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchTerm = searchText
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        viewModel.$searchTerm.force(value: searchText)
    }
}

// MARK: - UITableViewDataSource

extension MainScreen {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchModelSubject.value.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel.getItem(with: indexPath.row) else { return .init() }
        let cell: MainTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.setup(with: item)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainScreen {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(index: indexPath.row)
    }

    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.searchModelSubject.value.items.count - 1 {
            viewModel.getMoreResults()
        }
    }
}

// MARK: - Helpers

extension MainScreen {
    private func deselectTableViewCells() {
        guard let selectedIndexPaths = tableView.indexPathsForSelectedRows else { return }
        if let coordinator = transitionCoordinator {
            coordinator.animateAlongsideTransition(
                in: parent?.view,
                animation: { [weak self] coordinatorContext in
                    selectedIndexPaths.forEach {
                        self?.tableView.deselectRow(at: $0, animated: coordinatorContext.isAnimated)
                    }
                }, completion: { [weak self] coordinatorContext in
                    if coordinatorContext.isCancelled {
                        selectedIndexPaths.forEach {
                            self?.tableView.selectRow(at: $0, animated: false, scrollPosition: .none)
                        }
                    }
                }
            )
        } else {
            selectedIndexPaths.forEach {
                tableView.deselectRow(at: $0, animated: false)
            }
        }
    }

    private func searchModelDidChange() {
        tableView.reloadData()
        if viewModel.searchModelSubject.value.items.isEmpty {
            emptyStateView.play()
            tableView.isScrollEnabled = false
            UIView.animate(withDuration: 0.25) {
                self.emptyStateView.alpha = 1
            }
        } else {
            tableView.isScrollEnabled = true
            UIView.animate(withDuration: 0.25) {
                self.emptyStateView.alpha = .zero
            } completion: { didFinish in
                if didFinish {
                    self.emptyStateView.pause()
                }
            }
        }
    }
}
