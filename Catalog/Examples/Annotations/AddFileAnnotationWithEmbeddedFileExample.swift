//
//  Copyright © 2018-2022 PSPDFKit GmbH. All rights reserved.
//
//  The PSPDFKit Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from this file.
//

import Foundation
import PSPDFKit
import PSPDFKitUI

class AddFileAnnotationWithEmbeddedFileExample: Example, PDFViewControllerDelegate, PDFDocumentPickerControllerDelegate {

    var pdfController: PDFViewController?
    var documentPickerController: PDFDocumentPickerController?
    var longPressedPoint: CGPoint?

    override init() {
        super.init()

        title = "Add and remove file annotations with embedded files from a custom menu item"
        contentDescription = "Adds new menu items that will create and delete file annotations at the selected position."
        category = .annotations
        priority = 65
    }

    override func invoke(with delegate: ExampleRunnerDelegate) -> UIViewController {
        let document = AssetLoader.writableDocument(for: .quickStart, overrideIfExists: false)

        documentPickerController = PDFDocumentPickerController(directory: "/Bundle/Samples", includeSubdirectories: true, library: SDK.shared.library)
        documentPickerController?.delegate = self

        pdfController = PDFViewController(document: document)
        pdfController?.delegate = self
        return pdfController!
    }

    // MARK: - PDFViewControllerDelegate

    func pdfViewController(_ sender: PDFViewController, menuForAnnotations annotations: [Annotation], onPageView pageView: PDFPageView, appearance: EditMenuAppearance, suggestedMenu: UIMenu) -> UIMenu {
        // Make sure this delegate method is called for selected annotations
        // and that there is at least one file annotation.
        guard annotations.map(\.type).contains(.file) else {
            return suggestedMenu
        }
        // If one of the selected annotations is a file annotation, we add the
        // Delete Attachment menu item to delete all selected annotations.
        let deleteAction = UIAction(title: "Delete Attachment", image: UIImage(systemName: "trash"), attributes: [.destructive]) { _ in
            sender.document?.remove(annotations: annotations)
        }
        // Ignore the suggested delete action and prepend the custom one.
        return suggestedMenu.filterActions(noneOf: [.pspdfkit.delete]).prepend([deleteAction])
    }

    func pdfViewController(_ sender: PDFViewController, menuForCreatingAnnotationAt point: CGPoint, onPageView pageView: PDFPageView, appearance: EditMenuAppearance, suggestedMenu: UIMenu) -> UIMenu {
        let attachFileAction = UIAction(title: "Attach File", image: UIImage(systemName: "paperclip")) { [self] _ in
            // Store the long pressed point in PDF coordinates to be used to set the bounding box of the newly created file annotation.
            longPressedPoint = pageView.pdfCoordinateSpace.convert(point, from: pageView)
            // Present the document picker.
            sender.present(self.documentPickerController!, options: [.closeButton: true], animated: true, sender: nil)
        }
        // Compose the final menu.
        return suggestedMenu.prepend([attachFileAction])
    }

    // MARK: - PDFDocumentPickerControllerDelegate

    func documentPickerController(_ controller: PDFDocumentPickerController, didSelect document: Document, pageIndex: PageIndex, search searchString: String?) {
        let fileURL = document.fileURL
        let fileDescription = document.fileURL?.lastPathComponent

        // Create the file annotation and its embedded file
        let fileAnnotation = FileAnnotation()
        fileAnnotation.pageIndex = pageIndex
        fileAnnotation.boundingBox = CGRect(x: (self.longPressedPoint?.x)!, y: (self.longPressedPoint?.y)!, width: 32, height: 32)
        let embeddedFile = EmbeddedFile(fileURL: fileURL!, fileDescription: fileDescription)
        fileAnnotation.embeddedFile = embeddedFile

        // Add the embedded file to the document.
        pdfController?.document?.add(annotations: [fileAnnotation])

        // Dismiss the document picker.
        controller.dismiss(animated: true, completion: nil)
    }
}
