//
//  NextViewController.swift
//  swift_tutorial_map
//
//  Created by 早川マイケル on 2021/01/30.
//

import UIKit

protocol SearchLocationDelegate{
    func searchLocation(idoValue:String,keidoValue:String)
    
}

class NextViewController: UIViewController {

    @IBOutlet weak var idoTextField: UITextField!
    @IBOutlet weak var keidoTextField: UITextField!
    
    var delegate:SearchLocationDelegate?

    // 画面読み込み
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // ボタン押下
    @IBAction func ok(_ sender: Any) {

        // 入力文字列が無ければ遷移しない
        if idoTextField.text == "" || keidoTextField.text == ""{
            return
        }
        
        // 戻る時に緯度と軽度を渡す
        delegate?.searchLocation(idoValue: idoTextField.text!, keidoValue: keidoTextField.text!)
        
        // 戻る
        dismiss(animated: true, completion: nil)
    }
    
}
