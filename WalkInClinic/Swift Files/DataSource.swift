import UIKit
import CoreData

class DataSource {
    
    public var context:NSManagedObjectContext! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var contacts:[Contact]? = nil

    func fetchContacts(filter:String) -> [Contact]?{
        let request = Contact.fetchRequest() as NSFetchRequest<Contact>
        if(!filter.isEmpty){
            request.predicate = NSPredicate(format: "name CONTAINS[c] %@ OR phone CONTAINS[c] %@ OR email CONTAINS[c] %@ OR companyUrl CONTAINS[c] %@ OR job_title CONTAINS[c] %@", filter, filter, filter, filter, filter)
        }
        do{
            contacts = try context.fetch(request)
            print("Got local data of Count: \(String(describing: contacts?.count)) with filter \(filter)")
        } catch{
            print("Error getting contacts data with filter \(filter)")
        }
        return contacts
    }
    
    func saveContact(uid:String, name:String, phone:Int64, email:String, companyUrl:String, linkedIn:String, job_title:String, image:Data)->Bool{
        
        let data = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: context) as! Contact
       
        data.uid = uid
        data.name = name
        data.email = email
        data.phone = phone
        data.linkedInUrl = linkedIn
        data.companyUrl = companyUrl
        data.job_title = job_title
        data.image = image
        
        do{
            try context.save()
            print("Data saved successfully \(String(describing: data.email))")
            return true
        } catch{
            print("Error saving data")
            return false
        }
    }
    
    func delete(data:Contact, index:Int) -> Bool{
        contacts?.remove(at: index)
        context?.delete(data)
        do{
            try context?.save()
            print("Delete success")
            return true
        }catch{
            print("Error while Delete data")
            return false
        }
    }
    
    func update(data:Contact, index:Int) -> Bool{
        contacts?[index] = data
        do{
            try context?.save()
            print("Update success")
            return true
        }catch{
            print("Error while updating data")
            return false
        }
    }
}
