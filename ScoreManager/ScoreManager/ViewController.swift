//
//  ViewController.swift
//  ScoreManager
//
//  Created by ken miyahira on 2018/11/15.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var NowDate: UILabel!
    @IBOutlet weak var NowWeekDay: UILabel!
    
    func weekday(){ //現在の曜日を求める.
        let weeks = ["日曜日","月曜日","火曜日","水曜日","木曜日","金曜日","土曜日"]
        let comp = Calendar.Component.weekday
        let weeknum = NSCalendar.current.component(comp, from: NSDate() as Date)
        NowWeekDay.text = weeks[weeknum - 1] // 1 -> 日曜日, 7 -> 土曜日 なので, -1している
    }
    
    func setZikoku(format:String = "MM月dd日"){ //現在の日にちを求める.
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        NowDate.text = formatter.string(from: now as Date)
    }
    
    override func viewDidLoad() {
        weekday();
        setZikoku();
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

