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

        
        
        
        let one = ListNode(1);
        let two = ListNode(2);
        let three = ListNode(3);
        let four = ListNode(4);
        let five = ListNode(5);
        let six = ListNode(6);
        one.next = two;
        two.next = three;
        three.next = four;
        four.next = five;
//        five.next = six
        let result = QuestionSixtyOne().rotateRight(one, 2);
        
    
    }


}

