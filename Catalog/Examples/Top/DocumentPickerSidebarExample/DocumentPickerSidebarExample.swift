//
//  Copyright © 2017-2022 PSPDFKit GmbH. All rights reserved.
//
//  The PSPDFKit Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from this file.
//

class DocumentPickerSidebarExample: Example {

    override init() {
        super.init()

        title = "Document Picker Sidebar"
        contentDescription = "Displays a Document Picker in the sidebar."
        category = .top
        priority = 5
        wantsModalPresentation = true
        embedModalInNavigationController = false
    }

    override func invoke(with delegate: ExampleRunnerDelegate) -> UIViewController? {
        return PSCSplitViewController()
    }
}
