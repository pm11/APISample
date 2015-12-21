//
//  GitHubRepositoryAPI.swift
//  APISample
//
//  Created by shinichiro.todaka on 2015/12/18.
//
//

import Foundation
import APIKit

protocol GitHubRequestType: RequestType {
}

extension GitHubRequestType {
    var baseURL: NSURL {
        return NSURL(string: "https://api.github.com")!
    }
}

struct FetchRepositoryRequest: GitHubRequestType {
    typealias Response = [GitHubRepository]
    
    var method: HTTPMethod {
        return .GET
    }
    
    var userName: String
    var path: String {
        return String(format: "/users/%@/repos", self.userName)
    }
    
    init(userName: String) {
        self.userName = userName
    }
    
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        guard let dictionary = object as? [[String: AnyObject]] else {
            return nil
        }
        
        guard let repos: [GitHubRepository] = GitHubRepository.buildWithArray(dictionary) else {
            return nil
        }
        return repos
    }
}