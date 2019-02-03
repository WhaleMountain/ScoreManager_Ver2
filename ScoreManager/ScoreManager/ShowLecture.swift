//
//  ShowLecture.swift
//  ScoreManager
//
//  Created by ken miyahira on 2019/01/24.
//

import UIKit

class ShowLecture: UIViewController {
    @IBOutlet weak var ShowLectureName: UILabel!
    @IBOutlet weak var ShowLectureTime: UILabel!
    @IBOutlet weak var ShowLectureAbsence: UILabel!
    
    let zikan = [" 08:30～10:00","10:20～11:50","12:50～14:20","14:40～16:10","16:20～17:50"]
    var receiveName: String = ""
    var receiveWeek: String = ""
    var receiveTime: String = ""
    var arrayRow: Int = 0
    
    func showtext(){
        let timerow = Int(receiveTime)! // 時限を数字に変換
        ShowLectureName.text = receiveName // 講義名の表示
        ShowLectureTime.text = receiveWeek+receiveTime+"限\n     時間:"+zikan[timerow-1] // 曜日, 時限を表示
        ShowLectureAbsence.text = String(LectureAbsence[arrayRow])
    }
    
    // 欠席回数をカウントする
    func UpdateAbsence(){
        LectureAbsence[arrayRow] += 1
    }
    
    @IBAction func EditButton(_ sender: Any) {
        self.performSegue(withIdentifier: "EditMemu", sender: nil)
    }
    // showlecture to set lectureName
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditMemu" {
            let timerow = Int(receiveTime)!
            let AL = segue.destination as! AddLecture // ALはAddLectureの略
            AL.setLectureName = receiveName
            AL.tmpWeek = receiveWeek
            AL.weekrow = judgeWeekRow()
            AL.tmpTime = receiveTime
            AL.timerow = timerow-1
            AL.arrayRow = arrayRow
            AL.absenceCnt = LectureAbsence[arrayRow]
            AL.take_over = 1
            
        }
    }
    
    func judgeWeekRow() -> Int{
        switch receiveWeek {
        case "月曜":
            return 0
        case "火曜":
            return 1
        case "水曜":
            return 2
        case "木曜":
            return 3
        case "金曜":
            return 4
        default:
            return 0
        }
    }
    
    
    override func viewDidLoad() {
        showtext()
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
}
