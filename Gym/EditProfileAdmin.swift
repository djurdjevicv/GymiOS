//
//  EditProfileAdmin.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 2.3.22..
//

import UIKit
import CoreData

class EditProfileAdmin: UIViewController {
     
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var buttonSave: UIButton!
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    var allItems:[User]?
    
    let navItem = UINavigationItem(title: "Your data")
    let backItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addItemInNavBar()
        fetchUsers()
        getData()
        errorLabel.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        usernameTextField.isUserInteractionEnabled = false
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func fetchUsers(){
        
        allItems?.removeAll()

        do{
            self.allItems = try context.fetch(User.fetchRequest())
        }
        catch{

        }
        
    }
    
    func getData(){
        
        for admin in loginUser{
            firstNameTextField.text = admin.firstName
            lastNameTextField.text = admin.lastName
            passwordTextField.text = admin.password
            usernameTextField.text = admin.username
            emailTextField.text = admin.email
        }
    }
    
    func addItemInNavBar(){
        view.addSubview(navBar)
        navBar.backgroundColor = .darkGray
        backItem.tintColor = .white
        backItem.title = "< Back"
        backItem.action = #selector(back)
        navigationItem.backBarButtonItem = backItem
        navItem.leftBarButtonItem = backItem
        navItem.titleView?.backgroundColor = .darkGray
        navBar.barTintColor = .darkGray
        navBar.setItems([navItem], animated: false)
    }
    
    @objc func back(){
        let back = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.adminMenu) as? AdminMenu
        
        self.view.window?.rootViewController = back
    }

    func checkValue() -> Bool {
        
        if usernameTextField.text == "" || firstNameTextField.text == "" || lastNameTextField.text == "" || passwordTextField.text == "" || emailTextField.text == "" {
            errorLabel.text = "Some field is empty!"
            errorLabel.alpha = 1
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: emailTextField.text) == false{
            errorLabel.text = "Email must be like user@gmail.com!"
            errorLabel.alpha = 1
            return false
        }
        

       return true
    }
    
    
    @IBAction func saveTapped(_ sender: Any) {
        
        if checkValue(){
            
            for user in allItems!{
                for admin in loginUser{
                    if user.username == admin.username{
                        user.firstName = firstNameTextField.text
                        user.lastName = lastNameTextField.text
                        user.password = passwordTextField.text
                        user.email = emailTextField.text
                        
                        admin.firstName = firstNameTextField.text
                        admin.lastName = lastNameTextField.text
                        admin.password = passwordTextField.text
                        admin.email = emailTextField.text
                    }
                }
            }
            
            try! self.context.save()
            getData()
            
            let alertController = UIAlertController(title: "Succesful edit", message: .none,  preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion: nil)
            
            let submitAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK")
            }

            alertController.addAction(submitAction)
        }
            
        }
        

    
    
    
    
    
    
        

}


