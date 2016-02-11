//
//  ComplicationController.swift
//  Wristlight WatchKit Extension
//
//  Created by Michał Bażyński on 2/8/16.
//  Copyright © 2016 Michał Bażyński. All rights reserved.
//

import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {

    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {

        // Call the handler with the current timeline entry
        
        var timelineEntry: CLKComplicationTimelineEntry? = nil
        
        if let template = self.getTemplateForComplication(complication) {
            timelineEntry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template)
        }
        
        handler(timelineEntry)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(nil);
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        
        handler(self.getTemplateForComplication(complication))
    }
    
    // MARK: - templates

    func getTemplateForComplication(complication: CLKComplication) -> CLKComplicationTemplate? {
        switch complication.family {
        case .ModularSmall:
            return self.modularSmall()
        case .CircularSmall:
            return self.circularSmall()
        case .UtilitarianSmall:
            return self.utilitarianSmall()
        case .UtilitarianLarge:
            return self.utilitarianLarge()
        default:
            return nil
        }
    }

    func imageNamed(name: String) -> UIImage {
        // using correctly sized assets results in icons 2x too small. 
        // http://stackoverflow.com/questions/35318748/complication-image-is-displaying-too-small
        //return UIImage(named: name)!
        
        return UIImage(named: "bulbMask")!
    }
    
    func twoPieceImageProvider(name: String) -> CLKImageProvider {
        let image = self.imageNamed(name)
        let imageProvider = CLKImageProvider(onePieceImage: image, twoPieceImageBackground: image, twoPieceImageForeground: UIImage(named: "transparent")!)
        imageProvider.tintColor = UIColor(red: 252.0/255, green: 176.0/255, blue: 17.0/255, alpha: 1.0)
        return imageProvider
    }
    
    func modularSmall() -> CLKComplicationTemplate {
        let template = CLKComplicationTemplateModularSmallSimpleImage()
        template.imageProvider = self.twoPieceImageProvider("Complication/Modular")
        return template
    }

    func circularSmall() -> CLKComplicationTemplate {
        let template = CLKComplicationTemplateCircularSmallSimpleImage()
        template.imageProvider = CLKImageProvider(onePieceImage: self.imageNamed("Complication/Circular"))
        return template
    }

    func utilitarianSmall() -> CLKComplicationTemplate {
        let template = CLKComplicationTemplateUtilitarianSmallSquare()
        template.imageProvider = self.twoPieceImageProvider("Complication/Utilitarian")
        return template
    }

    func utilitarianLarge() -> CLKComplicationTemplate {
        let template = CLKComplicationTemplateUtilitarianLargeFlat()
        template.imageProvider = self.twoPieceImageProvider("Complication/Utilitarian")
        template.textProvider = CLKSimpleTextProvider(text: "WRISTLIGHT", shortText: "LIGHT")
        return template
    }

}
