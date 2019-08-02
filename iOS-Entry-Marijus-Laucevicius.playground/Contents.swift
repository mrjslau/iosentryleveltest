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
        let saturday:  WorkHours?
        let sunday:    WorkHours?
    }
    
    struct WorkHours {
        let from: String
        let to:   String
    }
}

//
func printSchedule(shop: Shop) {
    var schedule : [String : String] = ["I" : "Closed"]
    
    schedule["I"] = checkHrs(workHrs: shop.workSchedule.monday)
    schedule["II"] = checkHrs(workHrs: shop.workSchedule.tuesday)
    schedule["III"] = checkHrs(workHrs: shop.workSchedule.wednesday)
    schedule["IV"] = checkHrs(workHrs: shop.workSchedule.thursday)
    schedule["V"] = checkHrs(workHrs: shop.workSchedule.friday)
    schedule["VI"] = checkHrs(workHrs: shop.workSchedule.saturday)
    schedule["VII"] = checkHrs(workHrs: shop.workSchedule.sunday)
    
    let sortedKeys = Array(schedule.keys).sorted(by: <)

    print(schedule)
    
    print(sortedKeys)
}

func checkHrs(workHrs : Shop.WorkHours?) -> String {
    if let hrs = workHrs {
        return hrs.from + "-" + hrs.to
    } else {
        return "Closed"
    }
}





// Test data
let shopOne = Shop(name: "Maxima", adress: "Ukmergės g. 264", workSchedule: Shop.WorkSchedule(monday: nil, tuesday: Shop.WorkHours(from: "10:00", to: "16:00"), wednesday: Shop.WorkHours(from: "10:00", to: "16:00"), thursday: Shop.WorkHours(from: "10:00", to: "16:00"), friday: Shop.WorkHours(from: "10:00", to: "14:00"), saturday: nil, sunday: nil))

// Test the app
printSchedule(shop: shopOne)
