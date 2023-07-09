//
//  ContentView.swift
//  WeSplit
//
//  Created by Muhammad Doukmak on 7/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var textFocus

    private var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tip = checkAmount * tipSelection / 100.0

        let total = checkAmount + tip

        return total / peopleCount
    }
    private let currencyCode = Locale.current.currency?.identifier ?? "USD"

    private let tipPercentages = [10, 15, 20 , 25, 0]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
                        .keyboardType(.decimalPad)
                        .focused($textFocus)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }

                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Tip Percentage")
                }

                Section {
                    Text(totalPerPerson, format: .currency(code: currencyCode))
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        textFocus = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice(.init(stringLiteral: "iPhone 14"))
                .previewDisplayName("iPhone 14")
        }
    }
}
