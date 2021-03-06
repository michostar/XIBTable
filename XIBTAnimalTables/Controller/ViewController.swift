//
//  ViewController.swift
//  XIBTAnimalTables
//
//  Created by Michael Shoukry on 9/28/21.
//

import UIKit

class ViewController: UITableViewController, ChangeCells{
    
    
    
    func cellIsUp(cell: Int) {
        print("UP")
    }
    
    func cellIsDown() {
        print("Down")
        
    }
    
    
    var animals:[AnimalsName] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.s
        getData {
            self.tableView.reloadData()
        }
        tableView.register(UINib(nibName: "XIBNameCell", bundle: nil), forCellReuseIdentifier: "XIBNameCell")
        
        tableView.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        
        tableView.isEditing = true
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if animals[indexPath.row].cellNum == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "XIBNameCell", for: indexPath)as! XIBNameCell
            cell.lbl.text = animals[indexPath.row].name
            cell.delgateChangeCells = self
            return cell
            
        }else{
            let cell = Bundle.main.loadNibNamed("DescriptionCell", owner: self, options: nil)?.first as! DescriptionCell
            cell.descripeLbl.text = animals[indexPath.row].description
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 80
        }
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let move = self.animals[sourceIndexPath.row]
        animals.remove(at: sourceIndexPath.row)
        animals.insert(move, at: destinationIndexPath.row)
    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        if animals[indexPath.row].cellNum == 1{
//            animals[indexPath.row].cellNum = 2
//            tableView.reloadRows(at: [indexPath], with: .fade)
//        }else{
//            animals[indexPath.row].cellNum = 1
//            tableView.reloadRows(at: [indexPath], with: .right)
//        }
//    }
    
    // get data from JSON
    func getData( completed:@escaping () -> ()){
        if let path = Bundle.main.path(forResource: "Data", ofType: "json"){
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                animals = try JSONDecoder().decode([AnimalsName].self, from: data)
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
}



