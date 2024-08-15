//
//  TaskViewModel.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 8/8/2565 BE.
//

import Foundation
import Combine

class TaskViewModel: ObservableObject {
    
    var fetchTaskListUseCase: FetchTaskListUseCase
    @Published var taskData: [TaskEntity] = MockTaskEntity
    @Published var fliter: FilterActivity = .all
    @Published var selectDate: Date = Date()
    @Published var statusApi: Bool = false
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(){
        self.fetchTaskListUseCase = FetchTaskListUseCase(type: .all)
        
        Blinding()
    }
    
    func Blinding() {
        
        $selectDate
            .receive(on: RunLoop.main)
            .sink { value in

                self.statusApi = false
                self.taskData = MockTaskEntity
                self.fetchTaskListUseCase = FetchTaskListUseCase(type: self.fliter)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.fetchTaskListUseCase.execute(date: DateFormat().WorkDay(day: value), dateTime: value) { data, status in
    //                    // debugPrint(data)
                        let dataSorted = data.sorted(by: { DateFormat().timeStringToDate(item: $0.startTime)  < DateFormat().timeStringToDate(item: $1.startTime) })
                        self.taskData = dataSorted
                        self.statusApi = status
                    }
                }
            }
            .store(in: &cancelBag)
        
        $fliter
            .receive(on: RunLoop.main)
            .sink { value in
                self.statusApi = false
                self.taskData = MockTaskEntity
                self.fetchTaskListUseCase = FetchTaskListUseCase(type: value)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.fetchTaskListUseCase.execute(date: DateFormat().WorkDay(day: self.selectDate), dateTime: self.selectDate) { data, status in
    //                    // debugPrint(data)
                        let dataSorted = data.sorted(by: { DateFormat().timeStringToDate(item: $0.startTime) < DateFormat().timeStringToDate(item: $1.startTime) })
                        self.taskData = dataSorted
                        self.statusApi = status
                    }
                }
            }
            .store(in: &cancelBag)
        
    }
    
    func debugPrintData(data: String) {
        debugPrint("\(data)")
    }
}


