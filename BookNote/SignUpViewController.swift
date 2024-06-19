//
//  SignUpViewController.swift
//  BookNote
//
//  Created by mac030 on 2024/06/18.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        // 텍스트필드 델리게이트 설정
        id.delegate = self
        password.delegate = self
        name.delegate = self
    }
    
    @objc func signUpTapped() {
        guard let email = id.text, !email.isEmpty,
              let password = password.text, !password.isEmpty,
              let name = name.text, !name.isEmpty else {
            showAlert(message: "모든 필드를 입력해주세요.")
            return
        }
        
        // 이메일 중복 체크
        if UserDefaults.standard.string(forKey: email) != nil {
            showAlert(message: "이미 존재하는 이메일입니다.")
            return
        }
        
        // 사용자 정보 저장
        UserDefaults.standard.set(password, forKey: email)
        UserDefaults.standard.set(name, forKey: "\(email)_name")
        
        showAlert(message: "회원가입 성공!", completion: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // UITextFieldDelegate 메서드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 텍스트필드에서 리턴 키를 누르면 키보드가 내려감
        return true
    }
}
