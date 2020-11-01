//
//  RegisterViewController.swift
//  Verifierer
//
//  Created by Георгий Андреев on 11.10.2020.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    let pickerView = ToolbarPickerView()
    var genderPickerValues = ["Мужской", "Женский", "Другой"]
    var newView = Register()
    var genderId: Int?
    var bod: String?
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       return textField.resignFirstResponder()
    }
    
    
    @objc func tapDone() {
        if let datePicker = self.newView.dateInput.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateFormat = "dd/MM/yyyy"
//            dateformatter.dateStyle = .medium // 2-3
            dateformatter.locale = NSLocale.init(localeIdentifier: "ru") as Locale
            self.newView.dateInput.text = dateformatter.string(from: datePicker.date) //2-4
            let dateformatter2 = DateFormatter() // 2-2
            dateformatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSxxx"
//            dateformatter.dateStyle = .medium // 2-3
            self.bod = dateformatter2.string(from: datePicker.date) //2-4
        }
        self.newView.dateInput.resignFirstResponder() // 2-5
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let allViewsInXibArray = Bundle.main.loadNibNamed("Register", owner: self, options: nil)

        //If you only have one view in the xib and you set it's class to MyView class
        self.newView = allViewsInXibArray?.first as! Register

        //Set wanted position and size (frame)
        self.newView.frame = self.view.bounds

        //Add the view
        self.view.addSubview(self.newView)
        
        setIcon(iconName: "person", input: self.newView.nameInput)
        setIcon(iconName: "mail", input: self.newView.emailInput)
        setIcon(iconName: "lock", input: self.newView.passwordInput)
        setIcon(iconName: "person.3", input: self.newView.gendersInput)
        setIcon(iconName: "doc", input: self.newView.dateInput)
        
        
        self.newView.gendersInput.inputView = self.pickerView
        self.newView.gendersInput.inputAccessoryView = self.pickerView.toolbar
        self.newView.gendersInput.delegate = self
        self.newView.delegate = self

        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self

        self.pickerView.reloadAllComponents()
        self.newView.dateInput.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        self.newView.emailInput.delegate = self
        self.newView.passwordInput.delegate = self
        self.newView.gendersInput.delegate = self
        self.newView.nameInput.delegate = self
        self.newView.dateInput.delegate = self
    }
    
    func setIcon (iconName: String, input: UITextField) {
        let padding = 20	
        input.layer.cornerRadius = input.frame.size.height / 2
        input.clipsToBounds = false
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension RegisterViewController: UIPickerViewDataSource, UIPickerViewDelegate {

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
        self.newView.gendersInput.text = self.genderPickerValues[row]
    }
}

extension RegisterViewController: ToolbarPickerViewDelegate {

   @objc func didTapDone() {
    let row = self.pickerView.selectedRow(inComponent: 0)
    self.pickerView.selectRow(row, inComponent: 0, animated: false)
    self.newView.gendersInput.text = self.genderPickerValues[row]
    self.genderId = row + 1
    self.newView.gendersInput.resignFirstResponder()
    }

    @objc func didTapCancel() {
        self.newView.gendersInput.text = nil
        self.genderId = nil
        self.newView.gendersInput.resignFirstResponder()
    }
}


extension RegisterViewController: RegisterDelegate {
    func send() {
        
        let register = RegisterForm(email: self.newView.emailInput.text!, name: self.newView.nameInput.text!, genderId: self.genderId!, bod: self.bod!, password: self.newView.passwordInput.text!, phone: "0")
        
        AF.request(NetworkService.BaseUrl + "user/register",
                   method: .post,
                   parameters: register,
                   encoder: JSONParameterEncoder.default).validate().response { response in
                    debugPrint(response)
                    if(response.response?.statusCode == 200) {
                        UserDefaults.standard.set(true, forKey: "LOGGED_IN")
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                            let sceneDelegate = windowScene.delegate as? SceneDelegate
                          else {
                            return
                          }
                        sceneDelegate.rootViewController.showSplashScreen()
                    } else {
                        let alert = UIAlertController(title: "Ошибка регистрации", message: "Ошибка", preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

                        window?.rootViewController?.present(alert, animated: true, completion: nil)
                    }
        }
    }
}
