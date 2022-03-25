//
//  BeginnerMenu.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 1.3.22..
//

import UIKit

class BeginnerMenu: UIViewController,  UITableViewDelegate, UITableViewDataSource {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var trainingList:[Training]?
    var beginnerTraining = [Training]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTraining()
        findBeginnerTraining()
        
        let nib = UINib(nibName: "TrainingsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TrainingsTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 140
        tableView.backgroundColor = .darkGray

    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadTraining()
        findBeginnerTraining()
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
        
        beginnerTraining.removeAll()
        
        for trng in trainingList!{
            for user in loginUser{
                if trng.beginnerUsername == user.username{
                    beginnerTraining.append(trng)
                }
            }
        }
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if beginnerTraining.isEmpty{
            return 1
        }
        else{
            return beginnerTraining.count
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        if beginnerTraining.isEmpty{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.textLabel?.text = "You don't have reserved training!"
            cell.backgroundColor = .darkGray
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
            cell.textLabel?.textColor = .white
            
            return cell
        }
        else{

            let cell = tableView.dequeueReusableCell(withIdentifier: "TrainingsTableViewCell", for: indexPath) as! TrainingsTableViewCell
            
            let training = beginnerTraining[indexPath.row]
            print(training)
            cell.coachUsernameLabel.text = training.coachUsername
            cell.beginnerUsernameLabel.text = training.beginnerUsername
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            
            let formatedDate = dateFormatter.string(from: training.dateTime!)
            let formatedTime = timeFormatter.string(from: training.dateTime!)
            
            cell.dateLabel.text = formatedDate
            cell.timeLabel.text = formatedTime
            
            cell.buttonCancle.tag = indexPath.row
        
            cell.buttonCancle.addTarget(self, action: #selector(cancle(sender:)), for: .touchUpInside)
            self.borderCell(cell: cell)
            
            return cell
        }
        
        
        
    }
    
    @objc func cancle(sender: UIButton){
        let buttonTag = sender.tag
        let training = beginnerTraining[buttonTag]
        
        training.beginnerUsername = "/"
        
        try! context.save()
        loadTraining()
        findBeginnerTraining()
        
        let alertController = UIAlertController(title: "Succesful canceled training!", message: .none,  preferredStyle: .alert)
        
        self.present(alertController, animated: true, completion: nil)
        
        let submitAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK")
        }

        alertController.addAction(submitAction)
    }
    
}
