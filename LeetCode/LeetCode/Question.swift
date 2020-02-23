//
//  QuestionOne.swift
//  LeetCode
//
//  Created by gavin on 2020/2/4.
//  Copyright © 2020 gavin. All rights reserved.
//

import UIKit

//extension String{
//    subscript (_ i:Int) -> Character{
//        get { return self[index(startIndex, offsetBy: i)]}
//    }
//}

/*
 给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

 你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。

 示例:

 给定 nums = [2, 7, 11, 15], target = 9

 因为 nums[0] + nums[1] = 2 + 7 = 9
 所以返回 [0, 1]

 */
class QuestionOne {
    func twoSum(_ nums:[Int],_ target:Int) -> [Int] {
        for i in 0..<nums.count {
            let num1:Int = nums[i];
            for j in (i+1)..<nums.count {
                let num2:Int = nums[j];
                if (num2 + num1) == target {
                    return [i,j];
                }
            }
        }
        return [0,0];
    }
    
}


/*
 给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。

 如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。

 您可以假设除了数字 0 之外，这两个数都不会以 0 开头。

 示例：

 输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
 输出：7 -> 0 -> 8
 原因：342 + 465 = 807
 */


class ListNode {
    public var val:Int;
    public var next:ListNode?
    public init(_ val:Int){
        self.val = val;
        self.next = nil;
    }
}

class QuestionTwo {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        return add(l1, l2, 0);
    }
    
    
    func add(_ l1:ListNode?, _ l2:ListNode?, _ carry:Int) -> ListNode? {
        guard l1 != nil,l2 != nil, carry != 0 else {
            return nil;
        }
        
        if l1 == nil,l2 == nil, carry == 0 {
            return nil;
        }
        
        var node1 = l1;
        var node2 = l2;
        
        
        if l1 == nil {
            node1 = ListNode(0);
        }
        if l2 == nil {
            node2 = ListNode(0);
        }
        
        let value = node1!.val + node2!.val + carry;
        let result = ListNode(value%10);
        result.next = add(node1!.next, node2?.next, value/10);
        return result;
    }
}


class QuestionThree {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        
        if s.isEmpty {
            return 0;
        }
        var maxCount = 1;
        var subString:Substring?;
        
        for c in s {
            if subString == nil {
                subString = s.prefix(1);
                continue;
            }
            
            if subString!.contains(c) {
                var index = subString?.firstIndex(of: c);
                index = index!
                subString = subString!.suffix(from: index!);
                subString!.removeFirst();
            }
            subString!.append(c);
            if subString!.count > maxCount {
                maxCount = subString!.count;
            }
            
        }
        return maxCount;
    }
}

/*
 寻找两个有序数组的中位数:
 解题思路：
 假设数组num1的个数为n,num2的个数为m,可以先用while循环的方式将两个有序数组合并成一个有序数组:total，而在合并的过程中求出结果，如代码所示:首先得出(m+n)的奇偶，若为奇数，则结果就为total数组的(m+n)/2的值，若为偶数则为total[(m+n)/2]和total[(m+n)/2-1]之和的一半。
 
 */
class QuestionFour {
    static func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        
        
        let isDouble = (nums1.count + nums2.count)%2 == 0;
        let middle  = (nums1.count + nums2.count)/2;
        
        var total = [Int]();
        var result:Double = 0.0;
        var index1 = 0;
        var index2 = 0;
        while index1 < nums1.count || index2 < nums2.count {
            if index1 == nums1.count {
                total.append(nums2[index2]);
                index2 += 1;
            }else if index2 == nums2.count{
                total.append(nums1[index1]);
                index1 += 1;
            }else if nums1[index1] < nums2[index2] {
                total.append(nums1[index1]);
                index1 += 1;
            }else if nums1[index1] > nums2[index2]{
                total.append(nums2[index2]);
                index2 += 1;
            }else if nums1[index1] == nums2[index2]{
                total.append(nums1[index1]);
                total.append(nums2[index2]);
                index1 += 1;
                index2 += 1;
            }

        }
        if isDouble {
            result = (Double(total[middle-1]) + Double(total[middle]))/2;
        }else{
            result = Double(total[middle]);
        }
        return result;
        
    }
}

/*
 最长回文子串:
 解题思路：首先我们根据题目的意思知道，回文子串都有个中心点，而这个中心点是不是一个真实存在的字符，我们需要根据这个回文长度的奇偶性来判断，如为偶数，即中心点在中间夹缝中，若为奇数则为最中间的字符。所以我们可以假定从字符串第二位开始的每一位都是中心点，然后再根据奇偶忘外扩张寻找最大的回文.
 
 */
class QuestionFive {
     func longestPalindrome(_ s: String) -> String {
        if s.count < 2 {
            return s;
        }
        var result = String(s[s.index(s.startIndex, offsetBy:0)]);
        
        var maxLength = 1;
        
        for indexI in 0..<s.count-1 {
            //当left == right 的时候，回文为奇数，中心点是个字符
            //当right == left + 1 的时候，回文是个偶数，中心点是个缝隙
            let oddString = centerSpread(s, left: indexI, right: indexI);
            let evenString = centerSpread(s, left: indexI, right: indexI+1);
            let maxString = oddString.count > evenString.count ? oddString : evenString;
            if maxString.count > maxLength {
                result = maxString;
                maxLength = maxString.count;
            }
            
        }
        
        return result;
    }
    
    //abcb
    func centerSpread(_ s:String,left:Int,right:Int) -> String {
        
        var i = left;
        var j = right;
        
        while i >= 0 && j < s.count  {
            let string1 = s[s.index(s.startIndex, offsetBy:i)];
            let string2 = s[s.index(s.startIndex, offsetBy:j)];
            
            if string1 == string2 {
                i = i - 1;
                j = j + 1;
            }else{
                break;
            }
        }
        let startIndex = s.index(s.startIndex, offsetBy: i + 1);
        let endIndex = s.index(s.startIndex, offsetBy: j);
        return String(s[startIndex..<endIndex]);
    }
    
    
}

/*
 Z 字形变换
 */

class QuestionSix {
    func convert(_ s: String, _ numRows: Int) -> String {
        if numRows < 2 {
            return s;
        }
        
        var result = [Character]();
        let chars = [Character](s);
        
        for i in 0..<numRows {
            var index = i;
            
            let len = 2 * numRows - 2;
            
            while index < chars.count {
                result.append(chars[index]);
                if i != 0 && i != numRows - 1 {
                    let tempIndex = index + 2 * (numRows - i - 1);
                    if tempIndex < chars.count {
                        result.append(chars[tempIndex]);
                    }
                }
                index += len;
            }
        }
        
        return String(result);
    }
}

/*
 整数反转
 解题思路:首先判断正负，然后把符号以外的数值转化为字符串，然后再将字符串反转，最后再将字符串转化为整数
 */

class QuestionSeven {
    func reverse(_ x: Int) -> Int {
        if x == 0 {
            return 0;
        }
        
        let isNegative = x > 0 ? false : true;
        let temp = isNegative ? -x : x;
        
        let string = String(String(temp).reversed());
        let result = isNegative ? -Int(string)! : Int(string)!;
        if result > Int32.max || result < Int32.min {
            return 0;
        }
        
        return result;
        
    }
}
/*
 字符串转化整数
 解题思路：首先去除掉字符串首部空格字符，然后判断字符串是否第一个字符是否含有-字符，若含有则先去除，若不含有，然后遍历字符串的字符，判断每个字符是否为字母或者空格，如不是，就用字符串拼接，若是，则停止拼接，若为空字符串，则返回0，转化为数字，然后判断正负.
 
 */

class QuestionEight {
    func myAtoi(_ str: String) -> Int {
        
        var result = 0;
        
        var string = str.trimmingCharacters(in: .whitespaces);
        var isNegative = false;
        
        if string.hasPrefix("-") || string.hasPrefix("+") {
            let c = string.remove(at: string.startIndex);
            isNegative = c == "-";
        }
        
        
        
        
        var values = "";
        let charcters = [Character](string);
        let numbers:[Character] = ["0","1","2","3","4","5","6","7","8","9"];
        
        for c in charcters {
            if numbers.contains(c){
                values.append(c);
            }else{
                break;
            }
        }
        if values.isEmpty {
            return 0;
        }
        
        if Int(values) == nil {
            return isNegative ? Int(Int32.min) : Int(Int32.max);
        }
        result = Int(values)!
        result = isNegative ? -result : result;
        if result > Int32.max  {
            return Int(Int32.max);
        }
        if  result < Int32.min {
            return Int(Int32.min);
        }
        return result;
        
        
    }
}

/*
 回文数:
 解法1：先去除特殊情况，然后把数字转化为字符串，然后再把字符串反转，比较就行了
 解法2：先去除特殊情况，可以通过除法来获取整数的回文数，最后来判断是否相等
 */
class QuestionNine {
    func isPalindrome(_ x: Int) -> Bool {
        
        if x == 0 {
            return true;
        }
        
        if x < 0 || x % 10 == 0{
            return false;
        }
        
        
        let origin = String(x);
        let reve = String(origin.reversed());
        
        return origin == reve;

    }
    
    func isPalindromeTwo(_ x: Int) -> Bool {
        if x == 0 {
            return true;
        }
        if x < 0 || x % 10 == 0 {
            return false;
        }
        
        var revert = 0;
        var number = x;
        
        while number > revert {
            revert = revert * 10 + number % 10;
            number = number / 10;
        }
        //若x的长度为偶数，则直接判断,若为奇数，则可以通过revert/10去掉中间的数
        return number == revert || number == revert/10;
        
    }
}

/*
 正则表达式匹配：
 解题思路:通过递归的方式一步步的实现
 */

class QuestionTen {
    func isMatch(_ s: String, _ p: String) -> Bool {
        
        if p.isEmpty  {
            return s.isEmpty;
        }
        
        let stringS = s;
        let stringP = p;
        
       //满足有"."的情况，
        let firstMatch = !stringS.isEmpty && (stringS.first! == stringP.first! || stringP.first! == ".");
        
        //匹配公式有“*”，
        if stringP.count >= 2 && [Character](stringP)[1] == "*" {
            //根据递归的原则，要么匹配零次:跳过匹配公式前两位
            let secondIndexP = stringP.index(stringP.startIndex, offsetBy: 2);
            if isMatch(stringS, String(stringP.suffix(from: secondIndexP))) {
                return true;
            }else{
                //要么匹配一次
                if !firstMatch {
                    return false;
                }
                let indexS = stringS.index(stringS.startIndex, offsetBy: 1);
                return isMatch(String(stringS.suffix(from: indexS)), stringP);
            }
            
        }else{
            if !firstMatch {
                return false;
            }
            let indexS = stringS.index(stringS.startIndex, offsetBy: 1);
            let indexP = stringP.index(stringP.startIndex, offsetBy: 1);
            return isMatch(String(stringS.suffix(from: indexS)), String(stringP.suffix(from: indexP)));
        }
        
        
    }
    
}

/*
  盛最多水的容器:
 解题思路：首先从数组第一个值开始往前，数组最后一个值往后开始遍历，一开始的底部是最大的，这个时候就要寻找最高的两侧，然后首部和尾部各企图往中间前进的时候，就要判断当前下标对应的值，那个低就前进那个。
 */
class QuestionEleven {
    func maxArea(_ height: [Int]) -> Int {
        if height.count <= 1 {
            return 0;
        }

        var left = 0;
        var right = height.count - 1;
        var maxContainer = 0;
        
        while left < right {
            maxContainer = max(maxContainer, (right - left) * (height[left] > height[right] ? height[right] : height[left]));
            if height[left] > height[right] {
                right-=1;
            }else{
                left+=1;
            }
        }
        return maxContainer;
    }
}
/*
 整数转罗马数字：
 解题思路:首先我们根据题目知道罗马数字跟阿拉伯数字不是一一对应的关系，但是我们得考虑这些特殊的关系，所以我们将特殊情况写下来，和罗马数组进行一一对应，然后再循环，以从大到小的顺序来遍历nums

*/

class QuestionTwelve {
    func intToRoman(_ num: Int) -> String {

        let nums = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        let romans = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
        var index = 0;
        var results = "";
        var numCopy = num;
        
        
        while index < nums.count{
            
            while numCopy > nums[index] {
                results.append(romans[index]);
                numCopy -= nums[index];
            }
            index+=1;
            
        }
        
        return results;
    }
}
