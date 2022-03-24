//
//  CoachAddTraining.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 5.3.22..
//

import UIKit

class CoachAddTraining: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {


    @IBOutlet weak var dateAndTimePicker: UIDatePicker!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var durationTrainings = ["30min", "45min", "1h", "1h 30min"]
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var selectedRow: String?
    
    var trainingList:[Training]?
    var loginCoachTrainings:[Training] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        findAllTraining()
        findAllTrainingCoach()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    func findAllTraining(){
        do{
            self.trainingList = try context.fetch(Training.fetchRequest())
        }
        catch{

        }
    }
    
    func findAllTrainingCoach(){
        
        for trng in trainingList!{
            for user in loginUser{
                if trng.coachUsername == user.username{
                    loginCoachTrainings.append(trng)
                }
            }
        }
    }
    
    
    func generateNewId() -> Int64{
        
        var max: Int64 = -1
        for training in trainingList!{
            if training.id > max{
                max = training.id
            }

        }
        return max + 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return durationTrainings.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return durationTrainings[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = durationTrainings[row]
    }
    
    
    func isValid(endTraining: Date) -> Bool{
        
        var message : String = ""
        
        if dateAndTimePicker.date < Date.now{
            message = "You enter wrong date!"
        }
        if selectedRow == nil{
            message = "Please select training duration!"
        }
        if dateAndTimePicker.date == nil{
            message = "Please select training date and time!"
        }
        for trng in loginCoachTrainings{
            if trng.dateTime == dateAndTimePicker.date && trng.endTraining == endTraining{
                message = "You already have this training!"
            }
        }
        for trng in loginCoachTrainings{
            if dateAndTimePicker.date < trng.dateTime! && (endTraining > trng.dateTime! && endTraining < trng.endTraining!){
                message = "You enter wrong date!"
            }
        }
        for trng in loginCoachTrainings{
            if (dateAndTimePicker.date > trng.dateTime! && dateAndTimePicker.date < trng.endTraining!) && endTraining > trng.endTraining!{
                message = "You enter wrong date!"
            }
        }
        for trng in loginCoachTrainings{
            if dateAndTimePicker.date > trng.dateTime! && endTraining < trng.endTraining! {
                message = "You enter wrong date!"
            }
        }
        
        for trng in loginCoachTrainings{
            if dateAndTimePicker.date < trng.dateTime! && endTraining > trng.endTraining! {
                message = "You enter wrong date!"
            }
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
    
    
    @IBAction func addTapped(_ sender: Any) {
        
        let startTraining = dateAndTimePicker.date
        var endTraining : Date?
        if selectedRow == "30min"{
            endTraining = startTraining.addingTimeInterval(30 * 60)

        }else if selectedRow == "45min"{
            endTraining = startTraining.addingTimeInterval(45 * 60)

        }else if selectedRow == "1h"{
            endTraining = startTraining.addingTimeInterval(60 * 60)

        }else if selectedRow == "1h 30min"{
            endTraining = startTraining.addingTimeInterval(90 * 60)
        }
        
        if isValid(endTraining: endTraining!){
            let newTraining = Training(context: self.context)
            newTraining.id = self.generateNewId()
            for user in loginUser{
                newTraining.coachUsername = user.username
            }
            newTraining.beginnerUsername = "/"
            newTraining.dateTime = startTraining
            newTraining.duration = selectedRow
            newTraining.endTraining = endTraining
            
            do{
                try self.context.save()
            }
            catch{

            }
            
            
            let alertController = UIAlertController(title: "Succesful add training!", message: .none,  preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion: nil)
            
            let submitAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK")
            }

            alertController.addAction(submitAction)
        }

        

        
        
    }
        
}
