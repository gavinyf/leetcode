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

/*
 罗马数字转整数
 解题思路：首先建立一个字典来表示罗马字符和数字之间的一一对应的关系，然后再遍历字符串，遍历的过程中同时对特殊情况进行区别对待
 */

class QuestionThirteen {
    func romanToInt(_ s: String) -> Int {
        var result = 0;
        let dict:[Character:Int] = ["I":1,"V":5,"X":10,"L":50,"C":100,"D":500,"M":1000];
        let chars = [Character](s);
        
        var index = 0;
        while index < chars.count {
            if !dict.keys.contains(chars[index]) {
                continue;
            }
            if index == chars.count - 1 {
                result = result + (dict[chars[index]] ?? 0);
                index += 1;
            }else{
                let current = (dict[chars[index]] ?? 0);
                let next = (dict[chars[index+1]] ?? 0);
                //判断当前位置罗马字符的值是不是比下一位大
                if current >= next {
                    result += current;
                    index+=1;
                }else{
                    result = result + next - current;
                    index+=2;
                }
                
            }
        }
        
        return result;
    }
}
/*
 最长公共前缀
 解题思路:首先排除特殊情况，然后再选取第一个字符串为共有的前缀，然后遍历其他字符，在遍历过程中如果发现有字符串的前缀不是那个之前共有的前缀，就将共有的前缀最后一位移除，最后得到结果
 */

class QuestionFourteen {
    func longestCommonPrefix(_ strs: [String]) -> String {
       if strs.count == 0 {
            return "";
        }
        if strs.count == 1 {
            return strs.first!;
        }
        var strsCopy = strs;
        var prefix = strsCopy.first!;
        strsCopy.removeFirst();
        for str in strs {
            while !str.hasPrefix(prefix) {
                prefix.removeLast();
                if prefix.isEmpty {
                    return "";
                }
            }
        }
        return prefix;

    }
}

/*
 三数之和:
 解题思路：为了能够更好的不重复的s获取数组中的三数之和，我们可以先排序：然后从数组中第二个数字C开始遍历，设置左右所谓的指针left,right，left一开始是第一个数，right一开始是最后一个数，然后开始判断大小，如果和为零就把这三个数放到数组中，然后left和right各向中间靠近，若大于0，说明right的数值大了，就向中间偏移一位，反之小于0，left就往右偏移一位，
 */
class QuestionFifteen {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        
        if nums.count < 3 {
            return [[Int]]();
        }
        let sortedNums = nums.sorted(by: <);
        if sortedNums.first! > 0 || sortedNums.last! < 0{
            return [[Int]]();
        }
        var result:Set<[Int]> = Set<[Int]>();
        
        
        for i in 1..<sortedNums.count - 1 {
            var left = 0;
            var right = sortedNums.count - 1;
            while left < right && left < i && right > i {
                let leftValue = sortedNums[left];
                let currentValue = sortedNums[i];
                let rightValue = sortedNums[right];
                
                if leftValue + currentValue + rightValue == 0 {
                    result.insert([leftValue,currentValue,rightValue]);
                    left += 1;
                    right -= 1;
                }else if leftValue + currentValue + rightValue > 0{
                    right -= 1;
                    
                }else if leftValue + currentValue + rightValue < 0{
                    left += 1;
                }
            }
        }
        
        return Array(result);

    }
}

/*
 最接近的三数之和
 解题思路：与上题方式一样操作，只是当求出结果sum时判断条件，若比target小，则取target-sum的最大值。，若比target大，则取target-sum的最小值
 */

class QuestionSixteen{
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        if nums.count < 3 {
            return 0;
        }
        
        let sortedNums = nums.sorted();
        
        //先设置个默认值
        var result = sortedNums[0] + sortedNums[1] + sortedNums[2] - target;
        
        for i in 1..<sortedNums.count - 1 {
            var left = 0;
            var right = sortedNums.count - 1;
            
            while left < right && left < i && right > i {
                let leftValue = sortedNums[left];
                let currentValue = sortedNums[i];
                let rightValue = sortedNums[right];
                
                let sum = leftValue + currentValue + rightValue;
                if sum > target {
                    right-=1;
                }else if sum < target{
                    left+=1;
                }else{
                    return target;
                }
                if abs(sum-target) < abs(result) {
                    result = sum - target;
                }
               
            }
        }
        return result + target;

    }
    
}

/*
 电话号码的字母组合:
 解题思路:首先限制输入内容，针对这个问题我们可以才有递归的方式，先制作一个对应的数组，下标和要表达的数字一一对应，然后再取出digits每一个字符i并转化为数字作为下标来寻找对应的字符串，，然后对这个字符串遍历进行更深一层次的操作。
 */

class QuestionSeventeen {
    func letterCombinations(_ digits: String) -> [String] {
        if digits.isEmpty {
            return [];
        }
        
        let dict = ["","","abc","def","ghi","jkl","mno","pqrs","tuv","wxyz"];
        
        var combinations = [String]();
        var combination = ""
        backtrace(&combinations, combination: &combination, digits: digits, dict: dict, index: 0);
        
        return combinations;

    }
    
    func backtrace(_ combinations: inout [String],combination: inout String, digits:String,dict:[String],index:Int) {
        //当递归到最后一位的时候将结果放在数组中
        if combination.count == digits.count {
            combinations.append(combination);
            return;
        }
        
        guard index < digits.count && index >= 0 else {
            return;
        }
        
        let currentChart = digits[digits.index(digits.startIndex, offsetBy: index)];
        
        guard let currentDigit = Int(String(currentChart)), currentDigit >= 0, currentDigit < dict.count else {
            return;
        }
        
        //取出digit指定位置的字符串并进行深层次的遍历
        let currentString = dict[currentDigit];
        for c in currentString {
            combination.append(String(c));
            backtrace(&combinations, combination: &combination, digits: digits, dict: dict, index: index+1);
            combination.removeLast();
        }
                
    }
    
}


/*
 四数之和:
 解题思路:可以参考三数之和，只是多了一层循环。
 */
class QuestionEighteen {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        if nums.count < 4 {
            return [];
        }
        
        var result = Set<[Int]>();
        
        var numsSorts = nums.sorted(by: <);
        for j in 0..<numsSorts.count {
            //先移除遍历的值，将之变成为求三数之和
            let num = numsSorts.remove(at: j);
            let newTarget = target - num;
            for i in 1..<numsSorts.count {
                var left = 0;
                var right = numsSorts.count - 1;
                while left < right && left < i && right > i {
                    let currentValue = numsSorts[i];
                    let leftValue = numsSorts[left];
                    let rightValue = numsSorts[right];
                    let sum = leftValue + rightValue + currentValue;
                    
                    if sum == newTarget {
                        result.insert([num,leftValue,currentValue,rightValue].sorted());
                        right -= 1;
                        left += 1;
                    }else if sum > newTarget{
                        right -= 1;
                    }else{
                        left += 1;
                    }
                }
            }
            //结束之后再在相应的位置插入删除的值。
            numsSorts.insert(num, at: j);
        }
        return Array(result);

    }
}


/*
 删除链表的倒数第N个节点:
 解题思路:可以用双指针的做法，只是两个指针之间相距n,
 */
class QuestionNineteen {
        
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        
        let temp = ListNode(0);
        temp.next = head;
        var first:ListNode? = temp;
        var second:ListNode? = temp;
        var distance = n;
        
        while distance > -1 {
            first = first?.next;
            distance -= 1;
        }
        
        while first != nil {
            first = first?.next;
            second = second?.next;
        }
        second?.next = second?.next?.next;
        
        return temp.next;

    }
}

/*
 有效的括号:
 解题思路：总共有三种类型的括号{},[]，(),根据题目意思可知，若要有效，可以逐渐移除这三个字符串中的一个，最后移除结束后查看字符串是否为空，
 */
class QuestionTwenty {
    func isValid(_ s: String) -> Bool {
        
       var stack = [Character]()
        
        for char in s {
            if char == "(" || char == "[" || char == "{" {
                stack.append(char)
            } else if char == ")" {
                guard stack.count != 0 && stack.removeLast() == "(" else {
                    return false
                }
            } else if char == "]" {
                guard stack.count != 0 && stack.removeLast() == "[" else {
                    return false
                }
            } else if char == "}" {
                guard stack.count != 0 && stack.removeLast() == "{" else {
                    return false
                }
            }
        }
        
        return stack.isEmpty
    }
}

/*
 合并两个有序链表:
 解题思路:使用归并排序的方法
 */
class QuestionTwentyOne {
    
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {

        
        let head = ListNode(0);
        var current:ListNode? = head;
        var point1 = l1;
        var point2 = l2;
                
        while point1 != nil && point2 != nil {
            if point1!.val < point2!.val {
                current?.next = point1;
                current = current?.next;
                point1 = point1?.next;
            }else{
                current?.next = point2;
                current = current?.next;
                point2 = point2?.next;
            }
        }
        
        if point1 == nil {
            current?.next = point2;
        }else{
            current?.next = point1;
        }
        
        return head.next;
    }
}

/*
 括号生成
 解题思路：首先这题可以用递归的方式来解决，n对的()进行组合，而这种组合是有一定条件的，就是(）成对，
 */

class QuestionTwentyTwo {
    func generateParenthesis(_ n: Int) -> [String] {
        
        var result = [String]();
        var currentString = "";
        combine(n, right: n, currentString: currentString, combinations: &result);
        return result;
    }
    
    /*
     left：(括号剩余需要的个数，
     right:）括号剩余的个数，
     n:总个数
     currentString:当前已排列的字符串
     combinations:结果
     */
    func combine(_ left:Int,right:Int,currentString: String,combinations: inout [String]) {
        
        //当左右括号都没有剩余的时候，组合就完成了，直接放入数组
        if left == 0 && right == 0 {
            combinations.append(currentString);
        }
        //当剩余的左括号大于右括号的时候就不需要再组合下去了。也就是说只有先用了左括号才可以用右括号
        if left > right {
            return;
        }
        
        if left > 0 {
            
            combine(left - 1, right: right, currentString: currentString+"(", combinations: &combinations);
        }
        
        if right > 0 {
            combine(left, right: right - 1, currentString: currentString+")", combinations: &combinations);
        }
    }
    
    func generateParenthesisTwo(_ n:Int) -> [String] {
        var dp = [[String]]();
        let dp0 = [""];
        dp.append(dp0);
        for i in 0..<n {
            var current = [String]();
            
            for j in 0..<i {
                let dpj = dp[j];
                let dpi = dp[n - j - 1];
                for string in dpj {
                    for string2 in dpi {
                        current.append("(" + string + ")" + string2);
                    }
                }
            }
            dp.append(current);
        }
        return dp[n];
    }
}

/*
 合并K个排序链表
 解题思路:将链表中的值一一取出放到数组中，然后对数组排序，最后将排序好的数组一一链接起来。
 */

class QuestionTwentyThree {
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        
        let head = ListNode(0);
        var point:ListNode? = head;
        var array = [Int]();
        
        for node in lists {
            var nodeCopy = node
            
            while nodeCopy != nil {
                array.append(nodeCopy!.val);
                nodeCopy = nodeCopy?.next;
            }
        }
        
        array = array.sorted(by: <);
        for value in array {
            point?.next = ListNode(value);
            point = point?.next;
            
        }
        return head.next;
    }
    
}

/*
 两两交换链表中的节点:
 解题思路：可以使用双指针的做法，每次平移2位。
 
 */

class QuestionTwentyFour {
    func swapPairs(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return nil;
        }
        
        if head?.next == nil {
            return head;
        }
        
        let pre = ListNode(0);
        pre.next = head;
        var first:ListNode? = pre;
        var second = head;
        
        while first?.next != nil && second?.next != nil {
            let temp2 = second?.next?.next;
            
            first?.next = second?.next;
            second?.next = temp2;
            first?.next?.next = second;
            first = second;
            second = second?.next;
                        
        }
        return pre.next;

    }
}

/*
 K 个一组翻转链表
 解题思路：
 假设单链表现在是这样的A->B->C->D->E;
 当k = 4的时候，我们需要把上面的链表反转成D->C>B->A->E;
 我们可以j进行三次指向操作
 第一次操作的结果，B->A->C->D;
 第二次结果:C->B->A->D;
 第三次结果就是：D->C->B->A;
 */

class QuestionTwentyFive {
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        
        let dump = ListNode(0);
        dump.next = head;
        var first = head;
        
        
        var length = 0;
        while first != nil {
            first = first?.next;
            length += 1;
        }
        dump.next = head;
        var pre:ListNode? = dump;
        var current = head;
        var next = head?.next;
        
        
        
        
        for _ in 0..<length/k {
            for _ in 0..<k-1 {
                next = current?.next;
                current?.next = next?.next;
                next?.next = pre?.next;
                pre?.next = next;
            }
            pre = current;
            current = pre?.next
            
        }
        return dump.next;
    }
}


/*
 删除排序数组中的重复项
 */
class QuestionTwentySix {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        
        let set = Set(nums);
        nums = Array(set).sorted();
        return set.count;
    }
}


/*
  移除元素
 */
class QuestionTwentyseven {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        
       nums = nums.filter { (num) -> Bool in
            return num != val;
        };
        return nums.count;

    }
}

/*
 实现 strStr()
 */
class QuestionTwentyeight {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        
        let hChars = [Character](haystack);
        let nChars = [Character](needle);
        let hLength = hChars.count;
        let nLength = nChars.count;
        guard hLength > nLength else {
            return -1;
        }
        
        guard hLength != 0 else {
            return 0;
        }
        
        guard nLength != 0 else {
            return 0;
        }
        
        for i in 0...hLength - nLength {
            if hChars[i] == nChars[0] {
                for j in 0..<nLength {
                    if hChars[i + j] != nChars[j] {
                        break;
                    }
                    if j == nLength - 1 {
                        return i;
                    }
                }
                
                
            }
        }
        return -1;

    }
    
}

/*
 两数相除
 */
class QuestionTwentynine {
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        
        if divisor == 0 {
            return 0;
        }
        
        if divisor == 1 {
            return dividend;
        }
        
        
        var isNavigate = false;
        if divisor < 0 && dividend > 0 {
            isNavigate = true;
        }
        
        if divisor > 0 && dividend < 0 {
            isNavigate = true;
        }
        
        let dividends = abs(dividend);
        let divisors = abs(divisor);
        
        let result = div(dividends, b: divisors);
        
        if result >= UInt32.max {
            return Int(UInt32.max) - 1;
        }
        
        return isNavigate ? -result : result;
        
    }
    
    func div(_ a:Int,b:Int) -> Int {
        if a < b {
            return 0;
        }
        var tb = b;
        var result = 1;
        while (tb + tb) <= a {
            result += result;
            tb += tb;
        }
        
        return result + div(a - tb, b: b);
    }
}


class QuestionThirty {
    func findSubstring(_ s: String, _ words: [String]) -> [Int] {
        var result = [Int]();
        if words.count == 0 {
            return result;
        }
        let wordLength = words.first!.count;

        if s.count < words.count*wordLength {
            return result;
        }
        
        
        var dict = [String:Int]();
        for string in words {
            let value = dict[string];
            dict[string] = (value ?? 0) + 1;
        }
        
        for index in 0..<s.count - words.count*wordLength + 1 {
            var dict1 = [String:Int]();
            var num = 0;
            while num < words.count {
                let startIndex = s.index(s.startIndex, offsetBy: num*wordLength+index);
                let endIndex = s.index(s.startIndex, offsetBy: (num+1)*wordLength+index);
                let string = String(s[startIndex..<endIndex]);
                if dict.keys.contains(string) {
                    let value = dict1[string] ?? 0;
                    dict1[string] = value + 1;
                    
                    let value1 = dict[string] ?? 0;
                    if (value+1) > value1 {
                        break;
                    }
                }else{
                    break;
                }
                num += 1;
            }
            if num == words.count {
                result.append(index);
            }
            
        }
        return result;

    }
}

class QuestionThirtyOne {
    func nextPermutation(_ nums: inout [Int]) {
        
        if nums.count == 0 || nums.count == 1 {
            return;
        }
        
        if nums.count == 2 {
            nums = nums.reversed();
            return;
        }
       
        
        var current = nums.count - 1;
        var right = nums.count - 1;
        var left = nums.count - 2;
        
        //寻找left值小于current值
        while left >= 0 && nums[left] >= nums[current] {
            left -= 1;
            current -= 1;
        }
        
        if left >= 0 {//当不是最后一个排列
            //寻找right值大于left
            while nums[left] >= nums[right] {
                right -= 1;
            }
            swop(right, index2: left, nums: &nums);
        }
        rank(current, nums: &nums);

    }
    func swop(_ index1:Int,index2:Int,nums:inout [Int]){
        let temp = nums[index2];
        nums[index2] = nums[index1];
        nums[index1] = temp;
    }
    
    func rank(_ index:Int,nums:inout [Int]) {
        let last = nums.count - 1;
        
        let rank = Array(nums[index...last]).sorted();
        nums[index...last] = ArraySlice(rank);
    }
}

/*
 最长有效括号
 */
class QuestionThirtytwo {
    func longestValidParentheses(_ s: String) -> Int {
        if s.isEmpty {
            return 0;
        }
        let charts = [Character](s);
        var dp = Array.init(repeating: 0, count: charts.count);
        var maxValue = 0;
        
        for i in 1..<charts.count {
            if charts[i] == ")"{
                if charts[i-1] == "(" {
                    dp[i] = (i >= 2 ? dp[i - 2] : 0) + 2;
                }else if i - dp[i-1] > 0 && charts[i - dp[i-1] - 1] == "("{
                    dp[i] = dp[i - 1] + (i - dp[i-1] - 2 > 0 ? dp[i - dp[i-1]-2] : 0) + 2;
                 }
            }
            maxValue = max(maxValue, dp[i]);
        }
        return maxValue;
    }
}


/*
 搜索旋转排序数组
 二分法
 */
class QuestionThirtythree {
    func search(_ nums: [Int], _ target: Int) -> Int {
        
        var left = 0;
        var right = nums.count - 1;
        var mid = 0;
        
        while (left < right){
            mid = (left + right) / 2;

            if (nums[left] <= nums[mid] && target <= nums[mid] && nums[left] <= target){
                right = mid;// 右边界左移  第一种情况
            }else if (nums[left] > nums[mid] && (target >= nums[left] || target <= nums[mid])){
                right = mid;// 右边界左移  第二种情况
            }else{
                left = mid + 1;// 其余情况左边界右移
            }
        }
        return (left == right && nums[left]==target) ? left : -1;
        

    }
}

/*
 在排序数组中查找元素的第一个和最后一个位置
 解题思路:
 分别找出target的左右边界
 */

class QuestionThirtyfour {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        var result = [-1,-1];
        if result.isEmpty {
            return result;
        }
        
        let left = findLeftBinary(nums, target: target);
        if left == -1 {
            return result;
        }
        let right = findRightBinary(nums, target: target);
        
        result = [left,right];
    
        return result;

    }
    func findLeftBinary(_ nums:[Int],target:Int) -> Int {
        var left = 0;
        var right = nums.count;
        while left < right {
            let mid = (left+right)/2;
            if nums[mid] == target {
                right = mid;
            }else if nums[mid] > target{
                right = mid;
            }else if nums[mid] < target{
                left = mid+1;
            }
            
        }
        if left == nums.count {
            return -1;
        }
        return nums[left] == target ? left : -1;
    }
    
    func findRightBinary(_ nums:[Int], target:Int) -> Int {
        
        var left = 0;
        var right = nums.count;
        while left < right {
            let mid = (left+right)/2;
            if nums[mid] == target {
                left = mid + 1;
            }else if nums[mid] < target{
                left = mid + 1;
            }else if nums[mid] > target{
                right = mid;
            }
            
        }
        if left == 0 {
            return -1;
        }
        return nums[left-1] == target ? left-1 : -1;
    }
}
/*
 搜索插入位置
 */
class QuestionThirtyfive {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var index = 0;
        
        while index < nums.count {
            let num = nums[index];
            if target < num {
                return index;
            }else if target == num{
                return index;
            }else{
                index += 1;
            }
            
        }
        return index;
    }
}

/*
 有效的数独
 */

class QuestionThirtysix {
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        return rowsValid(board) && colsValid(board) && subBoardValid(board);
    }
    
    private func rowsValid(_ board:[[Character]]) -> Bool {
        var existDigits = Set<Character>();
        for i in 0..<board.count {
            existDigits.removeAll();
            for j in 0..<board[0].count {
                if !isDigitValid(board[i][j], &existDigits) {
                    return false;
                }
            }
        }
        return true;
    }
    
    private func colsValid(_ board:[[Character]]) ->Bool{
        var existDigits = Set<Character>();
        for i in 0..<board[0].count {
            for j in 0..<board.count {
                if !isDigitValid(board[j][i], &existDigits) {
                    return false;
                }
            }
        }
        return true;
    }
    
    private func subBoardValid(_ board:[[Character]]) ->Bool{
        var existingDigits = Set<Character>()
        
        for i in stride(from: 0, to: board.count, by: 3) {
            for j in stride(from: 0, to: board[0].count, by: 3) {
                existingDigits.removeAll()
                
                for m in i..<i + 3 {
                    for n in j..<j + 3 {
                        if !isDigitValid(board[m][n], &existingDigits) {
                            return false
                        }
                    }
                }
            }
        }
        return true
    }
    
    private func isDigitValid(_ digit: Character, _ set: inout Set<Character>) -> Bool {
        if digit == "." {
            return true
        }
        
        if set.contains(digit) {
            return false
        } else {
            set.insert(digit)
            return true
        }
    }
}

/*
 外观数列
 */
class QuestionThirtyEight {
    func countAndSay(_ n: Int) -> String {
        if n == 0 {
            return "";
        }
        if n == 1 {
           return "1";
        }
        
        var s:[Character] = ["1","1"];
        
        var i = 2;
        var temp = "";
        while i < n {
            var nums = 1;
            temp = "";
            for i in 1..<s.count {
                if s[i] == s[i-1] {
                    nums += 1;
                }else{
                    temp = temp + String(nums) + String(s[i-1]);
                    nums = 1;
                }
            }
            temp = temp + String(nums) + String(s[s.count-1]);
            s = [Character](temp);
            nums = 1;
            i += 1;
        }
        
        return String(s);
    }
}

/*
 组合总和
 
 */
class QuestionThirtyNine {
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var combination = [Int](), combinations = [[Int]]()
        
        dfs(candidates.sorted(), target, 0, &combinations, &combination)
        
        return combinations;
    }
    
   private func dfs(_ candidates: [Int], _ target: Int, _ index: Int, _ combinations: inout [[Int]], _ combination: inout [Int]) {
        if target == 0 {
            combinations.append(combination)
            return
        }
        
        for i in index..<candidates.count {
            guard candidates[i] <= target else {
                break
            }
            
            combination.append(candidates[i])
            dfs(candidates, target - candidates[i], i, &combinations, &combination)
            combination.removeLast()
        }
    }
}

/*
组合总和二

*/
class QuestionFourty {
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var combination = [Int](), combinations = [[Int]]()
        let sored = candidates.sorted();
        
        dfs(sored, target, 0, &combinations, &combination)
        return combinations;
    }
    
    private func dfs(_ candidates: [Int], _ target: Int, _ index: Int, _ combinations: inout [[Int]], _ combination: inout [Int]) {
        if target == 0 {
            combinations.append(combination)
            return
        }
        
        for i in index..<candidates.count {
            guard candidates[i] <= target else {
                break
            }
            
            if i > index && candidates[i] == candidates[i - 1] {
                continue;
            }
            combination.append(candidates[i])
            dfs(candidates, target - candidates[i], i+1, &combinations, &combination)
            combination.removeLast()
        }
    }
    
}

/*
 缺失的第一个正数
 */
class QuestionFourtyOne {
    func firstMissingPositive(_ nums: [Int]) -> Int {
        let set = Set(nums);
        for i in 0..<nums.count {
            if !set.contains(i+1) {
                return i + 1;
            }
        }
        return nums.count + 1;
    }
    
}

/*
 接雨水
 */

class QuestionFourtyTwo {
    func trap(_ height: [Int]) -> Int {
        
        var res = 0;
        var leftMax = 0;
        var rightMax = 0;
        var left = 0;
        var right = height.count - 1;
        
        while left <= right {
            if leftMax <= rightMax {
                leftMax = max(leftMax, height[left]);
                left += 1;
                res += leftMax - height[left];
            }else{
                rightMax = max(rightMax, height[right]);
                right -= 1;
                res += rightMax - height[right];
            }
        }
        return res;
    }
}

/*
 字符串相乘
 */
class QuestionFourtyThree {
    func multiply(_ num1: String, _ num2: String) -> String {
        
        if num1 == "0" || num2 == "0" {
            return "0";
        }
        
        var res = Array(repeating: 0, count: num2.count + num1.count);
        let array1:[Character] = [Character](num1).reversed();
        let array2:[Character] = [Character](num2).reversed();
        
        for i in 0..<array1.count {
            let a = Int(String(array1[i]))!;
            if a == 0 {
                continue;
            }
            for j in 0..<array2.count {
                let b = Int(String(array2[j]))!;
                
                let sum = res[i + j] + a*b;
                res[i+j] = sum%10;
                res[i+j+1] += sum/10;
                
            }
        
        }
        res = res.reversed();
        if res.first! == 0 {
            res.removeFirst();
        }
        let result = res.map(String.init).joined(separator: "")
        
        return result;
    }
}


/*
 通配符匹配
 */
class QuestionFourtyFour {
    func isMatch(_ s: String, _ p: String) -> Bool {
        
        let sChars = Array(s);
        let pCharts = Array(p);
        var dp = Array(repeating: Array(repeating: false, count: p.count + 1), count: s.count + 1)
        
        dp[0][0] = true;
        
        for i in 0...s.count {
            for j in 0...p.count {
                guard j > 0 else {
                    continue
                }
                
                let pCurrent = pCharts[j - 1];
                if pCurrent != "*" {
                    dp[i][j] = i > 0 && dp[i - 1][j - 1] && (pCurrent == sChars[i - 1] || pCurrent == "?")
                }else{
                    var flag = false
                    for k in 0...i {
                        if dp[k][j - 1] {
                            flag = true
                            break
                        }
                    }
                    
                    dp[i][j] = flag || j == 1
                }
                
                
            }
        }

        return dp[s.count][p.count];
    }
}


/*
 跳跃游戏2
 */

class QuestionFourtyFive {
    func jump(_ nums: [Int]) -> Int {
        
        var end = 0;
        var maxPosition = 0;
        var steps = 0;
        
        for i in 0..<nums.count - 1 {
            maxPosition = max(maxPosition, nums[i] + i);
            if i == end {
                end = maxPosition;
                steps += 1;
            }
        }
        
        return steps;
        
        
    }
}

/*
 全排列
 */

class QuestionFourtySix {
    func permute(_ nums: [Int]) -> [[Int]] {
        
        var res = [[Int]]();
        var path = [Int]();
        var isVistited = [Bool](repeating: false, count: nums.count);
        dfs(&res, &path, &isVistited, nums)
        return res;
    }
    
    private func dfs(_ res: inout [[Int]], _ path: inout [Int], _ isVisited: inout [Bool], _ nums:[Int]){
        
        guard path.count != nums.count else {
            res.append(path);
            return
        }
        
        for (i, num) in nums.enumerated() where !isVisited[i] {
            path.append(num);
            isVisited[i] = true;
            dfs(&res, &path, &isVisited, nums)
            isVisited[i] = false;
            path.removeLast();
        }
        
    }
    
}

/*
 全排列二
 */

class QuestionFourtySeven {
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        var res = [[Int]]();
        var path = [Int]();
        let nums = nums.sorted(by: <);
        
        var isVistited = [Bool](repeating: false, count: nums.count);
        dfs(&res, &path, &isVistited, nums)
        return res;
    }
    
    private func dfs(_ res: inout [[Int]], _ path: inout [Int], _ isVisited: inout [Bool], _ nums:[Int]){
           
        guard path.count != nums.count else {
            res.append(path);
            return
        }
           
        for i in 0..<nums.count {
            if isVisited[i] || (i > 0 && nums[i] == nums[i - 1]) && isVisited[i - 1] {
                continue;
            }
            path.append(nums[i]);
            isVisited[i] = true;
            dfs(&res, &path, &isVisited, nums);
            isVisited[i] = false;
            path.removeLast();
        }
           
    }
}

/*
 旋转图像
 */

class QuestionFourtyEight {
    func rotate(_ matrix: inout [[Int]]) {
        
        for i in 0..<matrix.count {
            for j in i..<matrix.count {
                let temp = matrix[i][j];
                matrix[i][j] = matrix[j][i];
                matrix[j][i] = temp;
            }
        }
        
        for i in 0..<matrix.count {
            for j in 0..<matrix.count/2 {
                let temp = matrix[i][matrix.count - j - 1];
                matrix[i][matrix.count - j - 1] = matrix[i][j];
                matrix[i][j] = temp;
            }
        }
        
    }
}

/*
 字母异位词分组
 */

class QuestionFourtyNine {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        
        var ans:[String:[String]] = [String:[String]]();
        
        for i in 0..<strs.count {
            let chars = String(Array(strs[i]).sorted(by: <));
            if !ans.keys.contains(chars) {
                ans[chars] = [strs[i]];
            }else{
                ans[chars] = ans[chars]! + [strs[i]];
            }
        }
        
        var results:[[String]] = [[String]]();
        
        for item in ans.values {
            results.append(item);
        }
        
        return results;
        
    }
}


/*
 Pow(x, n)
 */

class QuestionFifty {
    func myPow(_ x: Double, _ n: Int) -> Double {
        
        var x = x,n = n;
        
        if n < 0 {
            x = 1.0/x;
            n = -n;
        }
        
        var res = 1.0;
        while n > 0 {
            if n % 2 != 0 {
                res = res*x;
            }
            x = x*x;
            n = n/2;
        }
        return res;
    }
}

/*
 N皇后
 */
class QuestionFiftyOne {
    
    func solveNQueens(_ n: Int) -> [[String]] {
        
        guard n > 0 else {
            return [[String]]();
        }
        
        var boards = [[String]]()
        var board = Array(repeating: "", count: n)
        
        
        dfs(&boards, &board, n, 0);
        
        return boards;
    }
    
    func dfs(_ boards: inout [[String]], _ board: inout [String], _ n: Int, _ row: Int) {
        
        if row == n {
            boards.append(board);
        }
        
        for col in 0..<n {
            if isVaild(board, col, row) {
                board[row] = setRow(col, n);
                dfs(&boards, &board, n, row+1);
            }
            
            
        }
        
    }
    
    func isVaild(_ board:[String], _ col:Int, _ row:Int) ->Bool{
        
        var c = -1;
        
        for i in 0..<row {//找到每行对应的Q，
            for j in 0..<board[0].count {
                if chartAt(board[i], index: j) == "Q" {
                    c = j;
                    break;
                }
            }
            
            //检查列
            if c == col {
                return false;
            }
            
            //检查对角线
            if abs(c - col) == abs(row - i) {
                return false;
            }
            
        }
        
        
        
        return true;
    }
    
    func chartAt(_ str:String, index:Int) -> Character {
        return str[str.index(str.startIndex, offsetBy: index)]
    }
    
    
    func setRow(_ col: Int, _ n: Int) -> String {
        var string = "";
        
        for i in 0..<n {
            if i == col {
                string.append("Q")
            }else{
                string.append(".")
            }
        }
        return string;
    }
    
    
}



/*
  N皇后二
 */

class QuestionFiftyTwo {
    func totalNQueens(_ n: Int) -> Int {
        guard n > 0 else {
            return 0;
        }
        
        var boards = [[String]]();
        var board = Array(repeating: "", count: n);
        dfs(&boards, &board, n: n, row: 0)
        return boards.count;
    }
    
    func dfs(_ boards:inout [[String]], _ board: inout [String], n:Int, row: Int ) {
        
        if row == n {
            boards.append(board);
            return;
        }
        
        
        for col in 0..<n {
            if isVaild(board, col: col, row: row) {
                board[row] = setRow(col, n);
                dfs(&boards, &board, n: n, row: row+1);
            }
        }
        
    }
    
    func isVaild(_ board:[String], col:Int, row:Int) -> Bool {
        
        var c = -1;
        
        
        for i in 0..<row {
            for j in 0..<board[0].count {
                if charAt(board[i], j) == "Q" {
                    c = j;
                    break;
                }
            }
            
            if c == col {
                return false;
            }
            
            if abs(col - c) == abs(row - i) {
                return false;
            }
            
        }
        return true;
    }
    
    func charAt(_ str:String,_ index:Int) -> Character {
        return str[str.index(str.startIndex, offsetBy: index)];
    }
    
    func setRow(_ col:Int, _ n: Int) -> String {
        var str = "";
        for i in 0..<n {
            if i == col {
                str.append("Q");
            }else{
                str.append(".");
            }
        }
        return str;
    }
}

/*
 最大子序和
 */
class QuestionFiftyThree {
    func maxSubArray(_ nums: [Int]) -> Int {
      
        guard nums.count > 0 else {
            return 0;
        }
        var maxs = nums.first!;
        
        var sum = 0;
        for num in nums {
            if sum > 0 {
                sum += num;
            }else{
                sum = num;
            }
            maxs = max(maxs, sum);
        }
        return maxs;
    }
    
}


/*
 螺旋矩阵
 */

class QuestionFiftyFour {
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        
        guard matrix.count > 0 else {
            return [Int]();
        }
        let cCount = matrix.first!.count
        let rCount = matrix.count;
        
        var r = 0, c = 0;
        
        
        var results = [Int]();
        var seen = Array(repeating: Array(repeating: false, count: cCount), count: rCount);
        let stepC = [1,0,-1,0];
        let stepR = [0,1,0,-1];
        var dr = 0;
        
        for _ in 0..<cCount*rCount {
            results.append(matrix[r][c])
            seen[r][c] = true;
            let sR = r + stepR[dr];
            let sC = c + stepC[dr];
            if 0 <= sR && sR < rCount && 0 <= sC && sC < cCount && !seen[sR][sC] {
                r = sR;
                c = sC;
            }else{
                dr = (dr+1)%4;
                r += stepR[dr];
                c += stepC[dr];
            }
        }
        
        return results;
    }
    
}

/*
 跳跃游戏
 */

class QuestionFiftyFive {
    func canJump(_ nums: [Int]) -> Bool {
        
        var current = 0;
        for i in 0..<nums.count {
            if i > current {
                return false;
            }
            current = max(current, i + nums[i])
        }
        return true
    }
}

/*
 合并区间
 */

class QuestionFiftySix {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        
        let nums = intervals.sorted { (obj1, obj2) -> Bool in
            if obj1.first! != obj2.first!{
                return obj1.first! < obj2.first!;
            }else{
                return obj1.last! < obj2.last!;
            }
        }
        
        var results = [[Int]]();
                
        for interval in nums {
            
            if results.isEmpty || results.last![1] < interval[0] {
                results.append(interval)
            }else{
                var last = results.last!
                
                last[1] = max(last[1], interval[1])
                results.removeLast();
                results.append(last);
            }
            
        }
        
        return results;
    }
}

/*
 插入区间
 */
class QuestionFiftySeven {
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        
        if intervals.count == 0 {
            return [newInterval];
        }
        var newInterval = newInterval;
        
        var results = [[Int]]();
        
        var index = 0;
        
        while index < intervals.count && newInterval.first! > intervals[index].last! {
            results.append(intervals[index]);
            index += 1;
        }
        
        while index < intervals.count && newInterval.last! >= intervals[index].first! {
            let minStart = min(newInterval.first!, intervals[index].first!);
            let maxEnd = max(newInterval.last!, intervals[index].last!);
            newInterval[0] = minStart;
            newInterval[1] = maxEnd;
            index += 1;
        }
        results.append(newInterval);
        for i in index..<intervals.count {
            results.append(intervals[i])
        }
        return results;
    }
}
