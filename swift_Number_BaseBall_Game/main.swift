var game = BaseballGame()
//game.start()
game.startScreen()



struct BaseballGame {
    var gameSuccess: Int = 0
    var gameCounter: Int = 0
    var gameSuccesLog: [Int] = []
    var gameCounterLog: [Int] = []
    
    
    mutating func startScreen() {
        var isCorrect = false
        
        while !isCorrect {
            print("환영합니다! 원하시는 번호를 입력해주세요")
            print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
            
            var input = readLine()!
        
            if input.allSatisfy({ $0.isNumber }) {
                // 입력된 값이 숫자로 구성되어 있는지 검증
                let inputAns = input.map { Int(String($0))! }
                // 입력된 값을 Int를 받는 배열로 mapping
                
                if inputAns.count == 1 && ( inputAns.contains(1) || inputAns.contains(2) || inputAns.contains(3) ) {
                // 보기에서 1 ~ 3 만 입력받기 위한 조건
                    if inputAns[0] == 1 {
                        start()
                    } // 선택지 1번 선택시 -> start() 실행
                    
                    else if inputAns[0] == 2 {
                        gameSuccesLog.append(gameSuccess)
                        
                        if !gameCounterLog.isEmpty || !gameCounterLog.isEmpty {
                        // ⚠️ 게임 기록이 없어 각각의 Log를 저장하는 배열이 비었을때, i에 해당하는 인덱스를 검색하면 에러 발생
                            for i in 0..<gameSuccesLog.count {
                                print("\(i+1)번째 게임 : 시도 횟수 - \(gameCounterLog[i])")
                            }
                        }// 따라서 공백 여부 확인하고 Game Log 출력
                        else {
                            print("Game 기록이 없습니다...")
                        }
                    } // 선택지 2번 선택시 -> 전역변수 gameCounterLog과 gameCounter를 활용한 게임 기록 출력
                    
                    else if inputAns[0] == 3 {
                        // case가 아닌 if를 사용하였기에, 가독성이 떨어져 구분하기 편하게 else가 아닌 else if를 사용
                        print("< 숫자 야구 게임을 종료합니다 >")
                        
                        gameSuccesLog = []
                        gameCounterLog = []
                        
                        break
                    } // 선택지 2번 선택시 -> Game 종료 및 기록 초기화
                }
                else {
                    print("올바르지 않은 입력값입니다 - 보기의 숫자만 입력해주세요( 1 ~ 3 )")
                }
            }
            else {
                print("올바르지 않은 입력값입니다 - 숫자만 입력해주세요")
            }
        }
        
        isCorrect = true
        // Level 6에서 Game 종료 기능 구현
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
                
                gameSuccess += 1
                gameCounter += 1
                gameCounterLog.append(gameCounter)
                // Game이 정답으로 끝나면, 기록중이던 gameCounter를 gameCounterLog 배열에 저장
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
        // 입력된 값이 숫자로 구성되어 있는지 검증
            let inputAns = input.map { Int(String($0))! }
            // 입력받은 input을 String -> [Int]로 변환
            
            if inputAns.count < 3 || inputAns.count > 3 {
                print("올바르지 않은 입력값입니다 - 3가지 숫자를 입력해주세요")
            } // 입력받은 수가 총 3 자리가 맞는지 검증
            else if inputAns[0] == inputAns[1] || inputAns[1] == inputAns[2] || inputAns[0] == inputAns[2]{
                print("올바르지 않은 입력값입니다 - 서로 다른 숫자를 입력해주세요")
            } // 입력받은 수에서 중복되는 수가 있는 경우 검증
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
            if inputArr.count == 3 && inputArr != [0,0,0] {
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
        
        if inputArr.count == 3 && inputArr != [0,0,0] {
            if warningCounter != 3 {
                print("Balls: \(ballCounter), Strikes: \(strikeCounter)")
            }
            else {
                print("Nothing")
            }
        } // 입력값과 정답을 비교하여 하나도 일치하지 않을 경우, "Nothing" 출력
        
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
