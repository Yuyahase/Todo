//
//  TableViewCell.swift
//  Todo
//
//  Created by 長谷侑弥 on 2021/02/05.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var mainBackground: UIView!
    @IBOutlet weak var taskLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainBackground.layer.cornerRadius = 8
        self.mainBackground.layer.masksToBounds = true
        self.mainBackground.backgroundColor = .white
        self.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    /// データを画面項目にセットする
    /// - parameter model: データモデル
    func setData(model: TodoModel) {
        self.taskLabel.text = model.taskName
    }
}
