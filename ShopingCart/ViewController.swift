//
//  ViewController.swift
//  ShopingCart
//
//  Created by COREY ATKINSON on 10/31/23.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var textOutlet: UITextField!
    @IBOutlet weak var tableOutlet: UITableView!
    

    var cart = ["apples","bananas"]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableOutlet.delegate = self
        tableOutlet.dataSource = self
        
        
        if let items = defaults.data(forKey: "theCart") {
                        let decoder = JSONDecoder()
                        if let decoded = try? decoder.decode([String].self, from: items) {
                            cart = decoded
                        }
                }
        for a in cart {
            print(a)
        }
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!

        cell.textLabel?.text = cart[indexPath.row]
        
        
        return cell
    }

    @IBAction func addAction(_ sender: UIButton) {
        
        var food = textOutlet.text!
        if cart.contains(food)
        {
            print("already in")
        
            let alert = UIAlertController(title: "Error", message: "Aready in cart", preferredStyle: .alert)

            
            let okAction = UIAlertAction(title: "okay", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
              
              
        }
        else
        {
        cart.append(food)
        tableOutlet.reloadData()
        let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(cart) {
                defaults.set(encoded, forKey: "theCart")
            }
                        }
        
    }
    
    @IBAction func sortAction(_ sender: UIButton) {
        cart = cart.sorted(by: <)
        let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(cart) {
                defaults.set(encoded, forKey: "theCart")
            }
        tableOutlet.reloadData()
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       cart[indexPath.row] = "\(cart[indexPath.row]) done!"
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(cart) {
            defaults.set(encoded, forKey: "theCart")
        }
        tableView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cart.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
            let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(cart) {
                    defaults.set(encoded, forKey: "theCart")
                }
            tableOutlet.reloadData()

        }else if editingStyle == .insert {
            
        }
    }
}

