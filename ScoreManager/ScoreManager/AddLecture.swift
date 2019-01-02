//
//  AddLecture.swift
//  ScoreManager
//
//  Created by ken miyahira on 2019/01/02.
//

import UIKit

var LectureTime = [String]() // 講義の時限が保存される
var LectureWeek = [String]() // 講義の曜日が保存される
var LectureName = [String]() // 講義名などが保存される
var LectureAbsence = [Int]() // 講義の欠席数が保存される

class AddLecture: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    let week = ["月曜","火曜","水曜","木曜","金曜"]
    let time = ["1","2","3","4","5"]
    var tmpWeek = "月曜" // 曜日を一時的に保存する
    var tmpTime = "1" // 時限を一時的に保存する
    
    @IBOutlet weak var LectureNameField: UITextField!
    @IBAction func textEditingChanged(_ sender: Any) {
        if(LectureNameField.text == ""){
            SaveButton.isEnabled = false // 入力がない場合, Saveボタンを押せなくする
        }else{
            SaveButton.isEnabled = true // 入力がある場合, Saveボタンを押せるようにする
        }
    }
    
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBAction func SaveLecture(_ sender: Any) {
        LectureName.append(LectureNameField.text!) //講義名の保存
        LectureWeek.append(tmpWeek)         //曜日の保存
        LectureTime.append(tmpTime)         //時限の保存
        LectureAbsence.append(0)
        LectureNameField.text = ""
    }
    
    // 表示数 (PickerViewの列数)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    // リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return week.count
        } else {
            return time.count
        }
    }
    // 値の表示
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {
        if component == 0 {
            return week[row]
            
        } else {
            return time[row]
        }
    }
    // pickerが選択された際に呼ばれるデリゲートメソッド.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            tmpWeek = week[row]
        } else {
            tmpTime = time[row]
        }
        
    }
    
    // 表示の処理
    override func viewDidLoad() {
        SaveButton.isEnabled = false
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
