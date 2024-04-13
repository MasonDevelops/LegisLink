//
//  NYTFeedView.swift
//  LegisLink
//
//  Created by Mason Cochran on 3/25/24.
//

import Foundation


import SwiftUI

struct NYTFeedView: View {
    let user: User
    @ObservedObject private var nytfvm: NYTFeedViewModel
    let newYorkTimesService = NewYorkTimesService()
    
    init(user: User) {
        self.user = user
        self.nytfvm = NYTFeedViewModel(nytService: newYorkTimesService)
    }
    
    
    var body: some View {
        VStack {
            Text("Congressional News - New York Times")
                .font(.headline)
                .padding(.bottom, 4)
            
            
                        
            List {
                Section {
                    ForEach(nytfvm.articles, id: \.self) { currentArticle in
                        NavigationLink(destination: NYTArticle(article: currentArticle)) {
                            VStack {
                                
                                Text(currentArticle.headline.main)

                                
                                
                                if (!currentArticle.multimedia.isEmpty) {
                                    AsyncImage(url: URL(string: createImageURL(givenURL: currentArticle.multimedia[0].url))) { phase in
                                        if let image = phase.image {
                                            image
                                                .scaledToFit()
                                                .frame(width: 300, height: 300)
                                                .clipped()

                                        } else if phase.error != nil {
                                            Image(systemName: "questionmark.diamond")
                                                .imageScale(.large)
                                                .frame(width: 300, height: 300)
                                       }
                                    }
                                } else {
                                    Image(systemName: "questionmark.diamond")
                                        .imageScale(.large)
                                        .frame(width: 300, height: 300)
                                }
                                

                            }
                        }
            
                    }   .listRowSeparatorTint(.green, edges: .all)
                        .alignmentGuide(.listRowSeparatorLeading) { _ in
                                        0
                                    }
                } 
                header: {
                    Text("Over the past 24 hours")
                }
            }

        }
        .background(Color.mint.edgesIgnoringSafeArea(.all))
    }
}

func createImageURL(givenURL: String) -> String {
    let imgURL = "https://www.nytimes.com/" + givenURL
    return imgURL
}

