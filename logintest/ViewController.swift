
import UIKit
import Firebase
import FirebaseDatabase



class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtUserEmail: UITextField!
    @IBOutlet weak var txtUserPassword: UITextField!
    
    
    @IBOutlet weak var lblUserEmail: UILabel!
    
    @IBOutlet weak var viewSignUpForm: UIView!
    @IBOutlet weak var viewUserInfo: UIView!
    
    var handle: AuthStateDidChangeListenerHandle!

    override func viewDidLoad() {
           super.viewDidLoad()
           viewSignUpForm.isHidden = true
           viewUserInfo.isHidden = true
       }

    override func viewWillAppear(_ animated: Bool) {
          handle = Auth.auth().addStateDidChangeListener { auth, user in
              if let user = user {
                  self.viewUserInfo.isHidden = false
                  self.viewSignUpForm.isHidden = true
                  self.lblUserEmail.text = user.email
              } else {
                  self.viewUserInfo.isHidden = true
                  self.viewSignUpForm.isHidden = false
                  self.lblUserEmail.text = ""
              }
          }
      }
    
    
    override func viewWillDisappear(_ animated: Bool) {
           Auth.auth().removeStateDidChangeListener(handle!)
       }
    
    
    @IBAction func btnActSubmit(_ sender: Any) {
        
        guard let userEmail = txtUserEmail.text else { return }
          guard let userPassword = txtUserPassword.text else  { return }
          
          Auth.auth().signIn(withEmail: userEmail, password: userPassword) { [weak self] authResult, error in
              guard self != nil else { return }
              
              if authResult != nil {
                  let alert = UIAlertController(title: "성공", message: "반갑습니다.", preferredStyle: UIAlertController.Style.alert)
                  let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                      }
                       alert.addAction(okAction)
                  self!.present(alert, animated: false, completion: nil)
                  return
                  
                 // print("로그인 되었습니다")
                  
              } else {
                  
                  let alert3 = UIAlertController(title: "실패", message: error!.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                  let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                      }
                       alert3.addAction(okAction)
                  self!.present(alert3, animated: false, completion: nil)
                  return
                  //print("로그인되지 않았습니다.", error?.localizedDescription ?? "")
              }
          }
        
        
    }
    
    
    @IBAction func btnActSignOut(_ sender: Any) {
        do {
                  try Auth.auth().signOut()
              } catch {
                  print(error.localizedDescription)
              }
        
    }
    
    

}
