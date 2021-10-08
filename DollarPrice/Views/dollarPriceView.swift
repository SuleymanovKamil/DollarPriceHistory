//
//  dollarPriceView.swift
//  DollarPrice
//
//  Created by Камиль Сулейманов on 08.10.2021.
//

import SwiftUI

struct dollarPriceView: View {
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        VStack {
            Text("Доллар стоил - " + vm.dollarPrice.dropLast(2) + "₽")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            Spacer()
        }
        .navigationBarTitle(dateFormatter2.string(from: vm.date))
    }
}

struct dollarPriceView_Previews: PreviewProvider {
    static var previews: some View {
        dollarPriceView()
            .environmentObject(ViewModel())
    }
}
