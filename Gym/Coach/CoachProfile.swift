//
//  CeoachProfile.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 19.3.22..
//

import UIKit

class CoachProfile: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var usersList:[User]?
    

    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchUsers()
        setDataInTextField()
        errorLabel.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        usernameTextField.isUserInteractionEnabled = false

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func fetchUsers(){

        do{
            self.usersList = try context.fetch(User.fetchRequest())
        }
        catch{

        }
    }
    
    func setDataInTextField(){
        
        for user in loginUser{
            firstNameTextField.text = user.firstName
            lastNameTextField.text = user.lastName
            passwordTextField.text = user.password
            usernameTextField.text = user.username
            emailTextField.text = user.email
        }
        
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
        
        if checkValue() == true{
            for user in usersList!{
                for loginUser in loginUser{
                    if user.username == loginUser.username{
                        user.firstName = firstNameTextField.text
                        user.lastName = lastNameTextField.text
                        user.password = passwordTextField.text
                        user.email = emailTextField.text
                        
                        loginUser.firstName = firstNameTextField.text
                        loginUser.lastName = lastNameTextField.text
                        loginUser.password = passwordTextField.text
                        loginUser.email = emailTextField.text
                    }
                }
            }
            
            try! self.context.save()
            setDataInTextField()
            
            let alertController = UIAlertController(title: "Succesful edit", message: .none,  preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion: nil)
            
            let submitAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK")
            }

            alertController.addAction(submitAction)
        }
    }
        

        
        
    
    
    @IBAction func logoffTapped(_ sender: Any) {
        
        loginUser.removeAll()
        let home = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.homeApp) as? ViewController
        
        self.view.window?.rootViewController = home
    }
    
}
