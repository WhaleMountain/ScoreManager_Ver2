//
//  ViewController.swift
//  ScoreManager
//
//  Created by ken miyahira on 2018/11/15.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var NowDate: UILabel!
    @IBOutlet weak var NowWeekDay: UILabel!
    
    // 講義数のカウント
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LectureName.count
    }
    
    // 講義名の表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let LectureCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "LectureCell", for: indexPath)
        LectureCell.textLabel!.text = LectureName[indexPath.row]
        return LectureCell
    }
    
    // テーブルから削除する
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        let alert: UIAlertController = UIAlertController(title: "削除", message: "削除してよろしいですか？", preferredStyle:UIAlertController.Style.alert)
        //講義を削除する
        let DeleteAction: UIAlertAction = UIAlertAction(title: "削除", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            if editingStyle == .delete {
                LectureName.remove(at: indexPath.row)
                LectureWeek.remove(at: indexPath.row)
                LectureTime.remove(at: indexPath.row)
                LectureAbsence.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        })
        //キャンセル 何もしない
        let CanselAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
        })
        alert.addAction(DeleteAction)
        alert.addAction(CanselAction)
        present(alert, animated: true, completion: nil)
    }
    
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
    
    @objc func delSave(){ // アプリが終了 or バックグラウンドに移る際に実行される.
        // 前回の値の全削除
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
        // 現在の値の保存
        UserDefaults.standard.set( LectureName, forKey: "LName" )
        UserDefaults.standard.set( LectureWeek, forKey: "LWeek" )
        UserDefaults.standard.set( LectureTime, forKey: "LTime" )
        UserDefaults.standard.set( LectureAbsence, forKey: "LAbsence" )
    }
    
    @objc func valueRead(){ // アプリが起動する時に実行される.
        // 保存した内容を取得する
        if UserDefaults.standard.object(forKey: "LName") != nil {
            LectureName = UserDefaults.standard.object(forKey: "LName") as! [String]
            LectureWeek = UserDefaults.standard.object(forKey: "LWeek") as! [String]
            LectureTime = UserDefaults.standard.object(forKey: "LTime") as! [String]
            LectureAbsence = UserDefaults.standard.object(forKey: "LAbsence") as! [Int]
        }
    }
    
    override func viewDidLoad() {
        weekday();
        setZikoku();
        super.viewDidLoad()
        
        // アプリが起動する時, 値を読み出す.
        let start = NotificationCenter.default
        start.addObserver(
            self,
            selector: #selector(valueRead),
            name:UIApplication.didFinishLaunchingNotification,
            object: nil)
        
        // アプリが終了する時, 値を保存する.
        let end = NotificationCenter.default
        end.addObserver(
            self,
            selector: #selector(delSave),
            name:UIApplication.willTerminateNotification,
            object: nil)
        
        // アプリがバックグラウンドになる時, 値を保存する.
        let back = NotificationCenter.default
        back.addObserver(
            self,
            selector: #selector(delSave),
            name:UIApplication.didEnterBackgroundNotification,
            object: nil)
    }


}

