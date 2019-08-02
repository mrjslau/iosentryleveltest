import Cocoa

struct Shop {
    let name:         String
    let adress:       String
    let workSchedule: WorkSchedule
    
    struct WorkSchedule {
        let monday:    WorkHours?
        let tuesday:   WorkHours?
        let wednesday: WorkHours?
        let thursday:  WorkHours?
        let friday:    WorkHours?
        let saturay:   WorkHours?
        let sunday:    WorkHours?
    }
    
    struct WorkHours {
        let from: String
        let to:   String
    }
}
