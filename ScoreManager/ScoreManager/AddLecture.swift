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
    
    var setLectureName = ""
    var weekrow = 0
    var timerow = 0
    var arrayRow = 0
    var absenceCnt = 0
    var take_over = 0
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
        if(overlap() == true){
            overlap_alert() // 警告が表示される
        }else if(take_over == 1){ // 引き継ぎ(講義の編集)の際, 値の上書き
            LectureName[arrayRow] = LectureNameField.text! // 講義名の上書き
            LectureWeek[arrayRow] = tmpWeek // 曜日の上書き
            LectureTime[arrayRow] = tmpTime // 時限の上書き
            LectureAbsence[arrayRow] = absenceCnt // 欠席数の引き継ぎ
            LectureNameField.text = ""
            take_over = 0 // 引き継ぎを0に変更
            self.performSegue(withIdentifier:"MainMemu", sender: nil) // メインメニュー(講義リストがあるとこ)に画面遷移!!
        }else{
            LectureName.append(LectureNameField.text!) // 講義名の保存
            LectureWeek.append(tmpWeek) // 曜日の保存
            LectureTime.append(tmpTime) // 時限の保存
            LectureAbsence.append(0)
            LectureNameField.text = ""
            self.performSegue(withIdentifier:"MainMemu", sender: nil) // メインメニュー(講義リストがあるとこ)に画面遷移!!
        }
    }
    
    // 重複を判定する
    func overlap() -> Bool{
        if(take_over == 0){ // 講義追加の時
            for i in 0..<LectureName.count{
                if(LectureWeek[i] == tmpWeek && LectureTime[i] == tmpTime){
                    return true // 重複あり
                }
            }
        }else if(take_over == 1){ // 講義編集の時
            for i in 0..<LectureName.count{
                if(arrayRow == i) {
                    continue
                }else if(LectureWeek[i] == tmpWeek && LectureTime[i] == tmpTime){
                    return true // 重複あり
                }
            }
        }
        return false // 重複なし
    }
    
    func overlap_alert(){
        let alert: UIAlertController = UIAlertController(title: "注意", message: "講義時間が重複しています", preferredStyle:UIAlertController.Style.alert)
        // OK 何もしない
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var pv: UIPickerView!
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
        LectureNameField.text = setLectureName // 講義編集の時, 入力した講義名に上書きする
        if(LectureNameField.text == ""){ // 講義の変更の時以外はデフォルトでSaveボタンを押せなくする
            SaveButton.isEnabled = false
        }
        pv.selectRow(weekrow, inComponent: 0, animated: true) // 講義の編集の時, 選択した曜日を初期値にする
        pv.selectRow(timerow, inComponent: 1, animated: true) // 講義の編集の時, 選択した時限を初期値にする
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
