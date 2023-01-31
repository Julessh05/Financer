//
//  UserWrapper.swift
//  Financer
//
//  Created by Julian Schumacher on 04.01.23.
//

import CoreData
import Foundation

/// The Wrapper for a User Object used in this App.
/// It contains an optional User Object, just like the other Wrappers.
/// Unlike those other Wrappers, it also contains a double value for the bank
/// balance of the User, if the User is not logged in and with that no User is available.
internal final class UserWrapper : ObservableObject {
    
    /// The actual User Object for this App
    @Published internal final var user : User?
    
    /// The anonymous User for this App
    @Published private final var anonymousUser : User?
    
    /// The initializer to create a Wrapper Object with a User
    /// passed down the initializer.
    /// Mostly used for testing and previews.
    internal init(user : User? = nil) {
        self.user = user
    }
    
    /// Initilizes this User Wrapper.
    /// Do only call this once! Otherwise the Data will be lost
    internal func initUserWrapper(viewContext : NSManagedObjectContext) -> Void {
        guard anonymousUser == nil else { return }
        anonymousUser = createAnonymousUser(viewContext: viewContext)
    }
    
    /// The enum that determines in
    /// which direction the amount of the new finance should
    /// be going
    private enum Direction {
        
        /// Add the amount to the total
        /// balance
        case up
        
        /// subtract the amount from the total
        /// balance
        case down
    }
    
    /// Computed variable returning and setting
    /// the anonymous or user balance depending
    /// on the current State of the User
    internal private(set) var balance : Double {
        get { user!.balance }
        set { user!.balance = newValue }
    }
    
    /// Adjusts the balance depending on direction
    /// argument.
    ///
    /// This Function handles the User and anonymous Balance, depending on
    /// the Users currently logged in state
    private func adjustBalance(direction : Direction, amount : Double) -> Void {
        switch direction {
            case .up:
                balance += amount
            case .down:
                balance -= amount
        }
    }
    
    /// Function that should be called when a new
    /// Finance is added to the App and the User's
    /// balance should be updated
    internal func addFinance(_ finance : Finance) -> Void {
        if finance is Income {
            adjustBalance(direction: .up, amount: finance.amount)
        } else {
            adjustBalance(direction: .down, amount: finance.amount)
        }
    }
    
    /// Function that should be called when a
    /// Finance is removed from the App and the User's
    /// balance should be updated
    internal func removeFinance(_ finance : Finance) -> Void {
        if finance is Income {
            adjustBalance(direction: .down, amount: finance.amount)
        } else {
            adjustBalance(direction: .up, amount: finance.amount)
        }
    }
    
    /// Function called when a Finance is repalced.
    /// This removes the old Finances Data and updates it with
    /// the new Value calculated in.
    internal func replaceFinance(_ oldFinance : Finance, with newFinance: Finance) -> Void {
        removeFinance(oldFinance)
        addFinance(newFinance)
    }
    
    /// Returns a Dictionary containing the Date and the Balance on the end of that day.
    /// The index specifies the number of days to go back
    internal func balance(
        days : Int? = nil,
        with finances : any RandomAccessCollection<Finance>
    ) -> [(date : Date, amount : Double)] {
        guard !finances.isEmpty else {
            return []
        }
        var amounts : [Date : Double] = [ : ]
        var dict : [(date : Date, amount : Double)] = []
        let calendar : Calendar = Calendar.current
        let today : Date = Date()
        let intervalInSeconds : TimeInterval = Date.now.timeIntervalSince(finances.last!.date!)
        let interval = intervalInSeconds / 86400
        for index in 0..<Int(interval) {
            var i : Int = index
            i.negate()
            var date : Date = calendar.date(byAdding: .day, value: i, to: today)!
            var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
            dateComponents.hour = 24
            dateComponents.minute = 0
            dateComponents.second = 0
            date = calendar.date(from: dateComponents)!
            let financesOnDay : [Finance] = finances.filter {
                let dateToCheck = calendar.dateComponents([.year, .month, .day], from: $0.date!)
                return dateToCheck.year == dateComponents.year && dateToCheck.month == dateComponents.month && dateToCheck.day == dateComponents.day
            }
            var amount : Double = 0
            financesOnDay.forEach {
                finance in
                amount += finance.amount
            }
            amounts[date] = amount
            var balanceOfTheDay = self.balance
            for previousAmounts in amounts {
                balanceOfTheDay -= previousAmounts.value
            }
            dict.append((date: date, amount : balanceOfTheDay))
            if let check = days, index >= check {
                break
            }
        }
        return dict
    }
    
    /// Creates and returns an anonymous User for this App.
    private func createAnonymousUser(viewContext : NSManagedObjectContext) -> User {
        let anonymUser : User = User(context: viewContext)
        anonymUser.firstname = "Julian"
        anonymUser.lastname = "Schumacher"
        let calendar : Calendar = Calendar.current
        var dateComponents : DateComponents = DateComponents()
        dateComponents.year = 2005
        dateComponents.month = 2
        dateComponents.day = 22
        anonymUser.dateOfBirth = calendar.date(from: dateComponents)!
        anonymUser.gender = User.Gender.male.rawValue
        anonymUser.balance = 0
        anonymUser.userCreated = false
        return anonymUser
    }
    
    /// Function to call when the User logs into this App.
    /// The specified newUser is the User created.
    internal func logIn(newUser : User) throws -> Void {
        user = newUser
        user!.balance = anonymousUser!.balance
        try PersistenceController.shared.save()
    }
    
    /// Function to call when the User logs out of this App.
    /// This handles all the stuff with the anonymous User.
    internal func logOut() throws -> Void {
        anonymousUser!.balance = user!.balance
        user = anonymousUser
        try PersistenceController.shared.deleteUser(user!)
    }
}
