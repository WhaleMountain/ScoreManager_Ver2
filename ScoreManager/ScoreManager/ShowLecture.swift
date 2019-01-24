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
    var absenceRow: Int = 0
    
    func showtext(){
        let a = Int(receiveTime)! // 時限を数字に変換
        ShowLectureName.text = receiveName // 講義名の表示
        ShowLectureTime.text = receiveWeek+receiveTime+"限\n     時間:"+zikan[a-1] // 曜日, 時限を表示
        ShowLectureAbsence.text = String(LectureAbsence[absenceRow])
    }
    
    // 欠席回数をカウントする
    func UpdateAbsence(){
        LectureAbsence[absenceRow] += 1
    }
    
    override func viewDidLoad() {
        showtext()
        super.viewDidLoad()
    }
}
