//
//  ContentView.swift
//  Sentiment-Analysis
//
//  Created by 이수민 on 2023/03/15.
//

import SwiftUI
import CoreML


struct ContentView: View {
         @State var targetText: String = ""
         @State var label: String = ""
         @State var sentimentDic: [String: Int] = ["Irrelevant" : 0,"Negative" : 0,"Neutral" : 0,"Positive" : 0]
         var body: some View {
                  VStack {
                           TextEditor( text: $targetText)
                                    .lineLimit(10)
                                    .multilineTextAlignment(.leading)
                                    .lineSpacing(20)
                           Button {
                                    label = predictSentiment(text: stringParsing(text: targetText))
                           } label: {
                                    Text("Predict")
                           }
                           
                           Text(label)
                           
                           
                           
                  }
                  .padding()
         }
         
         func stringParsing(text: String) -> [String] {
                  let stArray = text.split(separator: "\n")
                  print(stArray.map { $0.description })
                  return stArray.map { $0.description }
         }
         
         func predictSentiment(text: [String]) -> String{
                  sentimentDic = ["Irrelevant" : 0,"Negative" : 0,"Neutral" : 0,"Positive" : 0]
                  let model = SentimentAnalysisModel()
                  for t in text {
                           guard let textSentimentAnalysisOutput = try? model.prediction(text: t) else{
                                    fatalError("Loading CoreML Model Failed")
                           }
                           switch (textSentimentAnalysisOutput.label) {
                                    case "Irrelevant": sentimentDic["Irrelevant"]! += 1
                                    case "Negative": sentimentDic["Negative"]! += 1
                                    case "Neutral": sentimentDic["Neutral"]! += 1
                                    case "Positive": sentimentDic["Positive"]! += 1
                                    default: break
                           }
                           
                  }
                  print(sentimentDic)
                  
                  
                  return sentimentDic.sorted{$0.1>$1.1}[0].key
         }
}

struct ContentView_Previews: PreviewProvider {
         static var previews: some View {
                  ContentView()
         }
}
