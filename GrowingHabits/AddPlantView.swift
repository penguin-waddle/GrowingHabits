//
//  AddPlantView.swift
//  GrowingHabits
//
//  Created by Vivien on 7/21/23.
//

import SwiftUI

struct AddPlantView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var wateringFrequency = ""
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Plant Name", text: $name)
                TextField("Watering Frequency", text: $wateringFrequency)
                .keyboardType(.numberPad)
            }
            .navigationBarTitle("New Plant")
            .navigationBarItems(trailing: Button("Save") {
                if validateForm() {
                    let newPlant = Plant(context: self.managedObjectContext)
                    newPlant.name = self.name
                    newPlant.wateringFrequency = Int32(self.wateringFrequency) ?? 0

                    do {
                        try self.managedObjectContext.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error)
                    }
                } else {
                    self.showingAlert = true
                }
            })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func validateForm() -> Bool {
        if name.isEmpty {
            alertTitle = "Missing Plant Name"
            alertMessage = "Please enter a name for the plant."
            return false
        }

        if wateringFrequency.isEmpty {
            alertTitle = "Missing Watering Frequency"
            alertMessage = "Please enter a watering frequency for the plant."
            return false
        }

        if Int32(wateringFrequency) == nil {
            alertTitle = "Invalid Watering Frequency"
            alertMessage = "Watering frequency must be a number."
            return false
        }

        return true
    }
}


struct AddPlantView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlantView()
    }
}
