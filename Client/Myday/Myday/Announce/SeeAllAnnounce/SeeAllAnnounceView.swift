//
//  SeeAllAnnounceView.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 3/10/2565 BE.
//

import SwiftUI
import AlertToast

struct SeeAllAnnounceView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var viewModel = SeeAllAnnounceViewModel()
    @State var refresh: Bool = false
    @State var error: Bool = false
    
    var body: some View {
        VStack{
            ScrollView{
                VStack(spacing: 10){
                    ForEach(viewModel.new, id: \.id) { index in
                        NavigationLink(destination: NewsDocumentView(type: .edit,currentNews: index)) {
                            ListNewView(item: index)
                        }
                        .foregroundColor(.black)
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .padding(.top)
            }
        }
        .frame(maxWidth: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(NSLocalizedString("Announce", comment: "Announce"))
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
            .frame(alignment: .center),
            
            trailing: NavigationLink(destination: NewsDocumentView(type: .create)) {
                VStack {
                    Image(systemName: "rectangle.fill.badge.plus")
                        .foregroundColor(.black)
                }
                
            }
            .frame(alignment: .center)
        )
        .refreshable {
            viewModel.loadData() { status in
                if status {
                    self.refresh = true
                } else {
                    self.error = true
                }
                viewModel.isStatusApi = status
            }
        }
        .toast(isPresenting: $refresh){
            AlertToast(displayMode: .alert, type: .complete(Color("02BC77")), title: "Refresh success")
                
        }
        .toast(isPresenting: $error){
            AlertToast(displayMode: .alert, type: .error(Color("D9534F")), title: "Refresh error")
        }
    }
    
    @ViewBuilder
    func ListNewView(item: NewsEntity) -> some View {
        HStack{
            VStack{
                AsyncImage(url: URL(string: item.image)) { image in
                    image
                        .resizable()
                        .frame(width: 125)
                        .cornerRadius(0)
                        .padding(.horizontal)
                } placeholder: {
                    ProgressView()
                }
                
            }
            .frame(width: 125)
            
            VStack(alignment: .leading){
                
                Text(item.name)
                    .modifier(Fonts(fontName: .bold, size: 18))
                    .lineLimit(1)
                
                Text(DateFormat().dateConvert(startDate: item.startDate, endDate: item.endDate))
                    .modifier(Fonts(fontName: .bold, size: 12))
                    .foregroundColor(Color("7E7E7E"))
                
            }
            .padding(.horizontal)
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(.white)
        .cornerRadius(3)
        .shadow(radius: 3)

    }
}

struct SeeAllAnnounceView_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllAnnounceView()
    }
}
