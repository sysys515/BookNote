//
//  MainTapBarController.swift
//  BookNote
//
//  Created by mac030 on 2024/06/18.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 기본적으로 도서 목록 탭을 선택
        self.selectedIndex = 0
    }
}
