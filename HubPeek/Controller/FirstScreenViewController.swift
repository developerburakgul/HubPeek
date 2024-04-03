//
//  ViewController.swift
//  HubPeek
//
//  Created by Burak Gül on 30.03.2024.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    
    var imageView : UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "search"))
        return imageView
    }()
    
    var userNameTextField : UITextField = {
        var textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5.0
        
        // Placeholder metni ve rengini ayarlama
        let placeholderText = "Enter a username"
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        // Sol padding (iç boşluk) ekleme
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    var getFollowersButton : UIButton = {
        
        var button = UIButton(type: .system)
        
        button.setTitle("Get Followers", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.0684492588, green: 0.114994891, blue: 0.1818042696, alpha: 1)
        button.layer.cornerRadius = 10
//        button.configuration?.cornerStyle = .capsule
        button.addTarget(self, action: #selector(pressedGetFollowersButton), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        configuration()
    }
    
    
    private func configuration(){
        configurationImageView()
        configurationUserNameTextField()
        configurationGetFollowersButton()
    }
    
    private func configurationImageView()  {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8)
        ])
        
    }
    
    private func configurationUserNameTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            userNameTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func configurationGetFollowersButton() {
        view.addSubview(getFollowersButton)
        getFollowersButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            getFollowersButton.topAnchor.constraint(equalTo:userNameTextField.bottomAnchor, constant: 40),
            getFollowersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            getFollowersButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc func pressedGetFollowersButton() {
        let followersVC = FollowersViewController()
        followersVC.userName = userNameTextField.text
        navigationController?.pushViewController(followersVC, animated: true)
    }

    
    
}

#Preview(""){
    
    UINavigationController(rootViewController: FirstScreenViewController())
    
    
}

