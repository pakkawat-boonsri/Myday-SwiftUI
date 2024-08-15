//
//  CustomDatePickerViewModel.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 6/8/2565 BE.
//

import Foundation
import Combine
import Alamofire

class CustomCalendarViewModel: ObservableObject {
    
    let days: [String] = [NSLocalizedString("day_sun", comment: "Sun"),
                          NSLocalizedString("day_mon", comment: "Mon"),
                          NSLocalizedString("day_tue", comment: "Tue"),
                          NSLocalizedString("day_wed", comment: "Wed"),
                          NSLocalizedString("day_thu", comment: "Thu"),
                          NSLocalizedString("day_fri", comment: "Fri"),
                          NSLocalizedString("day_sat", comment: "Sat")]
    
    @Published var selectDate: Date = Date()
    @Published var montDate: Date = Date()
    @Published var eventDate: [Date] = []
    @Published var classDate: [ClassDay] = []
    @Published var status: Bool = false
    
    init(){
        self.fetchData() { status in
            self.status = status
        }
    }
    
    func setMont(num: Int) {
        montDate = Calendar.current.date(byAdding: .month, value: num, to: Date())!
    }
    
    func fetchData(comple: @escaping (Bool) -> Void){
        
        fetchEvent() { data in
            self.eventDate = data
            
            self.fetchClass() { data in
                self.classDate = data
                comple(true)
            }
            
        }
    }
    
    func fetchEvent(comple: @escaping ([Date]) -> Void){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/LL"
        dateFormatter.locale = Locale(identifier: "en_US")

//        let montyearFormatter = DateFormatter()
//        montyearFormatter.dateFormat = "LL/YYYY"
//
//        let eventFormatter = DateFormatter()
//        eventFormatter.dateFormat = "dd/MM/yy"
//        eventFormatter.locale = Locale(identifier: "en_US")
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM/dd/yyyy"
        dateFormatterGet.locale = Locale(identifier: "en_US")
        
        
        let selectDateString = dateFormatter.string(from: self.montDate)
        
        let url: String = apiUrl + "calendar/" + selectDateString
        
        AF.request(url).responseDecodable(of: EventRemoteModel.self) { response in
                  switch (response.result){
                  case .success:
                      if let data = response.value?.result {
                          
                          let event: [Date] = data.compactMap { item in
                              let date = dateFormatterGet.date(from: item)
                              return date
                          }
//                          debugPrint("Event = ",dayFormatter.string(from: event[0]))
                          comple(event)
                      } else {
                          debugPrint("Event = ",selectDateString)
                      }
                    break
                  case .failure:
                    // debugPrint("fetchAnnounce Error \(response.result)")
                    break
                  }
            }
    }
    
    func fetchClass(comple: @escaping ([ClassDay]) -> Void) {
        if let token = userInfo?.token {
            
            let url: String = apiUrl + "subject/" + token
            
            AF.request(url).responseDecodable(of: SubjectRemoteModel.self) { response in
                      switch (response.result) {
                      case .success:
                          if let data = response.value?.result {

                              let classday : [ClassDay] = data.compactMap { item in
                                  let day : ClassDay = ClassDay(day: Day(rawValue: item.date!)!)
                                  return day
                              }
                              // debugPrint("EventUrl = ",classday)
                              comple(classday)
                          } else {
//                              debugPrint("Event = ",selectDateString)
                          }
                        break
                      case .failure:
                        // debugPrint("fetchAnnounce Error \(response.result)")
                        break
                      }
                }
        }
    }
   
}

struct EventRemoteModel: Codable {
    var status: Int?
    var result: [String]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case result = "result"
    }
}

struct EventDay: Codable {
    var day: Int
    
    enum CodingKeys: String, CodingKey {
        case day = "day"
    }
}

struct ClassDay {
    var day: Day
}



