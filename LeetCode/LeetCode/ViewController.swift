//
//  ViewController.swift
//  LeetCode
//
//  Created by gavin on 2020/2/4.
//  Copyright © 2020 gavin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let question = QuestionOne();
//        let result:[Int] = question.twoSum([3,2,4], 6);

        
        
        var head = ListNode(1);
        var second = ListNode(2);
        head.next = second;
        
        let result = QuestionThirty().findSubstring("barfoothefoobarman", ["foo","bar"]);
        
        
    }


}

