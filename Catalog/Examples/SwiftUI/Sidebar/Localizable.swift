//
//  Copyright © 2021-2022 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

import Foundation
import SwiftUI

protocol Localizable: CaseIterable, RawRepresentable {
    var localizedName: LocalizedStringKey { get }
}

extension Localizable where RawValue == String {
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
