//
//  SignUpViewController.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 1.3.22..
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInText: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var usersList:[User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchUsers()
        textField()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        errorLabel.alpha = 0
    }
    
    func textField(){
        let myColor = UIColor.white
        usernameTextField.layer.borderColor = myColor.cgColor
        passwordTextField.layer.borderColor = myColor.cgColor
        firstNameTextField.layer.borderColor = myColor.cgColor
        lastNameTextField.layer.borderColor = myColor.cgColor
        emailTextField.layer.borderColor = myColor.cgColor
        
        usernameTextField.layer.cornerRadius = 15.0
        passwordTextField.layer.cornerRadius = 15.0
        firstNameTextField.layer.cornerRadius = 15.0
        lastNameTextField.layer.cornerRadius = 15.0
        emailTextField.layer.cornerRadius = 15.0
        
        
        usernameTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderWidth = 2.0
        firstNameTextField.layer.borderWidth = 2.0
        lastNameTextField.layer.borderWidth = 2.0
        emailTextField.layer.borderWidth = 2.0
        
        usernameTextField.layer.borderColor = UIColor.red.cgColor
        passwordTextField.layer.borderColor = UIColor.red.cgColor
        firstNameTextField.layer.borderColor = UIColor.red.cgColor
        lastNameTextField.layer.borderColor = UIColor.red.cgColor
        emailTextField.layer.borderColor = UIColor.red.cgColor
        
        usernameTextField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        firstNameTextField.attributedPlaceholder = NSAttributedString(
            string: "First name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        lastNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Last name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )


        signInText.titleLabel?.font = UIFont(name: "San Francisco", size: 19)

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
    
    func generateNewId() -> Int64{
        
        var max: Int64 = -1
        for user in usersList!{
            if user.id > max{
                max = user.id
            }

        }
        return max + 1
    }
    
    func checkValue() -> Bool {
        
        if usernameTextField.text == "" || firstNameTextField.text == "" || lastNameTextField.text == "" || passwordTextField.text == "" || emailTextField.text == ""{
            errorLabel.text = "Some field is empty!"
            errorLabel.alpha = 1
            return false
        }
        for user in usersList!{
            if user.username == usernameTextField.text{
                errorLabel.text = "Username already exists!"
                errorLabel.alpha = 1
                return false
            }
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
    
    
    @IBAction func signInTapped(_ sender: Any) {
        let login = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.login) as? LoginViewController

        self.view.window?.rootViewController = login

        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        if checkValue() == true{
            let newBeginner = Beginner(context: self.context)
            newBeginner.username = usernameTextField.text
            newBeginner.lastName = lastNameTextField.text
            newBeginner.password = passwordTextField.text
            newBeginner.firstName = firstNameTextField.text
            newBeginner.id = self.generateNewId()
            newBeginner.userType = "beginner"
            newBeginner.email = emailTextField.text

            do{
                try self.context.save()
            }
            catch{

            }

            self.fetchUsers()

            let alertController = UIAlertController(title: "Successful signup", message: .none,  preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion: nil)
            
            let submitAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK")
            }
            
            
            alertController.addAction(submitAction)
            
            let homeApp = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.homeApp) as? ViewController

            self.view.window?.rootViewController = homeApp

            self.view.window?.makeKeyAndVisible()
        }
        



        
    }
    
}
