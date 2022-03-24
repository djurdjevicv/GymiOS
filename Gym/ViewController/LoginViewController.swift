//
//  LoginViewController.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 1.3.22..
//

import UIKit


class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpText: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var usersList:[User]?
    var beginnerList:[Beginner]?
    var coachList:[Coach]?
    var adminList:[Administrator]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchUsers()
        fetchBeginner()
        fetchCoach()
        fetchAdmin()
        passwordTextField.isSecureTextEntry = true
        textField()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }

    func textField(){
        let myColor = UIColor.white
        usernameTextField.layer.borderColor = myColor.cgColor
        passwordTextField.layer.borderColor = myColor.cgColor
        usernameTextField.layer.cornerRadius = 15.0
        passwordTextField.layer.cornerRadius = 15.0
        usernameTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderWidth = 2.0
        usernameTextField.layer.borderColor = UIColor.red.cgColor
        passwordTextField.layer.borderColor = UIColor.red.cgColor
        usernameTextField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )

        signUpText.titleLabel?.font = UIFont(name: "San Francisco", size: 19)

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
    func fetchBeginner(){

        do{
            self.beginnerList = try context.fetch(Beginner.fetchRequest())
        }
        catch{

        }
    }
    func fetchCoach(){

        do{
            self.coachList = try context.fetch(Coach.fetchRequest())
        }
        catch{

        }
    }
    func fetchAdmin(){

        do{
            self.adminList = try context.fetch(Administrator.fetchRequest())
        }
        catch{

        }
    }
    
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        let signup = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.signup) as? SignUpViewController

        self.view.window?.rootViewController = signup

        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        

        for beginner in beginnerList!{
            if beginner.username == usernameTextField.text && beginner.password == passwordTextField.text{
                loginUser.append(beginner)
                let beginnerHome = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.beginnerHome) as? BeginnerHome

                self.view.window?.rootViewController = beginnerHome

                self.view.window?.makeKeyAndVisible()
            }
        }
        for coach in coachList!{
            if coach.username == usernameTextField.text && coach.password == passwordTextField.text{
                
                loginUser.append(coach)
                let coachHome = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.coachHome) as? CoachHome

                self.view.window?.rootViewController = coachHome

                self.view.window?.makeKeyAndVisible()
                
            }

        }
        for admin in adminList!{
            if admin.username == usernameTextField.text && admin.password == passwordTextField.text{
                loginUser.append(admin)

                let adminMenu = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.adminMenu) as? AdminMenu

                self.view.window?.rootViewController = adminMenu

                self.view.window?.makeKeyAndVisible()
                
            }

        }
        
        if loginUser.isEmpty{
            let alertController = UIAlertController(title: "Invalid data", message: .none,  preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion: nil)
            
            let submitAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK")
            }
            
            usernameTextField.text?.removeAll()
            passwordTextField.text?.removeAll()
            
            alertController.addAction(submitAction)
        }
        
//        for user in usersList!{
//
//
//            if user.username == usernameTextField.text && user.password == passwordTextField.text{
//
//                if isEqual(user.userType == "administrator"){
//
//                    loginUser.append(user)
//
//                    let adminMenu = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.adminMenu) as? AdminMenu
//
//                    self.view.window?.rootViewController = adminMenu
//
//                    self.view.window?.makeKeyAndVisible()
//
//                }
//                else if isEqual(user.userType == "coach"){
//                    loginUser.append(user)
//                    let coachMenu = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.coachMenu) as? CoachMenu
//
//                    self.view.window?.rootViewController = coachMenu
//
//                    self.view.window?.makeKeyAndVisible()
//
//                }
//                else if isEqual(user.userType == "beginner"){
//                    loginUser.append(user)
//                    let beginnerMenu = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.beginnerMenu) as? BeginnerMenu
//
//                    self.view.window?.rootViewController = beginnerMenu
//
//                    self.view.window?.makeKeyAndVisible()
//
//                }
//
//            }
//            else{
//                let alertController = UIAlertController(title: "Invalid data", message: .none,  preferredStyle: .alert)
//
//                self.present(alertController, animated: true, completion: nil)
//
//                let submitAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//                    UIAlertAction in
//                    NSLog("OK")
//                }
//
//                usernameTextField.text?.removeAll()
//                passwordTextField.text?.removeAll()
//
//                alertController.addAction(submitAction)
//            }
//
//        }
//
    }

}
