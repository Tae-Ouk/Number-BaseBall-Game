var game = BaseballGame()
game.startScreen()



struct BaseballGame {
    var gameCounter: Int = 0
    var gameCounterLog: [Int] = []
    // 전역변수 gameCounterLog를 활용한 게임 기록 저장
    
    mutating func startScreen() {
        var isCorrect = false
        
        while !isCorrect {
            print("환영합니다! 원하시는 번호를 입력해주세요")
            print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
            
            var input = readLine()!
        
            if input.allSatisfy({ $0.isNumber }) {
                let inputAns = input.map { Int(String($0))! }
                
                if inputAns.count == 1 && ( inputAns.contains(1) || inputAns.contains(2) || inputAns.contains(3) ) {
                    switch inputAns[0] {
                    case 1:
                        start()
                    case 2:
                        if !gameCounterLog.isEmpty {
                            for i in 0..<gameCounterLog.count {
                                print("\(i+1)번째 게임 : 시도 횟수 - \(gameCounterLog[i])")
                            }
                        }
                        else {
                            print("Game 기록이 없습니다...")
                        }
                    default:
                        print("< 숫자 야구 게임을 종료합니다 >")
                        
                        gameCounterLog = []
                        
                        isCorrect = true
                    } // case 3
                }
                else {
                    print("올바르지 않은 입력입니다.")
                }
            }
            else {
                print("올바르지 않은 입력값입니다 - 숫자만 입력해주세요")
            }
        }
        
        isCorrect = true
    }
    
    
    
    mutating func start() {
        let answer = makeAnswer()
        var isCorrect = false
        var gameCounter: Int = 0
        
        print("Number BaseBall Game 시작!")
        print("숫자를 입력하세요.")
        print(answer)
        
        while !isCorrect {
            var IntAns = valueInput()

            if valueComparison(answer, IntAns) {
                print("정답!")
                
                isCorrect = true
                
                gameCounter += 1
                gameCounterLog.append(gameCounter)
            }
            else {
                print("틀렸습니다... 다시 시도해주세요")
                
                gameCounter += 1
            }
        }
    }
    
    
    
    func valueInput() -> [Int] {
        var input = readLine()!
        if input.allSatisfy({ $0.isNumber }) {
            let inputAns = input.map { Int(String($0))! }
            
            if inputAns.count != 3 {
                print("올바르지 않은 입력값입니다 - 3가지 숫자를 입력해주세요")
            }
            else if inputAns[0] == inputAns[1] || inputAns[1] == inputAns[2] || inputAns[0] == inputAns[2]{
                print("올바르지 않은 입력값입니다 - 서로 다른 숫자를 입력해주세요")
            }
            
            return inputAns
        }
        else {
            print("올바르지 않은 입력값입니다 - 숫자만 입력해주세요")
            
            return [0,0,0]
            // [Int]을 반환해야 하기에, 오류가 발생하지 않는 [0,0,0] 더미 값을 전송
        }
    }
    
    
    
    func valueComparison(_ valArr: [Int], _ inputArr: [Int]) -> Bool {
        var ballCounter: Int = 0
        var strikeCounter: Int = 0
        var warningCounter: Int = 0
        
        for i in 0..<valArr.count {
            if inputArr.count == 3 && inputArr != [0,0,0] {
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
        }
        
        if inputArr.count == 3 && inputArr != [0,0,0] {
            warningCounter != 3 ? print("Balls: \(ballCounter), Strikes: \(strikeCounter)") : print("Nothing")
        }
        
        warningCounter = 0
                
        return strikeCounter == 3
    }
    
    
    
    func makeAnswer() -> [Int] {
        let ansMake = Array(0...9)
        var randomVal: [Int] = []

        while randomVal.count < 3 {
            let randomIndex = Int.random(in: 0..<ansMake.count)
            let randomNum = ansMake[randomIndex]
            
            if !randomVal.contains(randomNum) {
                randomVal.isEmpty ? randomVal.append(Int.random(in: 1...9)) : randomVal.append(randomNum)
            } // ⚠️ 맨 처음 배열은 공백이기에 0번째 인덱스로 접근하면 에러 발생
        }
        
        return randomVal
    }
}
