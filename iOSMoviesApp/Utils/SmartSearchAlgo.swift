//
//  SmartSearchAlgo.swift
//  iOSMoviesApp
//
//  Created by Yash Agrawal on 23/07/25.
//

struct SmartSearchAlgo {
    private(set) var searchTokens: [Substring]
    public init(searchText: String) {
        self.searchTokens = searchText.split(whereSeparator : {$0.isWhitespace}).sorted{$0.count < $1.count}
    }
    func isMatch(_ movieTitle: String) -> Bool {
        guard !searchTokens.isEmpty else {
            return true
        }
        
        var movieTitleTokens: [Substring] = movieTitle.split(whereSeparator : {$0.isWhitespace})
        for searchToken in searchTokens {
            var matchedSearchToken : Bool = false
            for (titleIndex, movieTitleToken) in movieTitleTokens.enumerated() {
                if let range = movieTitleToken.range(of: searchToken, options: [.caseInsensitive, .diacriticInsensitive]), range.lowerBound == movieTitleToken.startIndex {
                    matchedSearchToken = true
                    movieTitleTokens.remove(at: titleIndex)
                    break
                }
            }
            guard matchedSearchToken else {
                return false
            }
        }
        return true
    }
}
