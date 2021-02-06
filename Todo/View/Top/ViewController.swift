//
//  ViewController.swift
//  Todo
//
//  Created by 長谷侑弥 on 2021/02/05.
//

import UIKit

class ViewController: UIViewController {

    var TODO: [String] = ["牛乳を買う", "掃除をする", "アプリ開発の勉強をする"]

    @IBOutlet weak var tableView: UITableView!

    //Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        //Registers a class for use in creating new table cells.
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"TableViewCell")
        
        self.navigationItem.title = "Main"

        let addButton = UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(tapAddButton))

        self.navigationItem.rightBarButtonItem = addButton
    }

    @objc func tapAddButton() {
        let vc = AddViewController()
        //The transition style to use when presenting the view controller.
        vc.modalTransitionStyle = .coverVertical

        //The presentation style for modal view controllers.
        vc.modalPresentationStyle = .automatic

        //Presents a view controller modally.
        self.present(vc, animated: true, completion: nil)
    }
}
extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TODO.count
    }

    //Asks the data source for a cell to insert in a particular location of the table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.taskLabel.text = TODO[indexPath.row]

        //this determines the number of lines to draw and what to do when sizeToFit is called. default value is 1 (single line). A value of 0 means no limit
        cell.textLabel?.numberOfLines = 0

        return cell
    }

    // Called after the user changes the selection.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    //Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    //Asks the data source to commit the insertion or deletion of a specified row in the receiver.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            TODO.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = TODO[sourceIndexPath.row]
        //元の位置のデータを配列から削除
        TODO.remove(at:sourceIndexPath.row)
        //移動先の位置にデータを配列に挿入
        TODO.insert(todo, at: destinationIndexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


class ShadowView: UIView {
    //The bounds rectangle, which describes the view’s location and size in its own coordinate system.
    override var bounds: CGRect{
        didSet{
            setupShadow()
        }
    }

    private func setupShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        //A Boolean that indicates whether the layer is rendered as a bitmap before compositing. Animatable
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

