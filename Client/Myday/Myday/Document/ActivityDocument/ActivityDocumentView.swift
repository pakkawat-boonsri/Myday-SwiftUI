//
//  ActivityDocumentView.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 19/9/2565 BE.
//

import SwiftUI
import AlertToast

struct ActivityDocumentView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var type: TypeActivityDocument
    @State var currentActivity: ActivityEntity?
    
    @StateObject var viewModel = ActivityDocumentViewModel()
    @State private var isShowingContentView = false
    
    @State var comple: Bool = false
    @State var error: Bool = false
    
    func setUpEdit(currentActivity: ActivityEntity?){
        
        if let data = currentActivity {
            viewModel.id = data.id
            viewModel.name = data.name
            viewModel.location = data.location
            viewModel.startDate = data.startDate
            viewModel.endDate = data.endDate
            viewModel.description = data.description
        }
        
    }
    
    var body: some View {
            VStack {
                Form {
                    Section(header: CustomHeadSection(title: NSLocalizedString("activity_name", comment: "ชื่อกิจกรรม"))) {
                        CustomTextField(title: NSLocalizedString("activity_name", comment: "ชื่อกิจกรรม"), data : $viewModel.name)
                   }.textCase(nil)
                    
                    Section(header: CustomHeadSection(title: NSLocalizedString("location", comment: "สถานที่กิจกรรม"))) {
                        CustomTextField(title: NSLocalizedString("location", comment: "สถานที่กิจกรรม"), data : $viewModel.location)
                    }.textCase(nil)
                    
                    Section(header: CustomHeadSection(title: NSLocalizedString("date_time", comment: "วันและเวลาจัดกิจกรรม"))) {
                        
                        DatePicker(selection: $viewModel.startDate,
                                   in: Date()...,
                                   displayedComponents: [.date,.hourAndMinute]) {
                                       Text("Start date")
                                   }

                        DatePicker(selection: $viewModel.endDate,
                                   in: viewModel.startDate...,
                                   displayedComponents: [.date,.hourAndMinute]) {
                                       Text("End date")
                                   }
                    }.textCase(nil)
                    
                    Section(header: CustomHeadSection(title: NSLocalizedString("activity_detail", comment: "รายละเอียดกิจกรรม"))) {
                        TextEditor(text: $viewModel.description)
                            .frame(height: 205)
                            .autocorrectionDisabled(true)
                            
                    }.textCase(nil)
                }
                VStack{
                    VStack{
                        ButtonView()
                    }
                    .frame(height: 60)
                    .background(.white)
                }
            }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(type == .create ? NSLocalizedString("add_activity", comment: "เพิ่มกิจกรรม") : NSLocalizedString("edit_activity", comment: "แก้ไขกิจกรรม"))
                        .modifier(Fonts(fontName: .medium, size: 20))
                }
                .frame(alignment: .center)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button {
                self.mode.wrappedValue.dismiss()
            } label: {
                VStack {
                    Image(systemName: "arrow.backward.circle.fill")
                        .foregroundColor(Color("geraldine"))
                }
                
            }
            .frame(alignment: .center)
        )
        .toast(isPresenting: $comple){
            AlertToast(displayMode: .alert, type: .complete(Color("02BC77")), title: viewModel.massageComple)
        }
        .toast(isPresenting: $error){
            AlertToast(displayMode: .alert, type: .error(Color("D9534F")), title:viewModel.massageError)
        }
        .onAppear{
            DispatchQueue.main.async {
                self.viewModel.setUp(typeDocument: type)
                self.setUpEdit(currentActivity: currentActivity)
            }
        }
    }
    
    @ViewBuilder
    func CustomHeadSection(title: String) -> some View {
        Text(title)
            .modifier(Fonts(fontName: .bold, size: 20))
            .foregroundColor(.black)
            .padding(.leading,-15)
    }
    
    @ViewBuilder
    func CustomTextField(title: String,data : Binding<String>) -> some View{
        TextField(title, text: data)
            .modifier(Fonts(fontName: .medium, size:16))
            .autocorrectionDisabled(true)
    }
    
    @ViewBuilder
    func ButtonView() -> some View {
        HStack {
            Spacer()
            
            if type == .edit {
                Button {
                    viewModel.deleteActivityAPIData { status in
                        
                        self.comple = status
                        self.error = (status == false)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                            self.isShowingContentView = status
                        }
                    }
                } label: {
                    VStack{
                        Text(NSLocalizedString("delete_bt", comment: ""))
                            .foregroundColor(.white)
                            .modifier(Fonts(fontName: .semiBold, size: 20))
                    }
                    .frame(width: 150,height: 40)
                    .background(
                        Rectangle()
                            .foregroundColor(Color("7E7E7E"))
                    )
                    .cornerRadius(5)
                }
                
                Spacer()
            }

            NavigationLink(destination: MyDayContentView()
                                            .navigationTitle("")
                                            .navigationBarHidden(true)
                           , isActive: $isShowingContentView) {
                EmptyView()
            }

            
            if type == .edit {
                Button {
                    viewModel.updateActivityAPIData { status in

                            self.comple = status
                            self.error = (status == false)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                            self.isShowingContentView = status
                        }
                    }
                } label: {
                    VStack{
                        Text(NSLocalizedString("edit_bt", comment: ""))
                            .foregroundColor(.white)
                            .modifier(Fonts(fontName: .semiBold, size: 20))
                    }
                    .frame(width: 150,height: 40)
                    .background(
                        Rectangle()
                            .foregroundColor(Color("FEB744"))
                    )
                    .cornerRadius(5)
                }
            } else {
                
                Button {
                    viewModel.addActivityAPIData() { status in
                        
                        self.comple = status
                        self.error = (status == false)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                            self.isShowingContentView = status
                        }
                    }
                } label: {
                    VStack{
                        Text(NSLocalizedString("create_bt", comment: ""))
                            .foregroundColor(.white)
                            .modifier(Fonts(fontName: .semiBold, size: 23))
                    }
                    .frame(width: 250,height: 40)
                    .background(
                        Rectangle()
                            .foregroundColor(Color("FEB744"))
                    )
                    .cornerRadius(5)
                }
            }
            Spacer()
        }
    }
}

struct ActivityDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDocumentView(type: .create)
    }
}
