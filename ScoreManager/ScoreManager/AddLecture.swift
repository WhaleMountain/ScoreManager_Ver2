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
        self.performSegue(withIdentifier:"MainMemu", sender: nil) // メインメニュー(講義リストがあるとこ)に画面遷移!!
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
    
    // セルの高さの変更
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if component == 0 {
            return 50
        } else {
            return 50
        }
    }
    
    // 値の表示
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if component == 0 {
            let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100))
            label1.textAlignment = .center
            label1.text = week[row]
            label1.font = UIFont(name: "Times",size:40)
            label1.textColor = .white
            return label1//week[row]
        } else {
            let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100))
            label2.textAlignment = .center
            label2.text = time[row]
            label2.font = UIFont(name: "Times",size:40)
            label2.textColor = .white
            return label2//time[row]
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
        SaveButton.isEnabled = false
        super.viewDidLoad()
        //グラデーションの開始色
        let topColor = UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha:1)
        //グラデーションの中間色
        let borderColor = UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha:1)
        //グラデーションの開始色
        let bottomColor = UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha:1)
        
        //グラデーションの色を配列で管理
        let gradientColors: [CGColor] = [topColor.cgColor,borderColor.cgColor, bottomColor.cgColor]
        
        //グラデーションレイヤーを作成
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        //グラデーションの色をレイヤーに割り当てる
        gradientLayer.colors = gradientColors
        //グラデーションレイヤーをスクリーンサイズにする
        gradientLayer.frame = self.view.bounds
        
        //グラデーションレイヤーをビューの一番下に配置
        self.view.layer.insertSublayer(gradientLayer,at: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
