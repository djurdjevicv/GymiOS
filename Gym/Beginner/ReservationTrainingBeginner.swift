//
//  ReservationTrainingBeginner.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 5.3.22..
//

import UIKit

class ReservationTrainingBeginner: UIViewController,  UITableViewDelegate, UITableViewDataSource {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var trainingList:[Training]?
    var unreservedTrainings = [Training]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadTraining()
        findBeginnerTraining()
        
        let nib = UINib(nibName: "ReservedTrngBeginnerTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ReservedTrngBeginnerTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PersonCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 140
        tableView.backgroundColor = .darkGray

    }
    
    func loadTraining(){

        trainingList?.removeAll()
        
        do{
            self.trainingList = try context.fetch(Training.fetchRequest())
        }
        catch{

        }
    }
    
    func findBeginnerTraining(){
        
        unreservedTrainings.removeAll()
        
        for trng in trainingList!{
            if trng.beginnerUsername == "/"{
                unreservedTrainings.append(trng)
            }
        }
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if unreservedTrainings.isEmpty{
            return 1
        }else{
            return unreservedTrainings.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if unreservedTrainings.isEmpty{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
            
            cell.textLabel?.text = "You don't have reserved training!"
            cell.backgroundColor = .darkGray
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
            cell.textLabel?.textColor = .white
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservedTrngBeginnerTableViewCell", for: indexPath) as! ReservedTrngBeginnerTableViewCell

            var training = unreservedTrainings[indexPath.row]
            cell.coachLabel.text = training.coachUsername
            cell.beginnerLabel.text = training.beginnerUsername
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            
            let formatedDate = dateFormatter.string(from: training.dateTime!)
            let formatedTime = timeFormatter.string(from: training.dateTime!)
            
            cell.dateLabel.text = formatedDate
            cell.timeLabel.text = formatedTime
            
            cell.reserveButton.tag = indexPath.row
        
            cell.reserveButton.addTarget(self, action: #selector(reserved(sender:)), for: .touchUpInside)
            
            return cell
        }
        

    }
    
    @objc func reserved(sender: UIButton){
        let buttonTag = sender.tag
        var training = unreservedTrainings[buttonTag]
        for user in loginUser{
            training.beginnerUsername = user.username
        }
        
        try! context.save()
        loadTraining()
        findBeginnerTraining()
        
        let alertController = UIAlertController(title: "Succesful reserved training!", message: .none,  preferredStyle: .alert)
        
        self.present(alertController, animated: true, completion: nil)
        
        let submitAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK")
        }

        alertController.addAction(submitAction)    
    }
        

    

}
