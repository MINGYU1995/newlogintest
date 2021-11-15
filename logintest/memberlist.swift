//
//  memberlist.swift
//  logintest
//
//  Created by 박민규 on 2021/11/13.
//

import UIKit
import Firebase

class memberlist: UIViewController {
    
    
    let db = Database.database().reference()
    
    @IBOutlet weak var interesting: UILabel!
    
    
    override func viewDidLoad() {
          super.viewDidLoad()
          // Do any additional setup after loading the view.
          updateLabel()
      }
    

            
        func updateLabel(){
            db.child("interesting").observeSingleEvent(of: .value) {snapshot in
                print("---> \(snapshot)")
                let value = snapshot.value as? String ?? "" //2번째 줄
                DispatchQueue.main.async {
                self.interesting.text = value
            }
        }
    }
    
}
