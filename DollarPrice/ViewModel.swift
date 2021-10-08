//
//  ViewModel.swift
//  DollarPrice
//
//  Created by Камиль Сулейманов on 08.10.2021.
//

import SwiftUI

class ViewModel: NSObject, ObservableObject {
    @Published var date = Date()
    @Published var showPrice = false
    @Published var dollarPrice = String()
    var prices = [String: String]()
    var currentElement = ""
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(from: DateComponents(year: 1998, month: 1, day: 1))!
        let max = Date()
        return min...max
    }
 
    func getPrice(completion: @escaping () -> ()) {
        let url = URL(string: "https://www.cbr.ru/scripts/XML_dynamic.asp?date_req1=\(dateFormatter.string(from: date))&date_req2=\(dateFormatter.string(from: date))&VAL_NM_RQ=R01235")!
        let request=URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("dataTaskWithRequest error: \(error)")
                return
            }
            guard let data = data else {
                print("dataTaskWithRequest data is nil")
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
            completion ()
            
        }
        task.resume()
    }
}

extension ViewModel: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            currentElement = elementName
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
                prices.updateValue(string, forKey: currentElement)
    }
}

extension ViewModel {
    func getPriceAndSaveIt(){
        DispatchQueue.main.async { [self] in
            if let price = prices["Value"] {
            dollarPrice = price
                saveToCoreData()
             
            }
        }
    }
}


extension ViewModel {
    func saveToCoreData() {
        let price = SearchData(context: PersistenceController.shared.container.viewContext)
        price.date =  dateFormatter2.string(from: date) + " доллар стоил " + dollarPrice.dropLast(2) + "₽"

        do {
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter
}()

let dateFormatter2: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "ru")
    return formatter
}()
