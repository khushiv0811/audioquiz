//
//  SelectLanguage_VC.swift
//  audioquiz
//
//  Created by khushboo patel on 26/08/20.
//  Copyright © 2020 Khushboo. All rights reserved.
//

import UIKit
import AYPopupPickerView


class SelectLanguage_VC: UIViewController
{
    
    let popupPickerView = AYPopupPickerView()
    var arr_category : [Category_Model] = [Category_Model]()
    var pickertitles : [String] = [String]()
    var arr_selectedcategory :  [Category_Model] = [Category_Model]()
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getcategory()
    }
    //MARK:- Get Category details
    func getcategory()
    {
        let lot = self.showhud(aview: self.view, animationname: "loading")
        NetworkAPIManager.sharedInstance.getAPI(url:APIList.Category.Category, param: nil, completion: {(_ result: Any, _ success: Bool) -> Void in
            self.dismisshud(aview: lot)
        if success
        {
            print(result)
            let jsonreponse : NSDictionary = result as! NSDictionary
            if jsonreponse["success"] as! Bool == false
            {
                print(jsonreponse)
                self.view.showToast(message: jsonreponse["message"] as! String)
            }
            else
            {
                let array_cat : NSArray = jsonreponse["data"] as! NSArray
                for i in 0 ..< array_cat.count
                {
                    let dicttoconvert : NSDictionary = array_cat[i] as! NSDictionary
                    let cat_model : Category_Model = Category_Model()
                    cat_model.id = dicttoconvert["id"] as! String
                    cat_model.name = dicttoconvert["name"] as! String
                    cat_model.status = dicttoconvert["status"] as! String
                    self.pickertitles.append(cat_model.name)
                    self.arr_category.append(cat_model)
                }
            }
            
            
        }
        })
    }
  //MARK:- IBActions
    @IBAction func onclick_language1(sender : UIButton)
    {
        popupPickerView.display(itemTitles: pickertitles, doneHandler:
            {
            let selectedIndex = self.popupPickerView.pickerView.selectedRow(inComponent: 0)
                sender.setTitle(self.pickertitles[selectedIndex], for: .normal)
                self.arr_selectedcategory.append(self.arr_category[selectedIndex])
        })
    }
    @IBAction func onclick_language2(sender : UIButton)
    {
        popupPickerView.display(itemTitles: pickertitles, doneHandler:
                   {
                   let selectedIndex = self.popupPickerView.pickerView.selectedRow(inComponent: 0)
                       sender.setTitle(self.pickertitles[selectedIndex], for: .normal)
                       self.arr_selectedcategory.append(self.arr_category[selectedIndex])
               })
    }
    @IBAction func onclick_language3(sender : UIButton)
    {
        popupPickerView.display(itemTitles: pickertitles, doneHandler:
                   {
                   let selectedIndex = self.popupPickerView.pickerView.selectedRow(inComponent: 0)
                       sender.setTitle(self.pickertitles[selectedIndex], for: .normal)
                       self.arr_selectedcategory.append(self.arr_category[selectedIndex])
               })
    }
    @IBAction func onclick_submit (sender : UIButton)
    {
        if arr_selectedcategory.count < 3
        {
            self.view.makeToast("Please select required languagues to continue")
        }
        else
        {
        self.performSegue(withIdentifier: "segue_category", sender: self)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segue_category"
        {
            let vc = segue.destination as! Category_VC
            vc.arr_selectedcategory = arr_selectedcategory
            
        }
    }
    

}
