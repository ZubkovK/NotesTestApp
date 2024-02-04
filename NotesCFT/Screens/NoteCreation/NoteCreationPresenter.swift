//
//  NoteCreationPresenter.swift
//  NotesCFT
//
//  Created by Кирилл Зубков on 02.02.2024.
//

import Foundation


protocol NoteCreationDelegate: AnyObject {
    func didFinish(with text: String, for index: Int?)
}

protocol INoteCreationPresenter{
    func didTapSaveButton(with text: String?)
}

class NoteCreationPresenter {
    
    // MARK: - Propeties
    
    weak var delegate: NoteCreationDelegate?
    weak var view: INoteCreationView?
    
    private var editingIndex: Int?
    
    
    // MARK: - Interface
    
    func setEditing(text: String?, index: Int) {
        editingIndex = index
        view?.setTextField(text: text)
    }
    
}

extension NoteCreationPresenter: INoteCreationPresenter {
    
    // MARK: - INoteCreationPresenter
    
    func didTapSaveButton(with text: String?) {
        if let text, !text.isEmpty {
            delegate?.didFinish(with: text, for: editingIndex)
            view?.pop()
        } else {
            view?.showAlert(title: "Note is empty",
                            message: "Введите текст вашей заметки",
                            handler: nil)
        }
    }
   
}
