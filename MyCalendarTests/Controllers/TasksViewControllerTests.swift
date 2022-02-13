//
//  TasksViewControllerTests.swift
//  MyCalendarTests
//
//  Created by Татьяна Мальчик on 11.02.2022.
//

import XCTest
@testable import MyCalendar

class TasksViewControllerTests: XCTestCase {
    
    let sut = TasksViewController()

    override func setUpWithError() throws {
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWhenViewIsLoadedTableViewNotNil() {
        XCTAssertNotNil(sut.tasksTableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(sut.tasksTableView.delegate)
    }
    
    func testTableViewHasDataSourse() {
        XCTAssertNotNil(sut.tasksTableView.dataSource)
    }
    
    func testWhenViewIsLoadedCalendarIsNotNil() {
        XCTAssertNotNil(sut.myCalendar)
    }
    
    func testCalendarHasDelegate() {
        XCTAssertNotNil(sut.myCalendar.delegate)
    }
    
    func testCalendarHasDataSourse() {
        XCTAssertNotNil(sut.myCalendar.dataSource)
    }
}
