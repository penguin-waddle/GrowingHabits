//
//  PlantDetailView.swift
//  GrowingHabits
//
//  Created by Vivien on 7/19/23.
//

import SwiftUI
import CoreData

struct PlantDetailView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var plant: Plant

    @State var name: String = ""
    @State var wateringFrequency: String = ""

    var body: some View {
        Form {
            Section(header: Text("Plant Details")) {
                TextField("Plant Name", text: $name)
                TextField("Watering Frequency", text: $wateringFrequency)
            }
            Button(action: {
                self.plant.name = self.name
                self.plant.wateringFrequency = Int32(self.wateringFrequency) ?? 0
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print(error)
                }
            }) {
                Text("Save Changes")
            }
        }.onAppear {
            self.name = self.plant.name ?? ""
            self.wateringFrequency = String(self.plant.wateringFrequency)
        }
        .onDisappear {
            if self.plant.name == nil {
                self.managedObjectContext.delete(self.plant)
            }
        }
    }
}


struct PlantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = NSPersistentContainer(name: "GrowingHabitsModel").viewContext
        let newPlant = Plant(context: context)
        newPlant.name = "Test Plant"
        newPlant.wateringFrequency = 3
        newPlant.lastWateredDate = Date()
        newPlant.avatar = "🌱"
        newPlant.importance = 1
        return PlantDetailView(plant: newPlant).environment(\.managedObjectContext, context)
    }
}


