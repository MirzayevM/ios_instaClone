//
//  Utils.swift
//  ios_instaClone
//
//  Created by Mirzabek on 01/11/22.
//

import Foundation
import SwiftUI


class Utils{
    static var color1 = Color(red:193/255,green: 53/255,blue: 132/255)
    static var color2 = Color(red:253/255,green: 29/255,blue: 29/255)
    
    static var image = "https://lh6.googleusercontent.com/-9lzOk_OWZH0/URquoo4xYoI/AAAAAAAAAbs/AwgzHtNVCwU/s1024/Frantic.jpg"
    
    static var image2 = "https://lh4.googleusercontent.com/-JhFi4fb_Pqw/URquuX-QXbI/AAAAAAAAAbs/IXpYUxuweYM/s1024/Horseshoe%252520Bend.jpg"
    
    static func currentDate() -> String{
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = df.string(from: date)
        return dateString
    }
}

    extension UIScreen{
        static let width = UIScreen.main.bounds.size.width
        static let height = UIScreen.main.bounds.size.height
        static let size = UIScreen.main.bounds.size
    }
    
  


struct ActivityViewController: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context)
    {}
    
    
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController (context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
        
    }
    
  
    
    
    
    struct ShareSheet : UIViewControllerRepresentable{
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context)
        {}
        
        typealias Callback = (_ activityType: UIActivity.ActivityType?,_ completed : Bool,_ returnedItems:[Any]?, _ error: Error?) -> Void
        
        let activityItems: [Any]
        let applicayionActivities: [UIActivity]? = nil
        let excludedActivityTypes: [UIActivity.ActivityType]? = nil
        let callback: Callback? = nil
        
        func makeUIViewController(context: Context) -> some UIActivityViewController {
            let controller = UIActivityViewController(
                activityItems: activityItems,
                applicationActivities: applicayionActivities)
            controller.excludedActivityTypes = excludedActivityTypes
            controller.completionWithItemsHandler = callback
            return controller
        }
        
        
    }
}
