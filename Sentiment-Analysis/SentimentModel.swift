import Foundation

struct SentimentModel {
    enum Sentiment: String {
        case irrelevant
        case negative
        case neutral
        case positive
        case basic
    }
    
    func getEmoji(sentiment: Sentiment) -> String {
        switch sentiment {
            case .irrelevant: return "🧐"
            case .negative: return "😡"
            case .neutral: return "🙃"
            case .positive: return "😝"
            case .basic: return " "
        }
    }
    
    func predictString(text: String) -> Sentiment {
        if text == "" || text == " " || text == "\n" {
            return .basic
        }
        let model = SentimentAnalysisModel()
        guard let textSentimentAnalysisOutput = try? model.prediction(text: text) else{
            fatalError("Loading CoreML Model Failed")
        }
        switch (textSentimentAnalysisOutput.label) {
            case "Irrelevant": return .irrelevant
            case "Negative": return .negative
            case "Neutral": return .neutral
            case "Positive": return .positive
            default: return .basic
        }
    }
    
}
