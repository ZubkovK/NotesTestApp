//
//  NoteCreationViewController.swift
//  NotesCFT
//
//  Created by Кирилл Зубков on 02.02.2024.
//

import UIKit
import SnapKit

protocol INoteCreationView: AnyObject {
    func showAlert(title: String?,
                   message: String,
                   handler: (() -> Void)?)
    
    func pop()
    func setTextField(text: String?)
}

class NoteCreationViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let newNoteTopOffset: CGFloat = 100
        static let newNoteTrailingOffset: CGFloat = -35
        static let newNoteLeadingOffset: CGFloat = 35
        static let newNoteHeight: CGFloat = 70
        
        static let saveButtonTopOffset: CGFloat = 20
        static let saveButtonTrailingOffset: CGFloat = -35
        static let saveButtonLeadingOffset: CGFloat = 35
        static let saveButtonHeight: CGFloat = 40
        
    }
    
    
    // MARK: - Properties
    
    let presenter: INoteCreationPresenter
    
    private var newNoteTF = {
        var newNoteTF = UITextField()
        newNoteTF.placeholder = "Введите текст вашей заметки"
        newNoteTF.backgroundColor = .white
        return newNoteTF
        }()
    
    private var textInNote = {
        var textInNote = ""
        return textInNote
    }()
    
    private lazy var saveButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.backgroundColor = .systemGreen
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        return saveButton
    }()
    
    
    // MARK: - Init
    
    init(presenter: INoteCreationPresenter) {
        self.presenter = presenter
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        addViews()
        addConstaints()
    }
    
    
    // MARK: - Private Methods
    
    private func addViews() {
        view.addSubview(newNoteTF)
        view.addSubview(saveButton)
    }
    
    private func addConstaints() {
        newNoteTF.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.newNoteTopOffset)
            make.leading.equalToSuperview().offset(Constants.newNoteLeadingOffset)
            make.trailing.equalToSuperview().offset(Constants.newNoteTrailingOffset)
            make.height.greaterThanOrEqualTo(Constants.newNoteHeight)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(newNoteTF.snp.bottom).offset(Constants.saveButtonTopOffset)
            make.leading.equalToSuperview().offset(Constants.saveButtonLeadingOffset)
            make.trailing.equalToSuperview().offset(Constants.saveButtonTrailingOffset)
            make.height.equalTo(Constants.saveButtonHeight)
        }
        
    }
    
    
    // MARK: - OBJC Methods
    
    @objc
    private func didTapSaveButton() {
        presenter.didTapSaveButton(with: newNoteTF.text)
    }
    
}

extension NoteCreationViewController: INoteCreationView {
   
    func pop() {
        navigationController?.popViewController(animated: true)
    }    

    func showAlert(title: String?,
                   message: String,
                   handler: (() -> Void)?) {
        let alert = UIAlertController(title:title ,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            handler?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func setTextField(text: String?) {
        newNoteTF.text = text 
    }
   
}
