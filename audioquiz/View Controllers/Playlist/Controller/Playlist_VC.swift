//
//  Playlist_VC.swift
//  audioquiz
//
//  Created by khushboo patel on 02/10/20.
//  Copyright © 2020 Khushboo. All rights reserved.
//

import UIKit
import Lottie

class Playlist_VC: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    var currentcategoryid : String = ""
    var currnetsubcategoryid  : String = ""
    var arr_playlist : [Playlist_Model] = [Playlist_Model]()
    var currentindex : Int = -1
    
    //MARK:- IBOutlets
    @IBOutlet weak var table_playlist : UITableView!
    @IBOutlet weak var lbl_subcategoryname : UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getplaylist()
    }
    //MARK:- Get Sub Category details
    func getplaylist()
    {
     let send = APIList.Playlist.Playlist + "cat_id=" + currentcategoryid + "&subcat_id=" + currnetsubcategoryid
        let lot = self.showhud(aview: self.view, animationname: "loading")
        NetworkAPIManager.sharedInstance.getAPI(url:send, param: nil, completion: {(_ result: Any, _ success: Bool) -> Void in
            self.dismisshud(aview: lot)
         if success && (result as AnyObject).count > 0
        {
            let jsonreponse : Dictionary = result as! Dictionary<String, Any>
         print(jsonreponse)
        
            if jsonreponse["success"] as! Bool == false
            {
              
                self.view.showToast(message: jsonreponse["message"] as! String)
            }
            else
            {
                let array_list : NSArray = jsonreponse["data"] as! NSArray
                for i in 0 ..< array_list.count
                {
                    let dicttoconvert : NSDictionary = array_list[i] as! NSDictionary
                    
                    let model : Playlist_Model = Playlist_Model()
                     model.id = dicttoconvert["id"] as! String
                     model.categoryid = dicttoconvert["categoryid"] as! String
                     model.subcategoryid = dicttoconvert["subcate_id"] as! String
                     model.title = dicttoconvert["quiz_name"] as! String
                     model.audiourl = dicttoconvert["audio"] as! String
                    model.details = dicttoconvert["lyrics"] as! String
                     model.playtime = dicttoconvert["list_time"] as! String
                    self.arr_playlist.append(model)
                    
                }
                self.table_playlist.reloadData()
            }
            
             
        }
        })
    }
            
            
    //MARK:- Table View Datasource
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
       {
        return arr_playlist.count
       }
       
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
       {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Playlist_TVC", for: indexPath) as! Playlist_TVC
        cell.lbl_title.text = arr_playlist[indexPath.row].title
        return cell
        
        }
         
    //MARK:- Table View delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        currentindex = indexPath.row
        self.performSegue(withIdentifier: "audioplayer_segue", sender: self)
        
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
        if segue.identifier == "audioplayer_segue"
        {
            let vc = segue.destination as! AudioPlayer_VC
            vc.playlistitem = arr_playlist[currentindex]
            
        }
        
    }
    

}
