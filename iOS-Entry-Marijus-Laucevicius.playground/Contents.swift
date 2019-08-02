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

func printSchedule(shop: Shop) {
    var schedule = [String : String]()
    
    schedule["I"] = checkHrs(workHrs: shop.workSchedule.monday)
    schedule["II"] = checkHrs(workHrs: shop.workSchedule.tuesday)
    schedule["III"] = checkHrs(workHrs: shop.workSchedule.wednesday)
    schedule["IV"] = checkHrs(workHrs: shop.workSchedule.thursday)
    schedule["V"] = checkHrs(workHrs: shop.workSchedule.friday)
    schedule["VI"] = checkHrs(workHrs: shop.workSchedule.saturday)
    schedule["VII"] = checkHrs(workHrs: shop.workSchedule.sunday)
    
    
    let sortedKeys = Array(schedule.keys).sorted(by: <)
    
    print("------------" + shop.name + " schedule: ")
    print(groupSchedule(schedule: schedule, keys: sortedKeys))
}

func checkHrs(workHrs : Shop.WorkHours?) -> String {
    if let hrs = workHrs {
        return hrs.from + "-" + hrs.to
    } else {
        return "Closed"
    }
}

func groupSchedule(schedule: [String : String], keys: Array<String>) -> [String : String] {
    var groupedSchedule = [String : String]()
    
    var sortedDays = [" ",]
    
    var nextKeys = keys
    
    var temp : String? = nil
    
    for day in keys {
        nextKeys.removeFirst(1)
        if !(sortedDays.contains(day)) {
            
            for nextDay in nextKeys {
                if schedule[day] == schedule[nextDay] {
                    sortedDays.append(nextDay)
                    if let lastDay = temp{
                        groupedSchedule.removeValue(forKey: lastDay)
                        groupedSchedule[day + "-" + nextDay] = schedule[day]
                        temp = day + "-" + nextDay
                    } else {
                        groupedSchedule[day + "-" + nextDay] = schedule[day]
                        temp = day + "-" + nextDay
                    }
                } else {
                    groupedSchedule[nextDay] = schedule[nextDay]
                    temp = nextDay
                    break
                }
            }
        }
        
    }
    
    return groupedSchedule
}





// Test data
let shopOne = Shop(name: "Maxima", adress: "Ukmergės g. 264", workSchedule: Shop.WorkSchedule(
    monday: Shop.WorkHours(from: "10:00", to: "16:00"),
    tuesday: Shop.WorkHours(from: "10:00", to: "16:00"),
    wednesday: Shop.WorkHours(from: "10:00", to: "16:00"),
    thursday: Shop.WorkHours(from: "10:00", to: "16:00"),
    friday: Shop.WorkHours(from: "10:00", to: "14:00"),
    saturday: nil,
    sunday: nil))

let shopTwo = Shop(name: "Iki", adress: "Santariškių g. 1", workSchedule: Shop.WorkSchedule(
    monday: Shop.WorkHours(from: "8:00", to: "22:00"),
    tuesday: Shop.WorkHours(from: "8:00", to: "22:00"),
    wednesday: Shop.WorkHours(from: "8:00", to: "22:00"),
    thursday: Shop.WorkHours(from: "8:00", to: "22:00"),
    friday: Shop.WorkHours(from: "8:00", to: "22:00"),
    saturday: Shop.WorkHours(from: "8:00", to: "22:00"),
    sunday: nil))

let shopThree = Shop(name: "Rimi", adress: "Ukmergės g. 10", workSchedule: Shop.WorkSchedule(
    monday: nil,
    tuesday: nil,
    wednesday: Shop.WorkHours(from: "10:00", to: "15:00"),
    thursday: Shop.WorkHours(from: "10:00", to: "16:00"),
    friday: Shop.WorkHours(from: "10:00", to: "14:00"),
    saturday: nil,
    sunday: nil))

// Test the app
printSchedule(shop: shopOne)
printSchedule(shop: shopTwo)
printSchedule(shop: shopThree)
