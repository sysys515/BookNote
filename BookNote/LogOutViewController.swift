//
//  LogOutViewController.swift
//  BookNote
//
//  Created by mac030 on 2024/06/18.
//

import UIKit

class LogOutViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 로그아웃 버튼 액션 설정
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    @objc func logoutTapped() {
        // UserDefaults에서 로그인 정보 삭제
        UserDefaults.standard.removeObject(forKey: "loggedInUserEmail")
        UserDefaults.standard.synchronize() // 동기화
        
        // 로그인 화면으로 이동
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true, completion: nil)
        }
    }

}
