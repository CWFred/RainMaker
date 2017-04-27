//
//  ViewController.swift
//  CalendarTutorial
//
//  Created by Jeron Thomas on 2016-10-15.
//  Edited by Jean Emmanuel Frednick Piard on 2017-02-17.
//  Copyright © 2016 OS-Tech. All rights reserved.
//

import UIKit
import JTAppleCalendar
import Alamofire
import SwiftyJSON

class CalendarViewController: UIViewController{
    
    
    func activatealert(){
        let alertController = UIAlertController(title: "Opening the valve", message: "The number of minutes the valve will be open.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Send Command", style: .default, handler: {
            alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            textField.keyboardType =  UIKeyboardType.phonePad
            
            _ = self.datePicker.date.description
            
            let hour = Calendar.current.component(.hour, from: self.datePicker.date)
            let minute = Calendar.current.component(.minute, from: self.datePicker.date)
            let year = Calendar.current.component(.year, from: self.datePicker.date)
            let month = Calendar.current.component(.month, from: self.datePicker.date)
            let day = Calendar.current.component(.day, from: self.datePicker.date)
            
            var latlong : [String]
            latlong = locationinString.components(separatedBy: ",")
            
            print(latlong[0])
            print(latlong[1])
            
            let latitude  =  latlong[0]
            let longitude  = latlong[1]
            
            let parameter: Parameters = [
                "devId":deviceID,
                "argument":"duration:"+textField.text!,
                "access_token":accessToken,
                "functionName":"open",
                "year":year,
                "month":month,
                "day":day,
                "hour":hour,
                "minute":minute,
                "latitude":latitude,
                "longitude":longitude,
                ]
            
            let url = "http://ec2-54-174-126-95.compute-1.amazonaws.com:9000/schedule"
            
            Alamofire.request(url, method: .post,parameters: parameter).responseJSON { response in
                switch response.result {
                    
                case .success( _):
                    print("sent")
                    
                    
                    
                    
                    
                    
                case .failure(let error):
                    print(error)
                }
                
                
            }
            
            
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Minutes"
        })
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func schedule(_ sender: Any) {
        
        activatealert()
        
        
    }
    @IBOutlet weak var calendarView: JTAppleCalendarView!

    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    let white = UIColor(colorWithHexValue: 0xECEAED)
    let darkPurple = UIColor(colorWithHexValue: 0x3A284C)
    let dimPurple = UIColor(colorWithHexValue: 0x574865)
    
    
    @IBAction func pickerValueChanged(_ sender: Any) {
        
        if datePicker.date < Date() {
            datePicker.setDate(Date(), animated: true)
            
        }
       calendarView.selectDates([datePicker.date])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.datePickerMode = .countDownTimer
        datePicker.datePickerMode = .dateAndTime
        
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.registerCellViewXib(file: "CellView") // Registering your cell is manditory
        calendarView.cellInset = CGPoint(x: 0, y: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Function to handle the text color of the calendar
    func handleCellTextColor(view: JTAppleDayCellView?, cellState: CellState) {
        guard let myCustomCell = view as? CellView  else {
            return
        }
        
        if cellState.isSelected {
            myCustomCell.dayLabel.textColor = darkPurple
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                myCustomCell.dayLabel.textColor = white
            } else {
                myCustomCell.dayLabel.textColor = dimPurple
            }
        }
    }
    
    // Function to handle the calendar selection
    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState) {
        guard let myCustomCell = view as? CellView  else {
            return
        }
        if cellState.isSelected {
            myCustomCell.selectedView.layer.cornerRadius =  25
            myCustomCell.selectedView.isHidden = false
        } else {
            myCustomCell.selectedView.isHidden = true
        }
    }

}

extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let today = Date.init().description
        let r = today.index(today.startIndex, offsetBy: 0)..<today.index(today.endIndex, offsetBy: -15)
        let startDate = formatter.date(from: today[r])!
        let endDate = formatter.date(from: "2100-02-01")!
        let calendar = Calendar.current                     // Make sure you set this up to your time zone. We'll just use default here
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6,
                                                 calendar: calendar,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid,
                                                 firstDayOfWeek: .sunday)
        return parameters
    }
    

    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let myCustomCell = cell as! CellView
        
        // Setup Cell text
        myCustomCell.dayLabel.text = cellState.text
        
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        
        let dateString = date.description
        let r = dateString.index(dateString.startIndex, offsetBy: 0)..<dateString.index(dateString.endIndex, offsetBy: -15)
        print(dateString[r])
        
        
        
//        let df = DateFormatter()
//        df.dateFormat = "yyyy-MM-dd"
//        let date = df.date(from: dateString[r])
//        if let unwrappedDate = date {
//            datePicker.setDate(unwrappedDate, animated: false)
//        }
        
        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        
        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
    }
}

extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}







