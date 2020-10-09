//
//  ViewController.swift
//  Verifierer
//
//  Created by Георгий Андреев on 07.10.2020.
//

import UIKit



class TwoViewController: UIViewController, UITextFieldDelegate {
    
   
    @IBOutlet weak var dataInput: UITextField!
    @IBOutlet weak var gendersInput: UITextField!
    @IBOutlet weak var NameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var emailInput: UITextField!
    let pickerView = ToolbarPickerView()
    var genderPickerValues = ["Мужской", "Женский", "Другой"]
    
    @objc func tapDone() {
        if let datePicker = self.dataInput.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateFormat = "dd/MM/yyyy"
//            dateformatter.dateStyle = .medium // 2-3
            dateformatter.locale = NSLocale.init(localeIdentifier: "ru") as Locale
            self.dataInput.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.dataInput.resignFirstResponder() // 2-5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIcon(iconName: "person", input: NameInput)
        setIcon(iconName: "mail", input: emailInput)
        setIcon(iconName: "lock", input: passwordInput)
        setIcon(iconName: "person.3", input: gendersInput)
        setIcon(iconName: "doc", input: dataInput)
        
        
        self.gendersInput.inputView = self.pickerView
        self.gendersInput.inputAccessoryView = self.pickerView.toolbar
        self.gendersInput.delegate = self

        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self

        self.pickerView.reloadAllComponents()
        self.dataInput.setInputViewDatePicker(target: self, selector: #selector(tapDone))

           
        // Do any additional setup after loading the view.
    }
    
    
    
    func setIcon (iconName: String, input: UITextField) {
        let padding = 20
        input.layer.cornerRadius = input.frame.size.height / 2
        input.clipsToBounds = true
        input.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView()
        let image = UIImage(systemName: iconName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.image = image
        if (padding > 0) {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fill
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            let paddingView = UIView()
            paddingView.translatesAutoresizingMaskIntoConstraints = false
            paddingView.widthAnchor.constraint(equalToConstant: CGFloat(padding)).isActive = true
            paddingView.heightAnchor.constraint(equalToConstant: CGFloat(padding)).isActive = true
            stackView.addArrangedSubview(paddingView)
            stackView.addArrangedSubview(imageView)
            input.leftView = stackView
        } else {
            input.leftView = imageView
        }
    
    }

}


extension TwoViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.genderPickerValues.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.genderPickerValues[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.gendersInput.text = self.genderPickerValues[row]
    }
}

extension TwoViewController: ToolbarPickerViewDelegate {

   @objc func didTapDone() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
        self.gendersInput.text = self.genderPickerValues[row]
        self.gendersInput.resignFirstResponder()
    }

    @objc func didTapCancel() {
        self.gendersInput.text = nil
        self.gendersInput.resignFirstResponder()
    }
}



