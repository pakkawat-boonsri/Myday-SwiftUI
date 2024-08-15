//
//  NewDocumentView.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 3/10/2565 BE.
//

import SwiftUI
import AlertToast

struct NewsDocumentView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var type: TypeNewsDocument
    @StateObject var viewModel = NewsDocumentViewModel()
    @State var currentNews: NewsEntity?
    @State var isShowingContentView: Bool = false
    @State var comple: Bool = false
    @State var error: Bool = false
    
    func setUpEdit(currentNews: NewsEntity?){
        
        if let data = currentNews {
            viewModel.id = data.id
            viewModel.name = data.name
            viewModel.imageUrl = data.image
            viewModel.startDate = data.startDate
            viewModel.endDate = data.endDate
        }
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: CustomHeadSection(title: NSLocalizedString("image_url", comment: "รูปภาพ (URL)"))) {
                    CustomTextField(title: NSLocalizedString("image_url", comment: "รูปภาพ (URL)"), data : $viewModel.imageUrl)
               }
                
                Section(header: CustomHeadSection(title: NSLocalizedString("annouce_name", comment: "ชื่อประกาศ"))) {
                    CustomTextField(title: NSLocalizedString("annouce_name", comment: "ชื่อประกาศ"), data : $viewModel.name)
                }
                
                Section(header: CustomHeadSection(title: NSLocalizedString("startdate_time", comment: "วันและเวลาที่เริ่มประกาศ"))) {
                    
                    DatePicker(selection: $viewModel.startDate,
                               in: Date()...,
                               displayedComponents: [.date,.hourAndMinute]) {
                                   Text("Start date")
                               }
                }
                
                Section(header: CustomHeadSection(title: NSLocalizedString("enddate_time", comment: "วันและเวลาที่สิ้นสุดประกาศ"))) {
                    
                    DatePicker(selection: $viewModel.endDate,
                               in: viewModel.startDate...,
                               displayedComponents: [.date,.hourAndMinute]) {
                                   Text("End date")
                               }
                }
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
                    Text(type == .create ? NSLocalizedString("add_annouce", comment: "เพิ่มประกาศ") : NSLocalizedString("edit_annouce", comment: "แก้ไขประกาศ"))
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
//                self.viewModel.setUp(typeDocument: type)
                self.setUpEdit(currentNews: currentNews)
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
                    viewModel.deleteNewsAPIData { status in
                        
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
                    viewModel.updateNewsAPIData { status in

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
                    viewModel.addNewsAPIData() { status in
                        
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

struct NewDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDocumentView(type: .create)
    }
}
