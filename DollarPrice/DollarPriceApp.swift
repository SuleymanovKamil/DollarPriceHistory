//
//  DollarPriceApp.swift
//  DollarPrice
//
//  Created by Камиль Сулейманов on 06.10.2021.
//

import SwiftUI

@main
struct DollarPriceApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.locale) var locale: Locale
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, Locale(identifier: "ru"))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
        }
    }
}
