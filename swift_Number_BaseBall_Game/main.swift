let game = BaseballGame()
game.start()


struct BaseballGame {
    func start() {
        let answer = makeAnswer()
        
        
        print("Start Number BaseBall Game")
        print("Input Your Number")
        
        print(makeAnswer())
        
        let input = readLine()!
        
        let IntAnswer = String(input).map{ Int(String($0))! }
        // 입력받은 input을 String -> [Int]로 변환
        
        print(IntAnswer)
        
        
        
    }
    
    
    func makeAnswer() -> [Int] {
        var ansMake = Array(1...9)
        var randomValues: [Int] = []

        while randomValues.count < 3 {
            let randomIndex = Int.random(in: 0..<ansMake.count)
            let randomNumber = ansMake[randomIndex]
            
            if !randomValues.contains(randomNumber) {
                randomValues.append(randomNumber)
            }
        }
        
        /*
        var ansMake: [Int] = []
        
        for i in 0...2 {
            ansMake.append(Int.random(in: 1...9))
        }
         // ⚠️ 랜덤하게 추가된 ansMake의 요소 중 중복이 발생할 수 있음 -> ✅ 해결!
        */
        
        return randomValues
    }
}
