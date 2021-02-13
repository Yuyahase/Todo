//
//  ViewController.swift
//  Todo
//
//  Created by 長谷侑弥 on 2021/02/05.
//

import UIKit
import FloatingPanel
import RealmSwift

class ViewController: UIViewController, UIAdaptivePresentationControllerDelegate {

    var todos: [TodoModel] = []
    var fpc: FloatingPanelController!
    var notificationToken: NotificationToken? = nil

    @IBOutlet weak var tableView: UITableView!

    //Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        fpc = FloatingPanelController()
        fpc.delegate = self

        //Registers a class for use in creating new table cells.
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"TableViewCell")
        
        self.navigationItem.title = "Main"

        let addButton = UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(tapAddButton))

        self.navigationItem.rightBarButtonItem = addButton

        self.todos = TodoAccessor.sharedInstance.getAll()

        let realm = try! Realm()
        notificationToken = realm.objects(TodoModel.self).observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update:
                self!.todos = TodoAccessor.sharedInstance.getAll()
                tableView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }

    deinit {
        notificationToken?.invalidate()
    }

    @objc func tapAddButton() {
        let contentVC = AddViewController()
        fpc.set(contentViewController: contentVC)
        fpc.presentationController?.delegate = self
        fpc.isRemovalInteractionEnabled = true
        fpc.layout = MyFloatingPanelLayout()
        fpc.addPanel(toParent: self)
    }
}
extension ViewController: UITableViewDelegate {

}
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }

    //Asks the data source for a cell to insert in a particular location of the table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = self.todos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.setData(model: todo)
        return cell
    }

    // Called after the user changes the selection.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
            if TodoAccessor.sharedInstance.delete(data: self.todos[indexPath.row]) {
                self.todos.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath as IndexPath], with: .automatic)
            }
        }
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = todos[sourceIndexPath.row]
        //元の位置のデータを配列から削除
        todos.remove(at:sourceIndexPath.row)
        //移動先の位置にデータを配列に挿入
        todos.insert(todo, at: destinationIndexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension ViewController: FloatingPanelControllerDelegate{
    class MyFloatingPanelLayout: FloatingPanelLayout {
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .tip
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .tip: FloatingPanelLayoutAnchor(absoluteInset: 180.0, edge: .bottom, referenceGuide: .safeArea),
            ]
        }
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

