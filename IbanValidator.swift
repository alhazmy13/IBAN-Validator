import UIKit


extension String {
    private func mod97() -> Int {
        let symbols: [Character] = Array(self)
        let swapped = symbols.dropFirst(4) + symbols.prefix(4)
        let mod: Int = swapped.reduce(0) { (previousMod, char) in
            let value = Int(String(char), radix: 36)!
            let factor = value < 10 ? 10 : 100
            let m = (factor * previousMod + value) % 97
            return m
        }
        
        return mod
    }
    
    func isValidIban() -> Bool {
        guard self.count >= 4 else {
            return false
        }
        let uppercase = self.uppercased()
        guard uppercase.range(of: "^[0-9A-Z]*$", options: .regularExpression) != nil else {
            return false
        }
        return (uppercase.mod97() == 1)
    }
}