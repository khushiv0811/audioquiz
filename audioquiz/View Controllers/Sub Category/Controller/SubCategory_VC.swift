//
//  SubCategory_VC.swift
//  audioquiz
//
//  Created by khushboo patel on 27/08/20.
//  Copyright © 2020 Khushboo. All rights reserved.
//

import UIKit

class SubCategory_VC: UIViewController,UITableViewDelegate, UITableViewDataSource
{
    
    var currentcategory : Category_Model = Category_Model()
    var arr_subcategory : [SubCategory_Model] = [SubCategory_Model]()
    var selectedindex : Int = -1
    //MARK:- IBOutlets
    @IBOutlet weak var table_subcategory : UITableView!
    @IBOutlet weak var lbl_categoryname : UILabel!
    //MARK:- View Controller Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbl_categoryname.text = currentcategory.name
        getsubcategory()
    }
     //MARK:- Get Sub Category details
       func getsubcategory()
       {
        let send = APIList.Subcategory.Subcategory + "cat_id=" + currentcategory.id
           let lot = self.showhud(aview: self.view, animationname: "loading")
           NetworkAPIManager.sharedInstance.getAPI(url:send, param: nil, completion: {(_ result: Any, _ success: Bool) -> Void in
               self.dismisshud(aview: lot)
            if success && (result as AnyObject).count > 0
           {
            
           
               
            var jsonreponse : Dictionary = result as! Dictionary<String, Any>
            
    
              print(jsonreponse)
               if jsonreponse["success"] as! Bool == false
               {
                 
                   self.view.showToast(message: jsonreponse["message"] as! String)
               }
               else
               {
                   let array_cat : NSArray = jsonreponse["data"] as! NSArray
                   for i in 0 ..< array_cat.count
                   {
                       let dicttoconvert : NSDictionary = array_cat[i] as! NSDictionary
                       let subcat_model : SubCategory_Model = SubCategory_Model()
                       subcat_model.id = dicttoconvert["id"] as! String
                       subcat_model.name = dicttoconvert["cate_name"] as! String
                    
                       subcat_model.status = dicttoconvert["status"] as! String
                        subcat_model.categoryid = dicttoconvert["cateid"] as! String
                      //  subcat_model.categoryname = dicttoconvert["cateid_name"] as! String
                    self.arr_subcategory.append(subcat_model)
                       
                   }
                self.table_subcategory.reloadData()
               }
               
               
            }
            
           })
       }
    //MARK:- Table View Datasource
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arr_subcategory.count
    }
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subcategory_tvc", for: indexPath) as! subcategory_tvc
        
        cell.lbl_name.text = arr_subcategory[indexPath.row].name
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedindex = indexPath.row
        self.performSegue(withIdentifier: "playlist_segue", sender: self)
        
    }
   
//MARK:- IBActions
    @IBAction func onclick_back(sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "playlist_segue"
        {
            let vc = segue.destination as! Playlist_VC
            vc.currentcategoryid = currentcategory.id
            vc.currnetsubcategoryid = arr_subcategory[selectedindex].id
        }
    }
    

}


