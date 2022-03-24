//
//  ViewController.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 1.3.22..
//

import UIKit





class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
        
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var usersList:[User]?
    var trainingList:[Training]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUsers()
    
        if usersList!.isEmpty{
            addAdmin()
            addBeginner()
            addCoach()
        }
                    
    }
    
    func fetchUsers(){

        do{
            self.usersList = try context.fetch(User.fetchRequest())
        }
        catch{

        }
    }
    
    func addAdmin(){

        let new = Administrator(context: context.self)
        new.id = 1
        new.firstName = "Vladimir"
        new.lastName = "Djurdjevic"
        new.username = "dovla"
        new.password = "dovla123"
        new.userType = "administrator"
        new.email = "dovla@gmail.com"

        try! context.save()
    }
    
    func addBeginner(){

        let new = Beginner(context: context.self)
        new.id = 2
        new.firstName = "Kristina"
        new.lastName = "Milanovic"
        new.username = "kisa"
        new.password = "kisa123"
        new.userType = "beginner"
        new.email = "kisa@gmail.com"

        try! context.save()
    }
    
    func addCoach(){

        let new = Coach(context: context.self)
        new.id = 3
        new.firstName = "Petar"
        new.lastName = "Petrovic"
        new.username = "petrex"
        new.password = "petrex123"
        new.userType = "coach"
        new.email = "petrex@gmail.com"

        try! context.save()
    }
    
    ////TEST


    @IBAction func loginTapped(_ sender: Any) {
        let login = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.login) as? LoginViewController

        self.view.window?.rootViewController = login

        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func signupTapped(_ sender: Any) {

        let signUp = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.signup) as? SignUpViewController

        self.view.window?.rootViewController = signUp

        self.view.window?.makeKeyAndVisible()

    }
}

