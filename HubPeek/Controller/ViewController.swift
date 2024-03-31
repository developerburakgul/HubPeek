//
//  ViewController.swift
//  HubPeek
//
//  Created by Burak Gül on 30.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var getFollowersButton: UIButton!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var searchImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func pressedGetFollowersButton(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         segue başlamadan önce çalışacak fonksiyon
        if segue.identifier == "goToFVC"{
            // değişken gibi işleme tabi tutmak için yapıldı.
            let destinationVC = segue.destination as! FollowersViewController // artık bu yapıya ait tüm özelliklere erişim mevcut hale geldi.
            destinationVC.userName = userNameTextField.text
            
        }
        
        
        
    }
}

