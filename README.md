# Sentiment-Analysis-with-CreateML

## **CreateML**과 **CoreML API**를 활용한 감정 분석 어플
### 1. 데이터 수집 및 전처리

![image](https://github.com/sumin305/Sentiment-Analysis-with-CreateML/assets/110437548/02b1749d-3111-4b45-a444-752929ec0b2c)
### 2. CreateML 인터페이스를 활용하여 모델 생성 및 학습

![image](https://github.com/sumin305/Sentiment-Analysis-with-CreateML/assets/110437548/9288bc7d-4842-446e-a290-998d717df028)

### 3. CoreML로 앱에 적용

```swift
//String 값을 받아와 Sentiment를 반환해주는 함수 작성
func predictString(text: String) -> Sentiment {
    if text == "" || text == " " || text == "\n" {
        return .basic
    }
    do {
        //coreML Model 불러오기
        let model = try SentimentAnalysisModel(configuration: MLModelConfiguration.init())
        
        //coreML API를 활용하여 text의 감정을 예측한 값 받아온다
        let textSentimentAnalysisOutput = try model.prediction(text: text)
        print("text: ",text)
        print("prediction: ",textSentimentAnalysisOutput.label)
        //예측한 값에 따른 반환값
        switch (textSentimentAnalysisOutput.label) {
            case "Irrelevant": return .irrelevant
            case "Negative": return .negative
            case "Neutral": return .neutral
            case "Positive": return .positive
            default: return .basic
        }
    }
    //예상치 못한 error를 막아준다
    catch {
        fatalError("Loading CoreML Model Failed")
    }
}
```

## 진행사항
-   [ ] UI 개선
-   [x] 어플 구현


## 시현 영상
https://user-images.githubusercontent.com/110437548/227858786-d022b296-a992-4f64-ac05-8a299ed2bca7.mp4

