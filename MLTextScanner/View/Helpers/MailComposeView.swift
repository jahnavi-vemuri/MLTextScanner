//
//  MailComposeView.swift
//  MLTextScanner
//
//  Created by Jahnavi Vemuri on 22/03/24.
//

import SwiftUI
import MessageUI

struct MailComposeView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    var fileName: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = context.coordinator
        mailComposer.setSubject(Constants.Email.subject)
        mailComposer.setMessageBody(Constants.Email.body, isHTML: false)
        // Provide the file extension directly
        let fileExtension = "txt" // Change this to the actual file extension you want to attach

        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
            do {
                let fileData = try Data(contentsOf: fileURL)
                mailComposer.addAttachmentData(fileData, mimeType: Constants.Email.format, fileName: fileName)
            } catch {
                print("Error adding attachment: \(error)")
            }
        }

        return mailComposer
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailComposeView

        init(_ parent: MailComposeView) {
            self.parent = parent
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
        }
    }
}
