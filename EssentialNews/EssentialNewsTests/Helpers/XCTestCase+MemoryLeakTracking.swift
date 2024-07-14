//
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialNewsTests
//
//  Created by Fenominall on 7/6/24.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(
        _ instance: AnyObject,
        file: StaticString = #filePath,
        line: UInt = #line) {
            addTeardownBlock { [weak instance] in
                XCTAssertNil(
                    instance, "Instance should have been deallocated. Potenially memory leak",
                    file: file,
                    line: line)
            }
        }
}

