//
//  TrainingRewievAdmin.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 2.3.22..
//

import UIKit

class TrainingRewievAdmin: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var trainingList:[Training]?
    let navItem = UINavigationItem(title: "All trainings")
    let backItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTraining()
        addItemInNavBar()
        let nib = UINib(nibName: "TrainingsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TrainingsTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 140
        tableView.backgroundColor = .darkGray

    }
    
    func addItemInNavBar(){
        view.addSubview(navBar)
        navBar.backgroundColor = .darkGray
        navBar.tintColor = .white
        navItem.titleView?.tintColor = .white
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
    
    func loadTraining(){

        trainingList?.removeAll()
        
        do{
            self.trainingList = try context.fetch(Training.fetchRequest())
        }
        catch{

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if trainingList!.isEmpty{
            return 1
        }
        else{
            return trainingList!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if trainingList!.isEmpty{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.textLabel?.text = "In our gym currently no training!!"
            cell.backgroundColor = .darkGray
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
            cell.textLabel?.textColor = .white
            
            return cell
        }
        else{

            let cell = tableView.dequeueReusableCell(withIdentifier: "TrainingsTableViewCell", for: indexPath) as! TrainingsTableViewCell
            
            let training = trainingList![indexPath.row]
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
            
            
            return cell
        }
    }
    
    @objc func cancle(sender: UIButton){
        let buttonTag = sender.tag
        let training = trainingList![buttonTag]
        
        training.beginnerUsername = "/"
        
        try! context.save()
        loadTraining()
        
        let alertController = UIAlertController(title: "Succesful delete training!", message: .none,  preferredStyle: .alert)
        
        self.present(alertController, animated: true, completion: nil)
        
        let submitAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK")
        }

        alertController.addAction(submitAction)
    }

}
