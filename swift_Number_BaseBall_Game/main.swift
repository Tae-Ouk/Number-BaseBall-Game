let game = BaseballGame()
game.start()



struct BaseballGame {
    func start() {
        let answer = makeAnswer()
        var isCorrect = false
        
        print("Number BaseBall Game 시작!")
        print("숫자를 입력하세요.")
        
        print(answer)
        
        while !isCorrect {
            var IntAns = valueInput()
            
            
            if valueComparison(answer, IntAns) {
                print("정답!")
                isCorrect = true
            } else {
                print("틀렸습니다... 다시 시도해주세요")
            }
        }
        
        
    }
    
    
    
    func valueInput() -> [Int] {
        var input = readLine()!
        if input.allSatisfy({ $0.isNumber }) {
        // 입력된 값이 숫자로 구성되어 있는지 검증
            let inputAns = input.map { Int(String($0))! }
            // 입력받은 input을 String -> [Int]로 변환
            
            if inputAns.count < 3 || inputAns.count > 3 {
                print("올바르지 않은 입력값입니다 - 3가지 숫자를 입력해주세요")
            } // 입력받은 수가 총 3 자리가 맞는지 검증
            else if inputAns[0] == inputAns[1] || inputAns[1] == inputAns[2] || inputAns[0] == inputAns[2]{
                print("올바르지 않은 입력값입니다 - 서로 다른 숫자를 입력해주세요")
            } // 입력받은 수에서 중복되는 수가 있는 경우 검증
            else if inputAns.contains(0) {
                print("올바르지 않은 입력값입니다 - 0이 아닌 숫자를 입력해주세요")
            } // 입력받은 수에서 0이 있는 경우 검증
            return inputAns
        }
        else {
            print("올바르지 않은 입력값입니다 - 숫자만 입력해주세요")
            
            return [0,0,0]
        }
        // 숫자로 변환할 수 없는 입력에 대한 에러 처리
    }
    
    
    
    func valueComparison(_ valArr: [Int], _ inputArr: [Int]) -> Bool {
        var ballCounter: Int = 0
        var strikeCounter: Int = 0
        var warningCounter: Int = 0
        
        for i in 0..<valArr.count {
            if inputArr.count == 3 && inputArr != [0,0,0] && !inputArr.contains(0) {
            // 에러 요소가 발생시, 카운터 동작 정지 - 3자리 미만 또는 이상, 문자 입력시([0,0,0]), 0을 포함
                if valArr[i] == inputArr[i] {
                    strikeCounter += 1
                }
                else if valArr.contains(inputArr[i]) {
                    ballCounter += 1
                }
                else if !valArr.contains(inputArr[i]) {
                    warningCounter += 1
                }
            }
        } // ball & strike 구분 + 일치하는 값이 없을 때, Nothing을 출력하기 위한 경고 신호 발생
        
        if inputArr.count == 3 && inputArr != [0,0,0] && !inputArr.contains(0) {
            if warningCounter != 3 {
                print("Balls: \(ballCounter), Strikes: \(strikeCounter)")
            }
            else {
                print("Nothing")
            }
        } // 입력값과 정답을 비교하여 하나도 일치하지 않을 경우, "Nothing" 출력
        
        // warningCounter != 3 ? print("Balls: \(ballCounter), Strikes: \(strikeCounter)") : print("Nothing")
        
        warningCounter = 0
        // 경고 초기화
                
        return strikeCounter == 3
    }
    
    
    
    func makeAnswer() -> [Int] {
        let ansMake = Array(0...9)
        var randomVal: [Int] = []

        while randomVal.count < 3 {
            let randomIndex = Int.random(in: 0..<ansMake.count)
            let randomNum = ansMake[randomIndex]
            
            if !randomVal.contains(randomNum) {
                if randomVal.isEmpty {
                // ⚠️ 맨 처음 배열은 공백이기에 0번째 인덱스로 접근하면 에러 발생
                    randomVal.append(Int.random(in: 1...9))
                } // 0번째 인덱스에는 1에서 9까지의 랜덤한 값 추가
                else {
                    randomVal.append(randomNum)
                } // 나머지 인덱스에는 ansMake 배열에서 선택된 값 추가
            } // randomValues에 있는 값이 중복되지 않도록, 없는 값만 배열에 추가
        }
        
        return randomVal
    }
}
