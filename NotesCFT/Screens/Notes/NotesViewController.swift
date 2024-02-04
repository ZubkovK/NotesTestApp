//
//  NotesViewController.swift
//  NotesCFT
//
//  Created by Кирилл Зубков on 01.02.2024.
//

import UIKit
import SnapKit

protocol INotesView: AnyObject {
    func display(viewModels: [NoteViewCell.Model])
    func showNoteCreation(delegate: NoteCreationDelegate?,
                          text: String?,
                          index: Int?)
}

class NotesViewController: UIViewController {
    
    // MARK: - Properties
    
    private let presenter: INotesPresenter
    private var viewModels = [NoteViewCell.Model]()
    
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .lightGray
        tableView.register(NoteViewCell.self,
                           forCellReuseIdentifier: String(describing: NoteViewCell.self))
        return tableView
    }()
    
    private lazy var addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                                 target: self,
                                                 action: #selector(didTapAddButton))
    
    
    // MARK: - Init
    
    init(presenter: INotesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addConstraints()
        presenter.viewDidLoad()
    }
    
    
    // MARK: - Private Methods
    
    private func addViews() {
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func addConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    // MARK: - OBJC Methods
    
    @objc
    private func didTapAddButton() {
        presenter.didTapAddButton()
    }
    
}

extension NotesViewController: INotesView {
    
    // MARK: - INotesView

    func display(viewModels: [NoteViewCell.Model]) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
    
    func showNoteCreation(delegate: NoteCreationDelegate?, 
                          text: String?,
                          index: Int?) {
        let presenter = NoteCreationPresenter()
        let vc = NoteCreationViewController(presenter: presenter)
        presenter.view = vc
        presenter.delegate = delegate
        
        if let index {
            presenter.setEditing(text: text, index: index)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension NotesViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NoteViewCell.self),
                                                       for: indexPath) as? NoteViewCell
        else { return UITableViewCell() }
        
        let viewModel = viewModels[indexPath.row]
        cell.display(model: viewModel)
        return cell
    }
    
}

extension NotesViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, 
                                              title: "Удалить",
                                              handler: { [weak self] _, _, _ in
            self?.presenter.didInitiateRemove(index: indexPath.row)
        })
    
        let removeConfiguration = UISwipeActionsConfiguration(actions: [removeAction])
        return removeConfiguration
    }
    
}
