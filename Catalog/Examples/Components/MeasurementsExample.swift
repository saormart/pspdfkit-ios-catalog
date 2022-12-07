//
//  Copyright © 2022 PSPDFKit GmbH. All rights reserved.
//
//  The PSPDFKit Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from this file.
//

import UIKit

class MeasurementsExample: Example {
    override init() {
        super.init()
            title = "Measurement Tools"
            contentDescription = "Showcases support for all kinds of measurement annotations."
            category = .componentsExamples
            priority = 10
    }

    override func invoke(with delegate: ExampleRunnerDelegate) -> UIViewController? {
        let document = AssetLoader.document(for: "Measurements.pdf")
        let pdfController = PDFViewController(document: document)
        return pdfController
    }
}
