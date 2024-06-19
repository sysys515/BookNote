//
//  LoginViewController.swift
//  BookNote
//
//  Created by mac030 on 2024/06/18.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var id: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        // 텍스트필드 델리게이트 설정
        id.delegate = self
        password.delegate = self
    }
    
    @objc func loginTapped() {
        guard let email = id.text, !email.isEmpty,
              let password = password.text, !password.isEmpty else {
            showAlert(message: "모든 필드를 입력해주세요.")
            return
        }
        
        let savedPassword = UserDefaults.standard.string(forKey: email)
        
        if savedPassword == password {
            // 로그인 성공
            UserDefaults.standard.set(email, forKey: "loggedInUserEmail")
            
            // 탭바 컨트롤러로 이동
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
                tabBarController.modalPresentationStyle = .fullScreen
                self.present(tabBarController, animated: true, completion: nil)
            }
        } else {
            showAlert(message: "로그인 실패: 이메일 또는 비밀번호가 잘못되었습니다.")
        }
    }


    
    @objc func signUpTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let signUpViewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            signUpViewController.modalPresentationStyle = .fullScreen
            self.present(signUpViewController, animated: true, completion: nil)
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // UITextFieldDelegate 메서드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 텍스트필드에서 리턴 키를 누르면 키보드가 내려감
        return true
    }
}
