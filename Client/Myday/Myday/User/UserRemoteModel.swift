//
//  UserRemoteModel.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 22/9/2565 BE.
//

import Foundation

struct User {
    let token: String
    let email: String
}

struct UserRemoteModel: Codable {
    var status: Int?
    var result: UserInfo?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case result = "result"
    }
}

enum Role: Int {
    case nisit = 101
    case lecturer = 102
    case admin = 103
}

struct UserInfo: Codable {
    var id: String?
    var token: String?
    var name: String?
    var lname: String?
    var role: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case token = "token"
        case name = "name"
        case lname = "lname"
        case role = "role"
    }
}

struct SubjectRemoteModel: Codable {
    var status: Int?
    var result: [Subject]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case result = "result"
    }
}

struct Subject: Codable {
    var id: String?
    var name: String?
    var room: String?
    var date: String?
    var lecturer: String?
    var endTime: String?
    var startTime: String?
    var sec: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idsubject"
        case name = "name"
        case room = "room"
        case date = "date"
        case lecturer = "lecturer"
        case endTime = "endTime"
        case startTime = "startTime"
        case sec = "sec"
    }
}

struct UserInfoEntity {
    var id: String
    var token: String
    var name: String
    var lname: String
    var role: Role
}

enum Day: String {
    case mon = "0"
    case tue = "1"
    case wed = "2"
    case thu = "3"
    case fri = "4"
    case sat = "5"
    case sun = "6"
}

struct SubjectEntity {
    var id: String
    var name: String
    var room: String
    var date: Day
    var lecturer: String
    var endTime: String
    var startTime: String
    var sec: String
    
}
