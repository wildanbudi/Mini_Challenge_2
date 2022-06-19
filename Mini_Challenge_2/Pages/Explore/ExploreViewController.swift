//
//  ExploreViewController.swift
//  Mini_Challenge_2
//
//  Created by Wildan Budi on 14/06/22.
//

import UIKit

class ExploreViewController: UIViewController {

    @IBOutlet weak var restaurantList: UITableView!
    @IBOutlet weak var username: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var restaurantModel: [Restaurants] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.setTitle("Username", for: .normal)
        username.setTitleColor(.black, for: .normal)
        registerCell()
        getAllItem()
        UILabel.appearance().font = UIFont(name: "SF Pro", size: 12)
        // Do any additional setup after loading the view.
    }
    
    func registerCell() {
        restaurantList.register(UINib(nibName: "RestaurantTableViewCell", bundle: nil), forCellReuseIdentifier: "restaurantCell")
    }
    
    func getAllItem() {
        do {
            restaurantModel = try context.fetch(Restaurants.fetchRequest())
            
            DispatchQueue.main.async {
                self.restaurantList.reloadData()
            }
        }
        catch{
            //error handling
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 125 : 125
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

extension ExploreViewController: UITableViewDelegate {
    
}

extension ExploreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as? RestaurantTableViewCell)!
//        let link = restaurantModel[indexPath.row].imageUrl
//        let url = try! NSData(contentsOf: URL.init(string: link ?? "")!, options: NSData.ReadingOptions())
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.gray.cgColor
//        cell.restaurantImage.image = UIImage(data: url as Data)
        cell.name.text = restaurantModel[indexPath.row].name
        cell.location.text = restaurantModel[indexPath.row].kecamatan
        cell.rating.text = String(restaurantModel[indexPath.row].rating)
        cell.distance.text = ""
        cell.openStatus.text = ""
        
        return cell
    }
    
}
