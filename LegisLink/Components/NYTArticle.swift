//
//  NYTArticle.swift
//  LegisLink
//
//  Created by Mason Cochran on 3/25/24.
//

import Foundation



import SwiftUI

struct NYTArticle: View {
    let article: Doc
    
    var body: some View {
        ScrollView {
            VStack (alignment: .center, spacing: 5) {
                Text("\(article.headline.main)")
                    .font(.headline)
                    .padding(.bottom, 4)
                
                Text("\(article.byline.original!)")
                    .font(.caption)
                    .padding(.bottom, 4)
                                
                Text("\(article.snippet)")
                    .font(.subheadline)
                    .padding(.bottom, 4)
                                               
                
                if (!article.multimedia.isEmpty) {
                    AsyncImage(url: URL(string: "https://www.nytimes.com/\(article.multimedia[0].url)"))
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 350, height: 350)
                        .clipped()
                } else {
                    Image(systemName: "questionmark.diamond")
                        .imageScale(.large)
                        .frame(width: 300, height: 300)
                }
                
                
                
                
                    
                Text("\(article.leadParagraph)")
                    .font(.body)
                    .padding(.bottom, 4)
                                
                
                let linkOne = article.webURL
                let initLinkOne = "[\("Read more")](\(linkOne))"
                Text(.init(initLinkOne))
                    .font(.caption)
                    .padding(.bottom, 4)
                
                
                Text("\(article.source.rawValue)")
                    .font(.caption)
                    .padding(.bottom, 4)

                    
            }
        }
    }
}


