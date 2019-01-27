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
