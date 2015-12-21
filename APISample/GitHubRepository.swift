//
//  GitHubRepository.swift
//  APISample
//
//  Created by shinichiro.todaka on 2015/12/18.
//
//

import ObjectMapper

class GitHubRepository: Mappable {
    var fullName: String?
    var ownerAvaterUrl: String?
    var updatedAt: String?
    var url: String?

    static func buildWithArray(repositories: [[String: AnyObject]]) -> [GitHubRepository] {
        var arr: [GitHubRepository] = []
        for repositoryDict in repositories {
            if let repository = Mapper<GitHubRepository>().map(repositoryDict) {
                arr.append(repository)
            }
        }
        return arr
    }
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        fullName       <- map["full_name"]
        ownerAvaterUrl <- map["owner.avatar_url"]
        updatedAt      <- map["updated_at"]
        url            <- map["url"]
    }
}