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

        
        
        
        var nums = [0,0,1,1,1,1,2,3,3];
        
        let result = QuestionEighty().removeDuplicates(&nums);
        
    
    }


}

