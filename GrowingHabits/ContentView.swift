//
//  ContentView.swift
//  GrowingHabits
//
//  Created by Vivien on 7/18/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \User.username, ascending: true)],
        predicate: NSPredicate(format: "username == %@", "example_username")
    ) var users: FetchedResults<User>

    // then fetch the plants
    @FetchRequest(entity: Plant.entity(), sortDescriptors: [])
    var allPlants: FetchedResults<Plant>

    var userPlants: [Plant] {
        allPlants.filter { $0.user == users.first }
    }

    var body: some View {
        NavigationView {
            List(userPlants, id: \.self) { plant in
                Text(plant.name ?? "Unknown") // replace with PlantRow view
            }
            .navigationBarTitle("My Plants")
            .navigationBarItems(trailing: Button(action: {
                let newPlant = Plant(context: self.managedObjectContext)
                newPlant.name = "New Plant"
                newPlant.id = UUID()
                // set the other properties...
                newPlant.user = User(context: self.managedObjectContext) // this should be a User instance
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print(error)
                }
            }) {
                Image(systemName: "plus")
            })
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
