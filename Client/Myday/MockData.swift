//
//  MockData.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 19/9/2565 BE.
//

import Foundation
import SwiftUI

let MockDataClass: [Class] = [
    Class(day: "MON", color: Color("FFD950"), time: "16:30 - 19:30", nameSubject: "Business Intelligence System", detail: "02204462-60 หมู่ 700", room: "Room E-8501"),
    Class(day: "MON", color: Color("D9534F"), time: "16:30 - 19:30", nameSubject: "Business Intelligence System", detail: "02204462-60 หมู่ 700", room: "Room E-8501"),
    Class(day: "MON", color: Color("02BC77"), time: "16:30 - 19:30", nameSubject: "Business Intelligence System", detail: "02204462-60 หมู่ 700", room: "Room E-8501"),
    Class(day: "MON", color: Color("FEB744"), time: "16:30 - 19:30", nameSubject: "Business Intelligence System", detail: "02204462-60 หมู่ 700", room: "Room E-8501"),
    Class(day: "MON", color: Color("1E70CD"), time: "16:30 - 19:30", nameSubject: "Business Intelligence System", detail: "02204462-60 หมู่ 700", room: "Room E-8501")]

let MockTaskEntity: [TaskEntity] = [
    TaskEntity(type: .activity, name: "test001", startTime: "Date()", endTime: "Date()", location: "LH001", lecturer: "LH001", description: "LH001"),
    TaskEntity(type: .activity, name: "test002", startTime: "Date()", endTime: "Date()", location: "LH002", lecturer: "LH002", description: "LH001"),
    TaskEntity(type: .activity, name: "test003", startTime: "Date()", endTime: "Date()", location: "LH003", lecturer: "LH003", description: "LH001"),
    TaskEntity(type: .activity, name: "test004", startTime: "Date()", endTime: "Date()", location: "LH004", lecturer: "LH004", description: "LH001"),
]

var MockData: [TaskMetaData] = [
    TaskMetaData(task: [
        Task(title: "Business Intelligence Business Intelligence", room: "LH4-709", teacher: "A"),
        Task(title: "test2", room: "LH4-709", teacher: "A"),
        Task(title: "test3", room: "LH4-709", teacher: "A"),
        Task(title: "test1", room: "LH4-709", teacher: "A"),
        Task(title: "test2", room: "LH4-709", teacher: "A"),
        Task(title: "test3", room: "LH4-709", teacher: "A"),
        Task(title: "test1", room: "LH4-709", teacher: "A"),
        Task(title: "test2", room: "LH4-709", teacher: "A"),
        Task(title: "test3", room: "LH4-709", teacher: "A"),
        Task(title: "test1", room: "LH4-709", teacher: "A"),
        Task(title: "test2", room: "LH4-709", teacher: "A")
    ], taskDate: getSample(offset: 0)),
    
    TaskMetaData(task: [
        Task(title: "test1", room: "LH4-709", teacher: "A"),
        Task(title: "test2", room: "LH4-709", teacher: "A"),
        Task(title: "test3", room: "LH4-709", teacher: "A"),
        Task(title: "test4", room: "LH4-709", teacher: "A")
    ], taskDate: getSample(offset: -2)),
    
    TaskMetaData(task: [
        Task(title: "test1", room: "LH4-709", teacher: "A"),
        Task(title: "test2", room: "LH4-709", teacher: "A"),
        Task(title: "test3", room: "LH4-709", teacher: "A")
    ], taskDate: getSample(offset: -5)),
    
    TaskMetaData(task: [
        Task(title: "test1", room: "LH4-709", teacher: "A")
    ], taskDate: getSample(offset: -7))
]

let MockNew = NewsEntity(id: "", image: "Photo", name: "", startDate: Date(), endDate: Date())

let MockSubject = [SubjectEntity(id: "", name: "", room: "", date: .mon, lecturer: "", endTime: "", startTime: "", sec: ""),
                   SubjectEntity(id: "", name: "", room: "", date: .mon, lecturer: "", endTime: "", startTime: "", sec: ""),
                   SubjectEntity(id: "", name: "", room: "", date: .mon, lecturer: "", endTime: "", startTime: "", sec: ""),
                   SubjectEntity(id: "", name: "", room: "", date: .mon, lecturer: "", endTime: "", startTime: "", sec: ""),
                   SubjectEntity(id: "", name: "", room: "", date: .mon, lecturer: "", endTime: "", startTime: "", sec: "")]

let MockActivity = [ActivityEntity(id: "", name: "", date: Date(), description: "", location: "", startDate: Date(), endDate: Date()),
                    ActivityEntity(id: "", name: "", date: Date(), description: "", location: "", startDate: Date(), endDate: Date()),
                    ActivityEntity(id: "", name: "", date: Date(), description: "", location: "", startDate: Date(), endDate: Date()),
                    ActivityEntity(id: "", name: "", date: Date(), description: "", location: "", startDate: Date(), endDate: Date()),
                    ActivityEntity(id: "", name: "", date: Date(), description: "", location: "", startDate: Date(), endDate: Date())]

let MockNewSeeAll: [NewsEntity] = [NewsEntity(id: "1", image: "https://firebasestorage.googleapis.com/v0/b/myday-project.appspot.com/o/img_1.jpg?alt=media&token=d4135744-ae09-4da1-a7cf-2d788d98e8a0", name: "ที่จอด", startDate: Date(), endDate: Date()),
                           NewsEntity(id: "2", image: "https://firebasestorage.googleapis.com/v0/b/myday-project.appspot.com/o/img_2.jpg?alt=media&token=3e691cb5-0ff9-4889-8ac5-343ccf012ff7", name: "จองร้าน", startDate: Date(), endDate: Date()),
                           NewsEntity(id: "3", image: "https://firebasestorage.googleapis.com/v0/b/myday-project.appspot.com/o/img_3.jpg?alt=media&token=0a44f186-da7b-452c-b09d-dc3a376513dc", name: "จองร้าน", startDate: Date(), endDate: Date()),
                           NewsEntity(id: "4", image: "", name: "ฐานข้อมูลจบ", startDate: Date(), endDate: Date())]
//
//let MockCreateSubject = [[
//    "name":"Information Media for Learning",
//    "room":"LH4-503",
//    "date": "0",
//    "lecturer":"ภัทรพร จินตกานนท์",
//    "startTime":"10:00",
//    "endTime":"11:00",
//    "sec":"701",
//    "idsubject":"01371111"
//],[
//    "name": "Business Intelligence System and Knowledge Management",
//    "room": "E8403",
//    "date": "0",
//    "lecturer": "วีรชญา จารุปรีชาชาญ",
//    "endTime": "19:30",
//    "startTime": "16:30",
//    "sec": "700",
//    "idsubject": "02204462"
//],[
//    "name": "Pattern Recognition",
//    "room": "E8403",
//    "date": "1",
//    "lecturer": "เสกสรรค์ มธุลาภรังสรรค์ ",
//    "endTime": "16:00",
//    "startTime": "13:00",
//    "sec": "700",
//    "idsubject": "02204433"
//],[
//    "name": "Artificial Intelligence for Computer Engineer",
//    "room": "E8403",
//    "date": "2",
//    "lecturer": "อมรฤทธิ์ พุทธิพิพัฒน์ขจร ",
//    "endTime": "12:00",
//    "startTime": "10:30",
//    "sec": "700",
//    "idsubject": "02204431"
//],[
//    "name": "Data Security System",
//    "room": "E8403",
//    "date": "3",
//    "lecturer": "วรัญญา อรรถเสนา",
//    "endTime": "12:00",
//    "startTime": "9:00",
//    "sec": "700",
//    "idsubject": "02204452"
//],[
//    "name": "Computer Engineering Project I",
//    "room": "E8403",
//    "date": "3",
//    "lecturer": "พฤษพล ตั้งสัจจะธรรม",
//    "endTime": "18:00",
//    "startTime": "16:00",
//    "sec": "700",
//    "idsubject": "02204495"
//],[
//    "name": "Artificial Intelligence for Computer Engineer",
//    "room": "E8403",
//    "date": "4",
//    "lecturer": "อมรฤทธิ์ พุทธิพิพัฒน์ขจร",
//    "endTime": "12:00",
//    "startTime": "10:30",
//    "sec": "700",
//    "idsubject": "02204431"
//],[
//    "name": "Happiness in the 21st Century",
//    "room": "LH4-306",
//    "date": "4",
//    "lecturer": "เขวิกา สุขเอี่ยม,ดนชิดา วาทินพุฒิพร,นุชประวีณ์ ลิขิตศรัณย์",
//    "endTime": "19:00",
//    "startTime": "16:00",
//    "sec": "700",
//    "idsubject": "02999038"
//]]
 
let MockCreateSubject = [[
    "name": rsaDB.encryptData(text: "Information Media for Learning"),
    "room": rsaDB.encryptData(text: "LH4-503"),
    "date": "0",
    "lecturer":rsaDB.encryptData(text: "ภัทรพร จินตกานนท์"),
    "startTime":"10:00",
    "endTime":"11:00",
    "sec":rsaDB.encryptData(text: "701"),
    "idsubject":rsaDB.encryptData(text: "01371111")
],[
    "name": rsaDB.encryptData(text: "Business Intelligence System and Knowledge Management"),
    "room": rsaDB.encryptData(text: "E8403"),
    "date": "0",
    "lecturer":rsaDB.encryptData(text:  "วีรชญา จารุปรีชาชาญ"),
    "endTime": "19:30",
    "startTime": "16:30",
    "sec": rsaDB.encryptData(text: "700"),
    "idsubject":rsaDB.encryptData(text:  "02204462")
],[
    "name": rsaDB.encryptData(text: "Pattern Recognition"),
    "room":rsaDB.encryptData(text:  "E8403"),
    "date": "1",
    "lecturer": rsaDB.encryptData(text: "เสกสรรค์ มธุลาภรังสรรค์ "),
    "endTime": "16:00",
    "startTime": "13:00",
    "sec": rsaDB.encryptData(text: "700"),
    "idsubject": rsaDB.encryptData(text: "02204433")
],[
    "name":rsaDB.encryptData(text:  "Artificial Intelligence for Computer Engineer"),
    "room":rsaDB.encryptData(text:  "E8403"),
    "date": "2",
    "lecturer":rsaDB.encryptData(text:  "อมรฤทธิ์ พุทธิพิพัฒน์ขจร "),
    "endTime": "12:00",
    "startTime": "10:30",
    "sec":rsaDB.encryptData(text:  "700"),
    "idsubject":rsaDB.encryptData(text:  "02204431")
],[
    "name":rsaDB.encryptData(text:  "Data Security System"),
    "room":rsaDB.encryptData(text:  "E8403"),
    "date": "3",
    "lecturer":rsaDB.encryptData(text:  "วรัญญา อรรถเสนา"),
    "endTime": "12:00",
    "startTime": "9:00",
    "sec":rsaDB.encryptData(text:  "700"),
    "idsubject":rsaDB.encryptData(text:  "02204452")
],[
    "name":rsaDB.encryptData(text:  "Computer Engineering Project I"),
    "room":rsaDB.encryptData(text:  "E8403"),
    "date": "3",
    "lecturer":rsaDB.encryptData(text:  "พฤษพล ตั้งสัจจะธรรม"),
    "endTime": "18:00",
    "startTime": "16:00",
    "sec":rsaDB.encryptData(text:  "700"),
    "idsubject":rsaDB.encryptData(text:  "02204495")
],[
    "name":rsaDB.encryptData(text:  "Artificial Intelligence for Computer Engineer"),
    "room":rsaDB.encryptData(text:  "E8403"),
    "date": "4",
    "lecturer":rsaDB.encryptData(text:  "อมรฤทธิ์ พุทธิพิพัฒน์ขจร"),
    "endTime": "12:00",
    "startTime": "10:30",
    "sec":rsaDB.encryptData(text:  "700"),
    "idsubject":rsaDB.encryptData(text:  "02204431")
],[
    "name":rsaDB.encryptData(text:  "Happiness in the 21st Century"),
    "room":rsaDB.encryptData(text:  "LH4-306"),
    "date": "4",
    "lecturer":rsaDB.encryptData(text:  "เขวิกา สุขเอี่ยม,ดนชิดา วาทินพุฒิพร,นุชประวีณ์ ลิขิตศรัณย์"),
    "endTime": "19:00",
    "startTime": "16:00",
    "sec":rsaDB.encryptData(text:  "700"),
    "idsubject":rsaDB.encryptData(text:  "02999038")
]]
