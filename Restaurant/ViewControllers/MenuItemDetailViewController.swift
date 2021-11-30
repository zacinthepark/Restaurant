//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by zac on 2021/11/23.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    
    //Since the detail screen will never be presented without a MenuItem object in place, you can define the property as an implicitly unwrapped optional
    var menuItem: MenuItem!

    override func viewDidLoad() {
        super.viewDidLoad()

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
