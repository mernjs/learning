// Define a class representing a Bank Account
class BankAccount {
    // Properties
    var accountNumber: String
    var balance: Double
    
    // Initializer
    init(accountNumber: String, balance: Double) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
    
    // Method to deposit money into the account
    func deposit(amount: Double) {
        balance += amount
        print("Deposited \(amount) into account \(accountNumber). New balance: \(balance)")
    }
    
    // Method to withdraw money from the account
    func withdraw(amount: Double) {
        if balance >= amount {
            balance -= amount
            print("Withdrawn \(amount) from account \(accountNumber). New balance: \(balance)")
        } else {
            print("Insufficient funds in account \(accountNumber)")
        }
    }
}

// Define a subclass of BankAccount representing a Savings Account
class SavingsAccount: BankAccount {
    // Properties
    var interestRate: Double
    
    // Initializer
    init(accountNumber: String, balance: Double, interestRate: Double) {
        self.interestRate = interestRate
        super.init(accountNumber: accountNumber, balance: balance)
    }
    
    // Method to apply interest to the account balance
    func applyInterest() {
        let interestAmount = balance * interestRate
        balance += interestAmount
        print("Applied interest to account \(accountNumber). New balance: \(balance)")
    }
}

// Usage
let account1 = SavingsAccount(accountNumber: "123456", balance: 1000.0, interestRate: 0.05)
let account2 = BankAccount(accountNumber: "987654", balance: 500.0)

//account1.deposit(amount: 200.0) // Output: Deposited 200.0 into account 123456. New balance: 1200.0
//account1.withdraw(amount: 300.0) // Output: Withdrawn 300.0 from account 123456. New balance: 900.0
//account1.applyInterest() // Output: Applied interest to account 123456. New balance: 945.0
//
//account2.deposit(amount: 100.0) // Output: Deposited 100.0 into account 987654. New balance: 600.0
//account2.withdraw(amount: 700.0) // Output: Insufficient funds in account 987654
