//
//  CoachRewievAdmin.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 2.3.22..
//

import UIKit
import CoreData

class CoachRewievAdmin: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    var allItems:[User]?
    var coaches = [User]()


    let navItem = UINavigationItem(title: "Coach")
    let doneItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    let backItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "UserTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .darkGray
        tableView.tintColor = .white
        
        fetchUsers()
        findCoach()
        addItemInNavBar()
        
    }
    
    func addItemInNavBar(){
        view.addSubview(navBar)
        
        navBar.backgroundColor = .darkGray
        backItem.tintColor = .white
        doneItem.tintColor = .white
        navItem.titleView?.backgroundColor = .darkGray
        navBar.barTintColor = .darkGray
        
        backItem.title = "< Back"
        backItem.action = #selector(back)
        navigationItem.backBarButtonItem = backItem
        navItem.leftBarButtonItem = backItem
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
    }
    
    func fetchUsers(){
        
        allItems?.removeAll()

        do{
            self.allItems = try context.fetch(User.fetchRequest())
        }
        catch{

        }
        

    }
    
    func findCoach(){
        
        coaches.removeAll()

        for coach in allItems!{
            print(coach)
            if coach.userType == "coach"{
                coaches.append(coach)
            }
        }
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
            }
    }

    func generateNewId() -> Int64{
        
        var max: Int64 = -1
        for user in allItems!{
            if user.id > max{
                max = user.id
            }

        }
        return max + 1
    }
    
    @objc func addTapped(){
                
        let alertController = UIAlertController(title: "Add coach", message: "Enter values", preferredStyle: .alert)

        alertController.addTextField()
        alertController.addTextField()
        alertController.addTextField()
        alertController.addTextField()
        alertController.addTextField()
        
        let usernameTxField = alertController.textFields![0]
        let firstNameTxField = alertController.textFields![1]
        let lastNameTxField = alertController.textFields![2]
        let emailTxField = alertController.textFields![3]
        let passwordTxField = alertController.textFields![4]
        
        firstNameTxField.placeholder = "Enter first name"
        lastNameTxField.placeholder = "Enter last name"
        usernameTxField.placeholder = "Enter username"
        passwordTxField.placeholder = "Enter password"
        emailTxField.placeholder = "Enter email"
        
        self.present(alertController, animated: true, completion: nil)
        
        let submitAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            if self.checkValue(firstName: firstNameTxField.text!, lastName: lastNameTxField.text!, password: passwordTxField.text!, email: emailTxField.text!){
                
                let newCoach = Coach(context: self.context.self)

                newCoach.id = self.generateNewId()
                newCoach.firstName = firstNameTxField.text
                newCoach.lastName = lastNameTxField.text
                newCoach.username = usernameTxField.text
                newCoach.password = passwordTxField.text
                newCoach.email = emailTxField.text
                newCoach.userType = "coach"

                try! self.context.save()
                
                self.fetchUsers()
                self.findCoach()

                NSLog("Submit")
            }

            

        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel")
        }
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        alertController.view.tintColor = UIColor.white
    }
    
    @objc func back(){
        let back = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.adminMenu) as? AdminMenu
        
        self.view.window?.rootViewController = back
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.coaches.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell

        let user = coaches[indexPath.row]
        let textForCell: String = user.firstName! + " " + user.lastName!
        cell.userLabel.text = textForCell

        return cell
        
    }

    func checkValue(firstName : String, lastName : String, password : String, email : String) -> Bool {
        
        var message : String = ""
        
        if  firstName == "" || lastName == "" || password == "" || email == "" {
            message = "Some field is empty!"

        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email) == false{
            message = "Email must be like user@gmail.com!"
        }
        
        if message == ""{
            return true
        }else{
            let alertController = UIAlertController(title: message, message: .none,  preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion: nil)
            
            let submitAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK")
            }

            alertController.addAction(submitAction)
            return false
        }
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        let selectedCoach = self.coaches[indexPath.row]
        let alertController = UIAlertController(title: "Edit coach:", message: "Change data", preferredStyle: .alert)

        alertController.addTextField()
        alertController.addTextField()
        alertController.addTextField()
        alertController.addTextField()
        alertController.addTextField()

        let usernameTxField = alertController.textFields![0]
        let firstNameTxField = alertController.textFields![1]
        let lastNameTxField = alertController.textFields![2]
        let emailTextField = alertController.textFields![3]
        let passwordTxField = alertController.textFields![4]
        
        usernameTxField.isUserInteractionEnabled = false
        
        for coach in coaches {
            if coach.username == selectedCoach.username{
                firstNameTxField.text = coach.firstName
                lastNameTxField.text = coach.lastName
                usernameTxField.text = coach.username
                passwordTxField.text = coach.password
                emailTextField.text = coach.email
            }
        }
        
        self.present(alertController, animated: true, completion: nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            if self.checkValue(firstName: firstNameTxField.text!, lastName: lastNameTxField.text!, password: passwordTxField.text!, email: emailTextField.text!){
            
                selectedCoach.firstName = firstNameTxField.text
                selectedCoach.lastName = lastNameTxField.text
                selectedCoach.password = passwordTxField.text
                selectedCoach.email = emailTextField.text
                
                try! self.context.save()
                
                self.fetchUsers()
                self.findCoach()
                
                
                NSLog("Submit")
                
            }
            
            

        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel")
        }
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        alertController.view.tintColor = UIColor.white
        
            
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            let coachToRemove = self.coaches[indexPath.row]
            
            self.context.delete(coachToRemove)
            
            try! self.context.save()
            
            self.fetchUsers()
            self.findCoach()
            
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
}



