//
//  FollowersViewController.swift
//  HubPeek
//
//  Created by Burak Gül on 31.03.2024.
//

import UIKit

class FollowersViewController: UIViewController {
    
    var userName : String?
    var imageCache = [String: UIImage]()
    var followersData : [Follower]?
    let tableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        configuration()
        loadFollowersData()
    }
    private func configuration(){
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .white
        configurationTableView()
    }
    
    func configurationTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
    }
    
    private func loadFollowersData() {
        NetworkManager.shared.fetchFollowers(for: userName ?? "developerburakgul") {  [weak self] result in
            switch result {
            case .success(let followers):
                DispatchQueue.main.async {
                    // UI güncellemeleri
                    self?.followersData = followers
                    self?.tableView.reloadData()
                }
            case .failure(let failure):
                
                print(failure)
            }
            
            
        }
    }
    
    
    
}


extension FollowersViewController :UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        followersData?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var info = cell.defaultContentConfiguration()
        let data = followersData?[indexPath.row]
        info.text = data?.login
        
        info.imageProperties.maximumSize = CGSize(width: 60, height: 60) // Örnek maksimum boyut
        info.imageProperties.cornerRadius = 30 // Gerekirse resim için yuvarlak köşeler
        let imageUrl = data?.avatar_url ?? "https://avatars.githubusercontent.com/u/83167665?v=4"
        if let cachedImage = imageCache[imageUrl] {
            info.image = cachedImage
        } else {
            // Resim önbellekte yoksa, indir
            
            NetworkManager.shared.downloadImage(from: imageUrl) { [weak self] image in
                guard let self = self, let image = image else { return }
                DispatchQueue.main.async {
                    
                    self.imageCache[imageUrl] = image
                    // indexPath'teki hücreyi güncelle
                    if let updateCell = tableView.cellForRow(at: indexPath) {
                        //                        updateCell.contentMode = .scaleAspectFill
                        //                        updateCell.imageView?.clipsToBounds = true
                        var updateContent = updateCell.defaultContentConfiguration()
                        updateContent.text = data?.login
                        
                        updateContent.image = image
                        updateContent.imageProperties.maximumSize = CGSize(width: 60, height: 60)
                        updateContent.imageProperties.cornerRadius = 30 // Gerekirse resim için yuvarlak köşeler
                        updateCell.contentConfiguration = updateContent
                    }
                }
            }
        }
        
        cell.contentConfiguration = info
        return cell
        
    }
    
    
    
}

extension FollowersViewController :  UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = followersData?[indexPath.row]
        let githubProfileViewController = GithubProfileViewController()
        githubProfileViewController.urlString = data?.html_url ?? "https://github.com/developerburakgul"
        navigationController?.pushViewController(githubProfileViewController, animated: true)
        
    }
}

