//
//  Home.swift
//  DollarPrice
//
//  Created by Камиль Сулейманов on 08.10.2021.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        NavigationView {
            VStack {
                dataPicker
                Spacer()
                showPriceButton
                Spacer()
                history
                navLink
            }
            .navigationBarTitle("Выберите дату")
        }
    }
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: SearchData.entity(), sortDescriptors: [])
    private var searchHistory: FetchedResults<SearchData>
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(ViewModel())
    }
}

extension Home {
    private var dataPicker: some View {
        DatePicker("Dates",
                   selection: $vm.date,
                   in: vm.dateClosedRange,
                   displayedComponents: [.date])
            .datePickerStyle(.graphical)
    }
    
    private var showPriceButton: some View {
        Button(action: {
            vm.getPrice()
            vm.showPrice = true
            
        }, label: {
            Text("Показать цену")
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue.cornerRadius(20))
                .padding(.bottom)
        })
    }
    
    private var history: some View {
        Group {
            Text("История поиска")
                .font(.headline)
                .opacity(searchHistory.isEmpty ? 0 : 1)
            
            ScrollView (showsIndicators: false) {
                VStack (alignment: .leading, spacing: 4){
                    ForEach(searchHistory.reversed(), id: \.self) {
                        Text($0.date ?? "")
                            .font(.callout)
                    }
                }
            }
        }
    }
    private var navLink: some View {
        NavigationLink(isActive: $vm.showPrice) {
            dollarPriceView()
        } label: { EmptyView() }
    }
}
