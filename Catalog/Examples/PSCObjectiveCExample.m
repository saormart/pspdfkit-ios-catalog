//
//  Copyright © 2015-2022 PSPDFKit GmbH. All rights reserved.
//
//  The PSPDFKit Sample applications are licensed with a modified BSD license.
//  Please see License for details. This notice may not be removed from this file.
//

// See 'PlaygroundExample.swift' for the Swift version of this example.

#import "CatalogSwift.h"
#import "PSCExample.h"

@interface PSCObjectiveCExample : PSCExample
@end
@implementation PSCObjectiveCExample

- (instancetype)init {
    if ((self = [super init])) {
        self.title = @"Objective-C Playground";
        self.contentDescription = @"Alternatively, start here.";
        self.type = @"com.pspdfkit.catalog.objc-playground";
        self.category = PSCExampleCategoryTop;
        self.priority = 2;
    }
    return self;
}

- (nullable UIViewController *)invokeWithDelegate:(id<PSCExampleRunnerDelegate>)delegate {
    // Playground is convenient for testing.
    PSPDFDocument *document = [PSCAssetLoader writableDocumentWithName:PSCAssetNameQuickStart overrideIfExists:NO];

    PSPDFConfiguration *configuration = [PSPDFConfiguration configurationWithBuilder:^(PSPDFConfigurationBuilder *builder) {
        // Use the configuration to set main PSPDFKit options.
        builder.signatureStore = [[PSPDFKeychainSignatureStore alloc] init];
    }];

    PSPDFViewController *controller = [[PSCAdaptivePDFViewController alloc] initWithDocument:document configuration:configuration];
    return controller;
}

@end
