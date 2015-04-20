import CoreData
class CoreDataStack {
    let context:NSManagedObjectContext!
    let psc:NSPersistentStoreCoordinator!
    let model:NSManagedObjectModel!
    let store:NSPersistentStore!
    
    init() {
        //1
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("CoreDataTest3", withExtension:"momd")
        model = NSManagedObjectModel(contentsOfURL: modelURL!)
        //2
        psc = NSPersistentStoreCoordinator(managedObjectModel:model)
        //3
        context = NSManagedObjectContext()
        context.persistentStoreCoordinator = psc
        //4
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as! [NSURL]
        let documentsURL = urls[0]
        let storeURL = documentsURL.URLByAppendingPathComponent("CoreDataTest3")
        let options = [NSMigratePersistentStoresAutomaticallyOption: true]
        var error: NSError? = nil
        store = psc.addPersistentStoreWithType(NSSQLiteStoreType,
            configuration: nil, URL: storeURL, options: options, error:&error)
        if store == nil {
            println("Error adding persistent store: \(error)")
            abort()
        }
    }
    func saveContext() {
        var error: NSError? = nil
        if context.hasChanges && !context.save(&error) {
            println("Could not save: \(error), \(error?.userInfo)") }
    }
}
  