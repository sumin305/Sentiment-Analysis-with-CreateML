# Sentiment-Analysis-with-CreateML

## **CreateML**과 **CoreML API**를 활용한 감정 분석 어플 👩🏻‍💻
- CreateML을 이용하여 모델 생성
- Kaggle의 트위터 감성분석 데이터셋 활용

## 진행사항 📝
-   [ ] UI 개선
-   [x] 어플 구현


## 시현 영상 📱
https://user-images.githubusercontent.com/110437548/227858786-d022b296-a992-4f64-ac05-8a299ed2bca7.mp4

# 개요 🖊️

- CoreML & CreateML 을 iOS 개발자들에게 소개하기 위해 만든 토이 프로젝트
- Kaggle의 Twitter 감정 분석 데이터 활용
- CreateML로 모델 생성 (데이터 학습)
- CoreML API를 활용하여 앱에 모델 통합

# 개발 단계 🖥️

- 데이터 수집
- CreateML 인터페이스를 활용하여 모델 생성 및 학습
- CoreML로 앱에 적용

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

# 구현 기능 👾

- 문장 입력 시 모델에 입력하여 감정을 분류한다.
- 분류된 감정에 맞게 해당 이모티콘과 배경 색상이 변경된다.
