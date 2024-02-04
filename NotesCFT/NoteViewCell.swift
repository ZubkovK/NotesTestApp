//
//  NoteViewCell.swift
//  
//
//  Created by Кирилл Зубков on 02.02.2024.
//

import UIKit
import SnapKit

class NoteViewCell: UITableViewCell {
    
    // MARK: - Model
    
    struct Model {
        let text: String
    }
    
    
    // MARK: - Properties
    
    private let noteLabel = {
        let noteLabael = UILabel()
        noteLabael.numberOfLines = 0
        return noteLabael
    }()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Interface
    
    func display(model: Model) {
        noteLabel.text = model.text
    }
    
    
    // MARK: - Private Methods
    
    private func addViews() {
        contentView.addSubview(noteLabel)
    }
    
    private func addConstraints() {
        noteLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
            make.bottom.trailing.equalToSuperview().offset(-5)
            make.height.greaterThanOrEqualTo(44)
        }
    }
    
}
