import Foundation

@main
public struct Localize {
    public static func main() {
        guard Utils.projectDirectory != nil else {
            print("Project dir can't be found!".inRed)
            print("Please pass project dir as argument..!".inYellow)
            return
        }

        guard !Utils.localizableFiles.isEmpty else {
            print("Project doesn't contain localizable files!".inRed)
            return
        }

        askForUserInput()
    }

    private static func askForUserInput() {
        while true {
            print("Hello, What operation do you want to perform?? [ Add / Modify / Remove / Exit]")

            let operation = readLine()
            switch operation?.lowercased() {
            case "a", "add":
                LocaleManager.tryAddingKey()
            case "m", "modify":
                LocaleManager.tryModifyingKey()
            case "r", "remove":
                LocaleManager.tryRemovingKey()
            case "e", "exit":
                exit(0)
            default:
                continue
            }
        }
    }
}
