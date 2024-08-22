import Combine
import Foundation

@available(macOS 10.15, *)
struct Main {
    static func run() {
        var cancellables: Set<AnyCancellable> = []
        let monitor = Monitor()
        let historyManager = HistoryManager(filePath: "YouCanCallMeX/macos-clipboard/clipboard_history.txt")

        monitor.clipboardPublisher.sink { clipboardContent in
            historyManager.saveToClipboardHistory(clipboardContent)
        }.store(in: &cancellables)
        RunLoop.current.run()
    }
}

// Ensure the Main struct is only used on macOS 10.15 or newer
if #available(macOS 10.15, *) {
    Main.run()
} else {
    print("This version of macOS does not support the monitor features. Try with compatible versions")
}