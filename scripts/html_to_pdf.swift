import WebKit
import AppKit

let htmlPath = "/Users/sanghyunkim/Desktop/ai-company/teams/03-synthesis/약사-AI-Agent-IR자료.html"
let pdfPath = "/Users/sanghyunkim/Desktop/ai-company/teams/03-synthesis/약사-AI-Agent-IR자료.pdf"

let htmlURL = URL(fileURLWithPath: htmlPath)
let htmlContent = try! String(contentsOf: htmlURL, encoding: .utf8)

class PDFPrinter: NSObject, WKNavigationDelegate {
    let webView: WKWebView
    let semaphore = DispatchSemaphore(value: 0)

    override init() {
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: NSRect(x: 0, y: 0, width: 595, height: 842), configuration: config)
        super.init()
        webView.navigationDelegate = self
    }

    func run() {
        webView.loadHTMLString(htmlContent, baseURL: htmlURL.deletingLastPathComponent())
        semaphore.wait()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let printInfo = NSPrintInfo()
            printInfo.paperSize = NSSize(width: 595.28, height: 841.89) // A4
            printInfo.topMargin = 56.7    // 2cm
            printInfo.bottomMargin = 56.7
            printInfo.leftMargin = 51.0   // 1.8cm
            printInfo.rightMargin = 51.0
            printInfo.isHorizontallyCentered = true
            printInfo.isVerticallyCentered = false

            let printOp = webView.printOperation(with: printInfo)
            printOp.showsPrintPanel = false
            printOp.showsProgressPanel = false

            // Save to PDF
            printInfo.jobDisposition = .save
            printInfo.dictionary()[NSPrintInfo.AttributeKey.jobSavingURL] = URL(fileURLWithPath: pdfPath)

            printOp.run()

            // Verify
            if FileManager.default.fileExists(atPath: pdfPath) {
                let attrs = try! FileManager.default.attributesOfItem(atPath: pdfPath)
                let size = attrs[.size] as! Int
                print("PDF saved: \(pdfPath)")
                print("File size: \(size.formatted()) bytes")
            } else {
                print("PDF creation failed, trying alternative...")
                self.createPDFAlternative(webView: webView)
            }
            self.semaphore.signal()
        }
    }

    func createPDFAlternative(webView: WKWebView) {
        webView.createPDF(configuration: .init()) { result in
            switch result {
            case .success(let data):
                try! data.write(to: URL(fileURLWithPath: pdfPath))
                print("PDF saved (alt method): \(pdfPath)")
                print("File size: \(data.count.formatted()) bytes")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

let app = NSApplication.shared
let printer = PDFPrinter()

DispatchQueue.main.async {
    printer.run()
    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
        app.terminate(nil)
    }
}

app.run()
