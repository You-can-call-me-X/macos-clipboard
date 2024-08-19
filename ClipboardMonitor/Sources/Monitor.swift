import Cocoa
import Combine

@available(macOS 10.15, *)
public class Monitor {
    private let pasteboard = NSPasteboard.general
    private var lastChangeCount: Int

    let clipboardPublisher = PassthroughSubject<String, Never>()

    init() {
        self.lastChangeCount = pasteboard.changeCount
        startMonitoring()
    }

     private func startMonitoring() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.checkForChanges()
        }
    }

    private func checkForChanges() {
        let currentChangeCount = pasteboard.changeCount
        if currentChangeCount != lastChangeCount {
            lastChangeCount = currentChangeCount
            if let clipboardContent = pasteboard.string(forType: .string) {
                clipboardPublisher.send(clipboardContent)
            }
        }
    }
}