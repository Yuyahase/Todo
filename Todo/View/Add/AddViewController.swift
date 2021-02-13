//
//  AddViewController.swift
//  Todo
//
//  Created by 長谷侑弥 on 2021/02/05.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var noteLabel: UITextField!
    @IBOutlet weak var deadLineLabel: UITextField!
    var datePicker: UIDatePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
    }

    private func createDatePicker() {
        datePicker.datePickerMode = .dateAndTime
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        datePicker.preferredDatePickerStyle = .inline
        deadLineLabel.inputView = datePicker

        let toolbar = UIToolbar()
        //Resizes and moves the receiver view so it just encloses its subviews.
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([doneButton], animated: true)
        deadLineLabel.inputAccessoryView = toolbar
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let todo = TodoModel()
        todo.id = NSUUID().uuidString
        todo.taskName = self.nameLabel.text ?? ""
        todo.note = self.noteLabel.text ?? nil
//        todo.deadLine = Date().convert(format: .yyyyMMdd, string: self.deadLineLabel.text)

        if TodoAccessor.sharedInstance.set(data: todo) {
            self.dismiss(animated: true, completion: nil)
        }else {
            print("error")
        }
    }

    @objc func doneClicked(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.locale    = NSLocale(localeIdentifier: "ja_JP") as Locale?
        deadLineLabel.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
}
extension AddViewController: UIPickerViewDelegate{

}
