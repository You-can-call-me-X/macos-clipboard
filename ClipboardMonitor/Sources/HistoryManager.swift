import Foundation

public class HistoryManager {
    
    private var filePath: String
    init(filePath: String){
        self.filePath = filePath
    }

    func saveToClipboardHistory(_ content: String) {
        let fileURL = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(filePath)
        let entry = "\(Date()): \(content)\n"
        do {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                let fileHandle = try FileHandle(forWritingTo: fileURL)
                fileHandle.seekToEndOfFile()
                if let data = entry.data(using: .utf8) {
                    fileHandle.write(data)
                }
                fileHandle.closeFile()
            } else {
                try entry.write(to: fileURL, atomically: true, encoding: .utf8)
            }
        } catch {
            print("Failed to save clipboard content: \(error)")
        }
    }
}
