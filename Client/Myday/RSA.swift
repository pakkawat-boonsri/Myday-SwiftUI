//
//  RSA.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 14/9/2565 BE.
//

import Foundation
import SwiftUI


precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

public class RSA {
    
    private var largePrimes: largePrimesModel
    private var privateKey: Int?
    private var coprime: Int?
    private var publicKey : publicKeyModel?
    
    init(p: Int = 73, q: Int = 89){
        self.largePrimes = largePrimesModel(p: p, q: q)
    }
    
    
    func setPublicKey(n: Int,e: Int) {
        self.coprime = e
        self.largePrimes.n = n
    }
    
    func genKey(){
        
        let prime = primes(upTo: 997)
        
        let randomP = Int.random(in: 30..<prime.count)
        let p = prime[randomP]
        
        let randomQ = Int.random(in: 30..<prime.count)
        let q = prime[randomQ]
        debugPrint("p: \(p) & q: \(q)")
        self.largePrimes = largePrimesModel(p: p, q: q)
        
        self.coprime = findCoprime()
        self.privateKey = findPrivateKey(e: self.coprime!, data: self.largePrimes)
        
        self.publicKey = publicKeyModel(n: self.largePrimes.n, e: self.coprime!)
    }
    
    func getPrivateKey() -> Int {
        return self.privateKey ?? 0
    }
    
    func getPublicKey() -> publicKeyModel {
        return self.publicKey!
    }
    
    private func primes(upTo rangeEndNumber: Int) -> [Int] {
        let firstPrime = 2
        guard rangeEndNumber >= firstPrime else {
            fatalError("End of range has to be greater than or equal to (firstPrime)!")
        }
        var numbers = Array(firstPrime...rangeEndNumber)

        // Index of current prime in numbers array, at the beginning it is 0 so number is 2
        var currentPrimeIndex = 0

        // Check if there is any number left which could be prime
        while currentPrimeIndex < numbers.count {
            // Number at currentPrimeIndex is next prime
            let currentPrime = numbers[currentPrimeIndex]

            // Create array with numbers after current prime and remove all that are divisible by this prime
            var numbersAfterPrime = numbers.suffix(from: currentPrimeIndex + 1)
            numbersAfterPrime.removeAll(where: { $0 % currentPrime == 0 })

            // Set numbers as current numbers up to current prime + numbers after prime without numbers divisible by current prime
            numbers = numbers.prefix(currentPrimeIndex + 1) + Array(numbersAfterPrime)

            // Increase index for current prime
            currentPrimeIndex += 1
        }

        return numbers
    }
    
    private func exponentMod(A: Int, B: Int, C: Int) -> Int {
        // Base cases
        if A == 0{
            return 0
        }
            
        if B == 0 {
            return 1
        }
            
     
        // If B is even
        var y: Int;
        if (B % 2 == 0) {
            y = exponentMod(A: A, B: (B / 2), C: C)
            y = (y * y) % C;
        }
     
        // If B is odd
        else {
            y = A % C;
            y = (y * exponentMod(A: A, B: B - 1, C: C) % C) % C
        }
     
        return (y + C) % C;
    }
    
    private func findPrivateKey(e: Int, data: largePrimesModel) -> Int{
        var d = 1
        
        while((d * e) % data.p_q != 1){
            d += 1
        }
        return d
    }
    
    private func  gcd(_ a: Int, _ b: Int) -> Int {
      let r = a % b
      if r != 0 {
        return gcd(b, r)
      } else {
        return b
      }
    }
    
    private func findCoprime() -> Int {
        var e = 2
        
        while(gcd(e, self.largePrimes.p_q) != 1){
            e += 1
        }
        
        return e
    }
    
    private func bruteKeyEncrypt(key: [Int]) -> String  {
        
        var result: String = ""
        
        for index in key {
            
            let alphabet = String(UnicodeScalar(UInt8((index % 26) + 65)))
                                  
            result.append(alphabet)
            
            var k = 0
            var data = index
            
            while(data >= 26){
                k += 1
                data -= 26
            }
            
            result.append(String(k))
            result.append(":")
        }
        
        return result
    }
    
    func encryptData(text: String) -> String {
//        debugPrint("PublicKey")
//        debugPrint("e:",self.getPublicKey().e)
//        debugPrint("n:",self.getPublicKey().n)
//        debugPrint("PrivateKey : ",self.getPrivateKey())
        
        let data = self.encyption(data: text)
        let code = self.bruteKeyEncrypt(key: data)
        return code
    }
    
    func decryptData(text: String) -> String {
//        debugPrint("PublicKey")
//        debugPrint("e:",self.getPublicKey().e)
//        debugPrint("n:",self.getPublicKey().n)
//        debugPrint("PrivateKey : ",self.getPrivateKey())
        
        let code = self.bruteKeyDecrypt(key: text)
        let data = self.decyption(data: code)
        return data
    }
    
    private func testA() -> String {
//        var str = "19-aAก-zZฮ-ะ"
////        var temp = str.utf8
//        for v in str.unicodeScalars {
//            debugPrint(v, v.value)
//        }
        return "temp"
    }
    
    private func bruteKeyDecrypt(key: String) -> [Int]  {

        var result: [Int] = []

        var alphabet: Int = 0
        var y: String = ""
        
        for index in key {
            switch(index) {
//            case "ก"..."ฮ" :
//                for v in index.unicodeScalars{
//                    alphabet = Int(v.value) - 3585
//                }
//                break
            case "A"..."Z" :
                for v in index.unicodeScalars{
                    alphabet = Int(v.value) - 65
                }
                break
            case "0"..."9" : y.append(index)
                break
            case ":" :
                result.append(((Int(y) ?? 0) * 26) + alphabet)
                alphabet = 0
                y = ""
                break
            default:
                break
            }
        }

        return result
    }
    
    
    private func encyption(data: String) -> [Int] {
        
        var cipherText: [Int] = []
        
        self.coprime = findCoprime()
        
        for index in data {
            var item = 0
            for v in index.unicodeScalars{
                item = Int(v.value)
                let result = exponentMod(A: Int(item), B: self.coprime!, C: largePrimes.n)  //Int(item) ^^ self.coprime! % largePrimes.n
                cipherText.append(result)
            }
        }
        
        return cipherText
    }
    
    private func decyption(data: [Int]) -> String {
        var plantText: String = ""
        
        for index in data {
            let item = exponentMod(A: index, B: self.privateKey!, C: largePrimes.n)
            plantText.append(String(Unicode.Scalar(item)!))
        }
        
        return plantText
    }
    
}


struct largePrimesModel {
    let p: Int
    let q: Int
    var n: Int
    var p_q: Int
    
    init(p: Int, q: Int){
        self.p = p
        self.q = q
        self.n = p * q
        self.p_q = (p-1) * (q-1)
    }
}

struct publicKeyModel {
    let n: Int
    let e: Int
}
