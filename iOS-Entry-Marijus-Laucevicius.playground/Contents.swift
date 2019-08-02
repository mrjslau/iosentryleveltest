// Marijus Laucevicius iOS Entry Level Test 2019.08.02
import Cocoa



// ---------------------------------------------------
// ----------------  MAIN ASSIGNMENT  ----------------

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

// Main function
func printSchedule(shop: Shop) {
    var schedule = [String : String]()
    
    // Populate new dictionary with data, later to be used in sorting
    schedule["I"] = checkHrs(workHrs: shop.workSchedule.monday)
    schedule["II"] = checkHrs(workHrs: shop.workSchedule.tuesday)
    schedule["III"] = checkHrs(workHrs: shop.workSchedule.wednesday)
    schedule["IV"] = checkHrs(workHrs: shop.workSchedule.thursday)
    schedule["V"] = checkHrs(workHrs: shop.workSchedule.friday)
    schedule["VI"] = checkHrs(workHrs: shop.workSchedule.saturday)
    schedule["VII"] = checkHrs(workHrs: shop.workSchedule.sunday)
    
    // Get sorted dictionary keys to sort dictionary's values by day
    var sortedKeys = Array(schedule.keys).sorted(by: <)
    
    // Get the grouped schedule
    schedule = groupSchedule(schedule: schedule, keys: sortedKeys)
    
    // Print the new shop's schedule
    sortedKeys = Array(schedule.keys).sorted(by: <)
    print(shop.name + "(" + shop.adress + ")" + " schedule: ")
    for day in sortedKeys {
        print(day + " - " + schedule[day]!)
    }
    print("\n")
}

// Function to check the working hours of every day and fill the dictionary with either the hours or "Closed" if object is 'nil'
func checkHrs(workHrs : Shop.WorkHours?) -> String {
    if let hrs = workHrs {
        return hrs.from + "-" + hrs.to
    } else {
        return "Closed"
    }
}

// Function for sorting the schedule to get the desired format
func groupSchedule(schedule: [String : String], keys: Array<String>) -> [String : String] {
    var groupedSchedule = [String : String]()
    // Days not to be iterated in the main loop again
    var sortedDays = [String]()
    // Days for inner loop
    var nextKeys = keys
    // Variable used for deleting last added key value pair to dictionary
    var temp : String? = nil
    
    // Main loop
    for day in keys {
        // Always remove first element from second array (don't compare eg. "I" with "I"
        nextKeys.removeFirst(1)
        // If nextDays after days are sorted don't start the inner loop
        if !(sortedDays.contains(day)) {
            
            // Inner loop
            for nextDay in nextKeys {
                // Group if same work hrs
                if schedule[day] == schedule[nextDay] {
                    
                    sortedDays.append(nextDay)
                    
                    // Delete last record if needed
                    if let lastDay = temp{
                        groupedSchedule.removeValue(forKey: lastDay)
                        groupedSchedule[day + "-" + nextDay] = schedule[day]
                        temp = day + "-" + nextDay
                    } else {
                        groupedSchedule[day + "-" + nextDay] = schedule[day]
                        temp = day + "-" + nextDay
                    }
                    
                // Add a separate key value pair if hrs don't match. Break loop and start next comparison from this day
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





// TEST DATA
let shopOne = Shop(name: "Maxima", adress: "Ukmergės g. 264", workSchedule: Shop.WorkSchedule(
    monday: Shop.WorkHours(from: "10:00", to: "16:00"),
    tuesday: Shop.WorkHours(from: "10:00", to: "16:00"),
    wednesday: Shop.WorkHours(from: "10:00", to: "16:00"),
    thursday: Shop.WorkHours(from: "10:00", to: "16:00"),
    friday: Shop.WorkHours(from: "9:00", to: "14:00"),
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

// RUN THE APP
print("\n ------------  MAIN ASSIGNMENT ------------ \n")
printSchedule(shop: shopOne)
printSchedule(shop: shopTwo)
printSchedule(shop: shopThree)
print("\n ------------------------------------------ \n")

// ----------------  MAIN ASSIGNMENT  ----------------
// ---------------------------------------------------
