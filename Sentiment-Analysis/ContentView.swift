//
//  ContentView.swift
//  Sentiment-Analysis
//
//  Created by 이수민 on 2023/03/15.
//

import SwiftUI
import CoreML

// 다른 부분 탭 했을 때 키보드 가리기
extension UIApplication {
         func hideKeyboard() {
                  guard let window = windows.first else {return}
                  let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
                  tapRecognizer.cancelsTouchesInView = false
                  tapRecognizer.delegate = self
                  window.addGestureRecognizer(tapRecognizer)
         }
}

extension UIApplication: UIGestureRecognizerDelegate {
         public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
                  return false
         }
}


struct ContentView: View {
         @State var sentimentModel = SentimentModel()
         @State private var targetText: String = ""
         @State private var sentiment: SentimentModel.Sentiment = .basic
         @State private var basicColor: String = "basic"
         var body: some View {
                  ZStack{
                           Color(sentiment.rawValue).edgesIgnoringSafeArea(.all)
                           VStack {
                                    TextEditor(text: $targetText)
                                             .cornerRadius(20)
                                             .colorMultiply(.white)
                                             .font(.title)
                                             .lineLimit(10)
                                             .multilineTextAlignment(.leading)
                                             .lineSpacing(20)
                                             .padding(.horizontal, 30)
                                             .padding(.bottom, 50)
                                    Spacer()
                                    Button {
                                             sentiment = sentimentModel.predictString(text: targetText)
                                    } label: {
                                             Text("Predict").font(.title2).padding()
                                             
                                    }
                                    Text(sentimentModel.getEmoji(sentiment: sentiment))
                                             .font(.system(size: 100))
                                    Text(sentiment.rawValue != "basic" ? sentiment.rawValue : " ")
                                    
                           }
                           .onAppear(perform: UIApplication.shared.hideKeyboard)
                           .padding()
                  }
         }
}

struct ContentView_Previews: PreviewProvider {
         static var previews: some View {
                  ContentView()
         }
}
