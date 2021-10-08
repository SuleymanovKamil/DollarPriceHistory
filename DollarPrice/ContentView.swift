//
//  ContentView.swift
//  DollarPrice
//
//  Created by Камиль Сулейманов on 06.10.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    var body: some View {
        Home()
            .environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}






