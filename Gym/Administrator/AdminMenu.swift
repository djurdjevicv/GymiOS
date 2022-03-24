//
//  AdminMenu.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 1.3.22..
//

import UIKit

class AdminMenu: UIViewController {

    @IBOutlet weak var editProfileButton: UIButton!
    
    @IBOutlet weak var coachRewievButton: UIButton!
    
    @IBOutlet weak var beginnerRewievButton: UIButton!
    
    @IBOutlet weak var trainingRewievButton: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var logoffButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logoffTapped(_ sender: Any) {
        
        loginUser.removeAll()
        let home = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.homeApp) as? ViewController
        
        self.view.window?.rootViewController = home
        
        self.view.window?.makeKeyAndVisible()
        
        
    }
    
    @IBAction func coachRewievTapped(_ sender: Any) {
        
        let coachRew = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.CoachRewievAdmin) as? CoachRewievAdmin
        
        self.view.window?.rootViewController = coachRew
        
    }
    
    @IBAction func editProfilTapped(_ sender: Any) {
        
        let editProfil = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.editProfilAdmin) as? EditProfileAdmin
        
        self.view.window?.rootViewController = editProfil
    }
    
    
    @IBAction func beginnerRewievTapped(_ sender: Any) {
        
        let beginnerRewiev = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.beginnerRewievAdmin) as? BeginnerRewievAdmin
        
        self.view.window?.rootViewController = beginnerRewiev
    }
    
    
    @IBAction func trainingRewievTapped(_ sender: Any) {
        let trainingRewiev = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.trainingRewievAdmin) as? TrainingRewievAdmin
        
        self.view.window?.rootViewController = trainingRewiev
    }
    
    
}
