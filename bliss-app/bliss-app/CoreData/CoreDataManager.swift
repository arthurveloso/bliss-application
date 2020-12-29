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
    
    func saveEmoji(data: Data) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "Emoji", in: managedContext)!
        let emojiImage = Emoji(entity: userEntity, insertInto: managedContext)
        emojiImage.image = data
        
        do {
            try managedContext.save()
            debugPrint("Emoji Image saved")
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func fetchEmoji() -> [Emoji] {
        var emojis = [Emoji]()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return emojis }
        
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Emoji")

        do {
            emojis = try (managedContext.fetch(fetchRequest) as? [Emoji] ?? [Emoji()])
        } catch {
            debugPrint("Error while fetching the image")
        }
        return emojis
    }
    
    func saveAvatar(user: User) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "Avatar", in: managedContext)!
        
        // Validating existence of Avatar on CoreData
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = userEntity
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "username == %@", user.login ?? "")
        
        var count = 0
        do {
            count = try managedContext.count(for: fetchRequest)
            print(count)
        } catch {
            debugPrint(error.localizedDescription)
        }
        
        // Breaking save function if value is already on CoreData
        guard count == 0 else { return }
        
        let avatar = Avatar(entity: userEntity, insertInto: managedContext)
        
        let url = URL(string: user.avatarURL ?? "")
        if let data = try? Data(contentsOf: url!)
        {
            let pngData: Data = UIImage(data: data)?.pngData() ?? Data()
            avatar.avatar = pngData
        }
        avatar.username = user.login

        do {
            try managedContext.save()
            debugPrint("Avatar saved")
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func fetchAvatar() -> [Avatar] {
        var avatars = [Avatar]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return avatars }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Avatar")
        
        do {
            avatars = try (managedContext.fetch(fetchRequest) as? [Avatar] ?? [Avatar()])
        } catch {
            debugPrint("Error while fetching the image")
        }
        
        return avatars
    }
    
    func deleteAvatar(avatar: Avatar, completion: () -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(avatar)
        
        do {
            try managedContext.save()
            completion()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
