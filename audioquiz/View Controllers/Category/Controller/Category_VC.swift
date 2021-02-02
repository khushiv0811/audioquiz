//
//  Category_VC.swift
//  audioquiz
//
//  Created by khushboo patel on 20/08/20.
//  Copyright © 2020 Khushboo. All rights reserved.
//

import UIKit

class Category_VC: UIViewController
{
    var arr_selectedcategory :  [Category_Model] = [Category_Model]()
    var selectedindex : Int?
    //MARK:- IBOutLet
    @IBOutlet weak var btn_language1 : UIButton!
    @IBOutlet weak var btn_language2 : UIButton!
    @IBOutlet weak var btn_language3 : UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupvalues()
    }
    //MARK:- Set up Values
    func setupvalues()
    {
       
        btn_language1.setTitle(arr_selectedcategory[0].name, for: .normal)
        btn_language2.setTitle(arr_selectedcategory[1].name, for: .normal)
        btn_language3.setTitle(arr_selectedcategory[2].name, for: .normal)
        
    }
    //MARK:- IBActions
    @IBAction func onclick_languages(sender : UIButton)
    {
        if sender.tag == 100
        {
            selectedindex = 0
        }
        else if sender.tag == 101
        {
            selectedindex = 1
        }
        else if sender.tag == 102
        {
            selectedindex = 2
        }
        self.performSegue(withIdentifier: "segue_subcategory", sender: self)
        
    }
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
        if segue.identifier == "segue_subcategory"
        {
            let vc = segue.destination as! SubCategory_VC
            vc.currentcategory = arr_selectedcategory[selectedindex!]
        }
    }
    

}
