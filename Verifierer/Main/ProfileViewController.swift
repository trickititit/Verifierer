//
//  ProfileViewController.swift
//  Verifierer
//
//  Created by Георгий Андреев on 23.10.2020.
//

import UIKit

class ProfileViewController: UIViewController {

    var newView = Profile()
    var tableView: UITableView!
    
    
    // These strings will be the data for the table view cells
    let colums: [String] = ["Пол", "Дата Рождения", "Email", "Телефон", "Пароль"]
    let icons: [String] = ["Gender-1", "Date-1", "Message-1", "Phone-1", "pass"]

       // These are the colors of the square views in our table view cells.
       // In a real project you might use UIImages.
    var profile: [String] = [NetworkService.user!.sex, "", NetworkService.user!.userName, NetworkService.user!.firstName, "*******"]

       // Don't forget to enter this in IB also
       let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // add labelOne to the scroll view
        
        let allViewsInXibArray = Bundle.main.loadNibNamed("Profile", owner: self , options: nil)

        //If you only have one view in the xib and you set it's class to MyView class
        self.newView = allViewsInXibArray?.first as! Profile

        //Set wanted position and size (frame)
        self.newView.frame = self.view.bounds
        
        self.view.addSubview(self.newView)
        
        self.newView.table.delegate = self
        self.newView.table.dataSource = self
        self.newView.table.tableFooterView = UIView()

        
        self.newView.avatar.layer.masksToBounds = false
        self.newView.avatar.layer.cornerRadius = self.newView.avatar.frame.height/2
        self.newView.avatar.clipsToBounds = true
        self.newView.avatar.image = NetworkService.avatar
        self.newView.username.text = NetworkService.user!.firstName
        self.newView.email.text = NetworkService.user!.userName
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        print(history.scannedAt)
        let date = dateFormatter.date(from: NetworkService.user!.bod)
        let formatter3 = DateFormatter()
        formatter3.locale = Locale(identifier: "ru_RU")
        formatter3.dateFormat = "d MMM y"
        self.profile[1] = formatter3.string(from: date!)
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let allViewsInXibArray = Bundle.main.loadNibNamed("ProfileCell", owner: self, options: nil)

        //If you only have one view in the xib and you set it's class to MyView class
        let cell:ProfileCell = allViewsInXibArray?.first as! ProfileCell
        

        cell.label1.text = self.colums[indexPath.row]
        cell.label2.text = self.profile[indexPath.row]
        cell.icon.image = UIImage(named: self.icons[indexPath.row])
        
        return cell
    }
    
    
    
}
