//
//  ViewController.swift
//  swift_tutorial_map
//
//  Created by 早川マイケル on 2021/01/30.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate,UIGestureRecognizerDelegate,SearchLocationDelegate {

    // ボタン
    @IBOutlet weak var settingButton: UIButton!

    // マップ
    @IBOutlet weak var mapView: MKMapView!
    var locManager: CLLocationManager!

    // 住所
    @IBOutlet weak var addressLabel: UILabel!
    
    // 住所
    var addressString = ""

    // 起動時に呼ぶ
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ボタンを白に
        settingButton.backgroundColor = .white
        // ボタンを丸角に
        settingButton.layer.cornerRadius = 20.0
    }

    // マップを長押ししたとき
    @IBAction func longPressTap(_ sender: UILongPressGestureRecognizer) {
        // タップを開始した
        if sender.state == .began {
            
        }
        // タップを終了
        else if sender.state == .ended {
            // タップした位置を取得する
            let tapPoint = sender.location(in: view)
            
            // タップした位置を指定して、MKMapView上の緯度経度を取得する
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            let lat = center.latitude
            let log = center.longitude

            // 緯度経度から住所を出力
            convert(lat: lat,log: log)
            
        }
    }
    
    // 緯度と経度を住所に変換する
    func convert(lat:CLLocationDegrees, log:CLLocationDegrees){
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: log)
        
        // クロージャー
        geocoder.reverseGeocodeLocation(location) { (placeMark, error) in
            if let placeMark = placeMark{
                if let pm = placeMark.first{
                    // 名前を取得
                    self.addressString = pm.name!
                    
                    // 住所を取得
                    if pm.administrativeArea != nil{
                        self.addressString += pm.administrativeArea!
                    }
                    
                    // 住所を取得
                    if pm.locality != nil{
                        self.addressString += pm.locality!
                    }
                }
                
                // テキストラベルに住所を反映
                self.addressLabel.text = self.addressString
            }
        }
    }
    
    // ボタン押下
    @IBAction func goToSearchVC(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
        
    }
    
    // 遷移
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {
            let nextVC = segue.destination as! NextViewController
            nextVC.delegate = self
            
        }
    }

    // 遷移から戻ったとき
    func searchLocation(idoValue: String, keidoValue: String) {
        if idoValue == "" || keidoValue == ""{
            addressLabel.text = "表示できません"
        }
        else{
            let idoString = idoValue
            let keidoString = keidoValue
            
            // 緯度、経度からコーディネート
            let coordinate = CLLocationCoordinate2DMake(Double(idoString)!, Double(keidoString)!)
            
            // 表示する範囲を指定
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:  0.01)
            
            // 領域を指定
            let region = MKCoordinateRegion(center:coordinate, span: span)
            
            // 領域をMapViewに設定
            mapView.setRegion(region, animated: true)

            // 緯度経度から住所を出力
            convert(lat: Double(idoString)!,log: Double(keidoString)!)

        }
    }
}

