//
//  SignUpViewController.swift
//  logintest
//
//  Created by 박민규 on 2021/11/13.
//
import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtUserEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPasswordConfirm: UITextField!
    @IBOutlet weak var lblPasswordConfirmed: UILabel!
    @IBOutlet weak var pkvInteresting: UIPickerView!
    @IBOutlet weak var imgProfilePicture: UIImageView!
    
    var ref: DatabaseReference!
    
    let interestingList = ["치킨", "피자", "탕수육"]
    var selectedInteresting: String!
     
    
    override func viewDidLoad() {
           super.viewDidLoad()
        
        // 피커뷰 딜리게이트, 데이터소스 연결
               pkvInteresting.delegate = self
               pkvInteresting.dataSource = self
               
               txtUserEmail.delegate = self
               txtPassword.delegate = self
               txtPasswordConfirm.delegate = self
               
               // firebase reference 초기화
               ref = Database.database().reference()
               
               selectedInteresting = interestingList[0]
               lblPasswordConfirmed.text = ""
       }
    
    
    
    
    
    
    
    
    @IBAction func btnActCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    @IBAction func btnActReset(_ sender: Any) {
        txtUserEmail.text = ""
        txtPassword.text = ""
        txtPasswordConfirm.text = ""
        lblPasswordConfirmed.text = ""
        pkvInteresting.selectedRow(inComponent: 0)
    }
    
    
    
    
    
    
    
    @IBAction func btnActSubmit(_ sender: Any) { //end
        
        guard let userEmail = txtUserEmail.text,
               let userPassword = txtPassword.text,
               let userPasswordConfirm = txtPasswordConfirm.text else {
             return
         }
         
         guard userPassword != ""
                 && userPasswordConfirm != ""
                 && userPassword == userPasswordConfirm else {
            //simpleAlert(self, message: "패스워드가 일치하지 않습니다.")
            let alert = UIAlertController(title: "실패", message: "패스워드가 일치하지 않다!", preferredStyle: UIAlertController.Style.alert)
                     
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    }
                     alert.addAction(okAction)
                     present(alert, animated: false, completion: nil)
             return
         }
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { [self] authResult, error in
            // 이메일, 비밀번호 전송
            guard let user = authResult?.user, error == nil else {
                let alert2 = UIAlertController(title: "실패", message: error!.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    }
                     alert2.addAction(okAction)
                    present(alert2, animated: false, completion: nil)
                return
            }
            
            // 추가 정보 입력
            ref.child("users").child(user.uid).setValue(["interesting": selectedInteresting])
            let alert3 = UIAlertController(title: "성공", message: "\(user.email!) 님의 회원가입 완료!", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                }
                 alert3.addAction(okAction)
                present(alert3, animated: false, completion: nil)
                    
                self.dismiss(animated: true, completion: nil)
            }
        }
    }




    
extension SignUpViewController: UIPickerViewDelegate, UIPickerViewDataSource { //end
        // 컴포넌트(열) 개수
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        // 리스트(행) 개수
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return interestingList.count
        }
        
        // 피커뷰 목록 표시
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return interestingList[row]
        }
        
        // 특정 피커뷰 선택시 selectedInteresting에 할당
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedInteresting = interestingList[row]
        }
    }
    
    
    
    
    
extension SignUpViewController: UITextFieldDelegate {//end
        
        func setLabelPasswordConfirm(_ password: String, _ passwordConfirm: String)  {
            
            guard passwordConfirm != "" else {
                lblPasswordConfirmed.text = ""
                return
            }
            
            if password == passwordConfirm {
                lblPasswordConfirmed.textColor = .green
                lblPasswordConfirmed.text = "패스워드가 일치합니다."
            } else {
                lblPasswordConfirmed.textColor = .red
                lblPasswordConfirmed.text = "패스워드가 일치하지 않습니다."
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            switch textField {
            case txtUserEmail:
                txtPassword.becomeFirstResponder()
            case txtPassword:
                txtPasswordConfirm.becomeFirstResponder()
            default:
                textField.resignFirstResponder()
            }
            
            return false
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
                
            
            if textField == txtPasswordConfirm {
                guard let password = txtPassword.text,
                      let passwordConfirmBefore = txtPasswordConfirm.text else {
                    return true
                }
                
                
//                let str = passwordConfirmBefore
//                let passwordConfirm = string.isEmpty ? str.passwordConfirmBefore[0..<(passwordConfirmBefore.count - 1)] :
//                  //passwordConfirmBefore[0..<(passwordConfirmBefore.count - 1)] :
//                    passwordConfirmBefore + string
//                 setLabelPasswordConfirm(password, passwordConfirm)
//
            }
            return true
        }
    }
    
   
    
    
