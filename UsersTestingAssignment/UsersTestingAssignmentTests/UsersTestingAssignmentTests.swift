//
//  UsersTestingAssignmentTests.swift
//  UsersTestingAssignmentTests
//
//  Created by Beka on 18.11.24.
//

import XCTest
@testable import UsersTestingAssignment

class TestUserViewModel: XCTestCase {
    
    var user: User!
    var viewModel: UserViewModel!

    override func setUp() {
        super.setUp()
        
        user = User(
            gender: "male",
            name: Name(title: "Mr", first: "John", last: "Doe"),
            email: "john.doe@example.com",
            picture: Picture(large: "https://example.com/large.jpg",
                             medium: "https://example.com/medium.jpg",
                             thumbnail: "https://example.com/thumbnail.jpg"),
            nat: "US",
            cell: "123456789",
            phone: "987654321"
        )
        
        viewModel = UserViewModel(user: user)
    }
    
    override func tearDown() {
        user = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFullName_WithValidInput_ReturnsCorrectFullName() {
        XCTAssertEqual(viewModel.fullName, "Mr John Doe")
    }
    
    func testFullName_WithEmptyNameParts_ReturnsEmptyString() {
        user = User(
            gender: "female",
            name: Name(title: "", first: "", last: ""),
            email: "jane.doe@example.com",
            picture: Picture(large: "", medium: "", thumbnail: ""),
            nat: "CA",
            cell: "",
            phone: ""
        )
        viewModel = UserViewModel(user: user)
        
        XCTAssertEqual(viewModel.fullName, "")
    }
    
    func testContactNumber_WithValidInputs_ReturnsFormattedContactNumber() {
        XCTAssertEqual(viewModel.contactNumber, "123456789 / 987654321")
    }
    
    func testContactNumber_WithOneEmptyNumber_ReturnsSingleNumber() {
        user = User(
            gender: "male",
            name: Name(title: "Mr", first: "John", last: "Doe"),
            email: "john.doe@example.com",
            picture: Picture(large: "https://example.com/large.jpg",
                             medium: "https://example.com/medium.jpg",
                             thumbnail: "https://example.com/thumbnail.jpg"),
            nat: "US",
            cell: "123456789",
            phone: ""
        )
        viewModel = UserViewModel(user: user)
        
        XCTAssertEqual(viewModel.contactNumber, "123456789 /")
    }
    
    func testContactNumber_WithBothNumbersEmpty_ReturnsEmptyString() {
        user = User(
            gender: "female",
            name: Name(title: "", first: "", last: ""),
            email: "jane.doe@example.com",
            picture: Picture(large: "", medium: "", thumbnail: ""),
            nat: "CA",
            cell: "",
            phone: ""
        )
        viewModel = UserViewModel(user: user)
        
        XCTAssertEqual(viewModel.contactNumber, "/")
    }
    
    func testThumbnailImageUrl_WithValidUrl_ReturnsUrlObject() {
        XCTAssertEqual(viewModel.thumbnailImageUrl, URL(string: "https://example.com/thumbnail.jpg"))
    }
    
    func testThumbnailImageUrl_WithInvalidUrl_ReturnsNil() {
        user = User(
            gender: "male",
            name: Name(title: "Mr", first: "John", last: "Doe"),
            email: "john.doe@example.com",
            picture: Picture(large: "https://example.com/large.jpg",
                             medium: "https://example.com/medium.jpg",
                             thumbnail: ""),
            nat: "US",
            cell: "123456789",
            phone: "987654321"
        )
        viewModel = UserViewModel(user: user)
        
        XCTAssertNil(viewModel.thumbnailImageUrl)
    }
    
    func testEmail_ReturnsCorrectEmail() {
        XCTAssertEqual(viewModel.email, "john.doe@example.com")
    }
}

final class NetworkManager: NSObject {
    
    override init() {
        super.init()
    }

    func fetchUsers(mockData: Data, completionHandler: @escaping ([User]) -> Void) {
        do {
            let userList = try JSONDecoder().decode(UserList.self, from: mockData)
            completionHandler(userList.results)
        } catch {
            print("Failed to decode data: (error)")
            completionHandler([])
        }
    }
}

final class TestNetworkManager: XCTestCase {

    var networkManager: NetworkManager!

    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
    }

    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }

    func testFetchUsers_WithValidMockData_ReturnsUsers() {
        let mockData = User.jsonMock.data(using: .utf8)!
        let expectation = self.expectation(description: "Users fetched with valid mock data")

        networkManager.fetchUsers(mockData: mockData) { users in
            XCTAssertEqual(users.count, 1)
            XCTAssertEqual(users.first?.name.first, "Christian")
            XCTAssertEqual(users.first?.email, "christian.nielsen@example.com")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchUsers_WithInvalidMockData_ReturnsEmpty() {
        let invalidData = "{ invalid: json }".data(using: .utf8)!
        let expectation = self.expectation(description: "Users fetched with invalid mock data")
        networkManager.fetchUsers(mockData: invalidData) { users in
            XCTAssertEqual(users.count, 0)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
