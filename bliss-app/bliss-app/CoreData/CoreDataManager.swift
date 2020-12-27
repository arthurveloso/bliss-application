//
//  CoreDataManager.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 26/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    func saveImage(data: Data) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "Emoji", in: managedContext)!
        let emojiImage = Emoji(entity: userEntity, insertInto: managedContext)
        emojiImage.image = data
        
        do {
            try managedContext.save()
            print("Emoji Image saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage() -> [Emoji] {
        var emojis = [Emoji]()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return emojis }
        
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Emoji")

        do {
            emojis = try (managedContext.fetch(fetchRequest) as? [Emoji] ?? [Emoji()])
        } catch {
            print("Error while fetching the image")
        }
        return emojis
    }

//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    func saveImage(data: Data) {
//        let imageInstance = Image(context: context)
//        imageInstance.img = data
//        do {
//            try context.save()
//            print("Image is saved")
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
}
