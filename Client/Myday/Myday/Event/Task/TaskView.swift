//
//  TaskView.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 7/8/2565 BE.
//

import SwiftUI
import SkeletonUI

struct TaskView: View {
    
    @Binding var selectDate: Date
    @Binding var filter: FilterActivity
    private let dateFormat = DateFormat()
    @StateObject var viewModel = TaskViewModel()

    
    var body: some View {
        
        LazyVStack(alignment: .leading,spacing: 10){
            
            if (viewModel.taskData.isEmpty == false),
               let tasks = viewModel.taskData{
                VStack{
                    Spacer(minLength: 20)
                    LazyVStack{
                        ForEach(tasks){ item in
                            HStack{
                                TaskDetailView(item: item)
                            }
                            Spacer(minLength: 20)
                        }
                    }
                    .padding(.horizontal)
                    Rectangle().foregroundColor(.white).frame(height:480)
                }
            } else {
                Spacer()
                
                VStack{
                    Image("onActivity")
                        .resizable()
                        .frame(width: 220,height: 220)
                    
                    Text("No Activity")
                        .modifier(Fonts(fontName: .semiBold, size: 18))
                        .foregroundColor(Color("7E7E7E"))
                        .opacity(0.7)
                        .frame(minWidth:0, maxWidth: .infinity)
                }
                .padding(.top)
                Rectangle().foregroundColor(.white).frame(height:340)
            }
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
        .onChange(of: selectDate){ value in
            withAnimation{
                viewModel.selectDate = value
            }
        }
        .onChange(of: filter) { value in
            viewModel.fliter = value
        }
        
    }
    
    @ViewBuilder
    func TaskDetailView(item:TaskEntity) -> some View {
        HStack{
            VStack(alignment: .leading,spacing: 5){

                HStack{
                    Text("\(item.name)")
                        .modifier(Fonts(fontName: .semiBold, size: 18))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .skeleton(with: viewModel.statusApi == false, size: CGSize(width: 200, height: 20))
                    
                    Spacer()
                    
                    if item.type == .course {
                        ZStack{
                            Text(NSLocalizedString("filter_course", comment: ""))
                                .modifier(Fonts(fontName: .semiBold, size: 10))
                                .foregroundColor(.white)
                                .padding(.horizontal,10)
                        }
                        .background(Capsule().foregroundColor(Color("brown")))
                        .skeleton(with: viewModel.statusApi == false, size: CGSize(width: 60, height: 15))
                    } else {
                        ZStack{
                            Text(NSLocalizedString("filter_activity", comment: ""))
                                
                                .modifier(Fonts(fontName: .semiBold, size: 10))
                                .foregroundColor(.white)
                                .padding(.horizontal,10)
                        }
                        .background(Capsule().foregroundColor(Color("02BC77")))
                        .skeleton(with: viewModel.statusApi == false, size: CGSize(width: 60, height: 15))
                    }
                }

                
                Text("\(item.startTime) - \(item.endTime)")
                    .font(.system(size: 12))
                    .foregroundColor(Color("davyGrey"))
                    .skeleton(with: viewModel.statusApi == false, size: CGSize(width: 100, height: 15))
                
                HStack{
                    if  item.type == .course {
                        Text("Room :")
                            .modifier(Fonts(fontName: .semiBold, size: 15))
                            .foregroundColor(.primary)
                    } else {
                        Text("Location :")
                            .modifier(Fonts(fontName: .semiBold, size: 15))
                            .foregroundColor(.primary)
                    }
                    
                    Text("\(item.location)")
                        .modifier(Fonts(fontName: .semiBold, size: 15))
                        .foregroundColor(.primary)
                }
                .skeleton(with: viewModel.statusApi == false, size: CGSize(width: 120, height: 15))

                HStack{
                    if  item.type == .course {
                        Text("Teacher :")
                            .modifier(Fonts(fontName: .semiBold, size: 15))
                            .foregroundColor(.primary)
                        
                        Text("\(item.lecturer)")
                            .modifier(Fonts(fontName: .semiBold, size: 15))
                            .foregroundColor(.primary)
                        
                    } else {
                        VStack{
                            Text("Description :")
                                .modifier(Fonts(fontName: .semiBold, size: 15))
                                .foregroundColor(.primary)
                            
                            Spacer()
                        }

                        VStack{
                            Text("\(item.description)")
                                .modifier(Fonts(fontName: .semiBold, size: 15))
                                .foregroundColor(.primary)
                            Spacer()
                        }
                    }
                }
                .skeleton(with: viewModel.statusApi == false, size: CGSize(width: 150, height: 15))
                

            }.padding([.leading,.vertical],8)
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(5)
        .shadow(color: .gray, radius: 1, x: 0, y: 1)
    }
}





struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
