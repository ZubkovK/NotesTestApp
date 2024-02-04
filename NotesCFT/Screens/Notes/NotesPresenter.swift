//
//  NotesPresenter.swift
//  NotesCFT
//
//  Created by Кирилл Зубков on 01.02.2024.
//

import Foundation

protocol INotesPresenter {
    func viewDidLoad()
    func didTapAddButton()
    func didSelect(index: Int)
    func didInitiateRemove(index: Int)
}

class NotesPresenter {
    
    // MARK: - Propetires
    
    weak var view: INotesView?

    private var notes = [Note]()
    
    
    // MARK: - Private Methods
    
    private func updateView() {
        let viewModels = notes.map { NoteViewCell.Model(text: $0.text) }
        view?.display(viewModels: viewModels)
    }
    
}

extension NotesPresenter: INotesPresenter {
    
    // MARK: - INotesPresenter

    func viewDidLoad() {
        notes = DBManager.sharedInstance.getNotes().map { $0 }
        updateView()
    }
    
    func didTapAddButton() {
        view?.showNoteCreation(delegate: self, text: nil, index: nil)
    }
    
    func didSelect(index: Int) {
        let note = notes[index]
        view?.showNoteCreation(delegate: self, text: note.text, index: index)
    }
 
    func didInitiateRemove(index: Int) {
        let removedNote = notes.remove(at: index)
        DBManager.sharedInstance.remove(note: removedNote)
        updateView()
    }
    
}

extension NotesPresenter: NoteCreationDelegate {
    
    // MARK: - NoteCreationDelegate
    
    func didFinish(with text: String, for index: Int?) {
        if let index {
            let note = notes[index]
            DBManager.sharedInstance.edit(note: note, newText: text)
        } else {
            let note = Note()
            note.text = text
            notes.append(note)
            DBManager.sharedInstance.add(note: note)
        }
        updateView()
    }
    
}
