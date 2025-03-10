//
//  Copyright © 2017-2022 PSPDFKit GmbH. All rights reserved.
//
//  The PSPDFKit Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from this file.
//

class PasswordPresetExample: Example {

    override init() {
        super.init()
        title = "Password preset"
        category = .security
    }

    override func invoke(with delegate: ExampleRunnerDelegate) -> UIViewController {
        let document = AssetLoader.document(for: "Password-Protected.pdf")
        document.unlock(withPassword: "test123")
        return PDFViewController(document: document)
    }
}
