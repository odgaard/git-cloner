import Foundation

extension Process {
    public func shell(command: String) -> String {
        executableURL = URL(fileURLWithPath: "/bin/bash")
        arguments = ["-c", command]
        
        let outputPipe = Pipe()
        standardOutput = outputPipe
        do {
            try run()
        } catch {}
        
        let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
        guard let outputData = String(data: data, encoding: String.Encoding.utf8) else { return "" }
        
        return outputData.reduce("") { (result, value) in
            return result + String(value)
        }
    }
}

@discardableResult
public func run(command: String, arguments: [String]) -> String {
    let process = Process()
    let command = "\(command) \(arguments.joined(separator: " "))"
    return process.shell(command: command)
}