//
//  CoachMenu.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 1.3.22..
//

import UIKit

class CoachMenu: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak public var tableView: UITableView!
        
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var allTrainings:[Training]?
    var loginCoachTrainings = [Training]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        findTrainings()
        findLoginCoachTrainings()
        
        let nib = UINib(nibName: "TrainingsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TrainingsTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 140
        tableView.backgroundColor = .darkGray
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        findTrainings()
        findLoginCoachTrainings()
    }
    
    
        
    func findTrainings(){

        allTrainings?.removeAll()
        
        do{
            self.allTrainings = try context.fetch(Training.fetchRequest())
        }
        catch{

        }
    }
    func findLoginCoachTrainings(){
        
        loginCoachTrainings.removeAll()
        
        for trainings in allTrainings!{
            for user in loginUser{
                if trainings.coachUsername == user.username{
                    loginCoachTrainings.append(trainings)
                }
            }
        }
        
        DispatchQueue.main.async{
            self.tableView?.reloadData()
            }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return loginCoachTrainings.count
    }
//
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if loginCoachTrainings.isEmpty{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.textLabel?.text = "You don't have training!"
            cell.backgroundColor = .darkGray
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
            cell.textLabel?.textColor = .white
            
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrainingsTableViewCell", for: indexPath) as! TrainingsTableViewCell

            var training = loginCoachTrainings[indexPath.row]
            print(training)
            cell.coachUsernameLabel.text = training.coachUsername
            if training.beginnerUsername == "/"{
                cell.beginnerUsernameLabel.text = "Free"
            }else{
                cell.beginnerUsernameLabel.text = training.beginnerUsername
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            
            let formatedDate = dateFormatter.string(from: training.dateTime!)
            let formatedTime = timeFormatter.string(from: training.dateTime!)
            
            cell.dateLabel.text = formatedDate
            cell.timeLabel.text = formatedTime
            cell.durationLabel.text = training.duration
            cell.buttonCancle.tag = indexPath.row
        
            cell.buttonCancle.addTarget(self, action: #selector(cancle(sender:)), for: .touchUpInside)
            
            self.borderCell(cell: cell)
                
           
        
            return cell
        }
        

    }
   
    func borderCell(cell: UITableViewCell){
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 2
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        let myColor = UIColor.white
        cell.layer.borderColor = myColor.cgColor
    }
    
    @objc func cancle(sender: UIButton){
        let buttonTag = sender.tag
        var training = loginCoachTrainings[buttonTag]


        if training.beginnerUsername != "/"{
            let alertController = UIAlertController(title: "Error! This training is reserved!", message: .none,  preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion: nil)
            
            let submitAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK")
            }

            alertController.addAction(submitAction)
        }else{
            context.delete(training)
            try! context.save()
            
            findTrainings()
            findLoginCoachTrainings()
            
            let alertController = UIAlertController(title: "Succesful delete training!", message: .none,  preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion: nil)
            
            let submitAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK")
            }

            alertController.addAction(submitAction)
        }
        

    }
    
    

    @IBAction func addTapped(_ sender: Any) {
        let addTraining = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.coachAddTraining) as? CoachAddTraining
        self.view.window?.rootViewController = addTraining
    }
    @IBAction func searchTapped(_ sender: Any) {

    }
    @IBAction func userTapped(_ sender: Any) {
        let profile = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.profileBeginner) as? ProfileBeginner
        self.view.window?.rootViewController = profile
    }
    
}
