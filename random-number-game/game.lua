-- Game configuration
PlayerAttempts = 3;
HiddenNumberUpperBound = 10;

-- Random configuration
math.randomseed(os.time())

function Game()
    HiddenNumber = ((math.random(HiddenNumberUpperBound) + math.random(HiddenNumberUpperBound)) % HiddenNumberUpperBound) + 1;
    print("Guess the number from 1 to ", HiddenNumberUpperBound, " in ", PlayerAttempts, " attempts")
    
    CurrentPlayerAttempt = 0;
    while CurrentPlayerAttempt < PlayerAttempts do
        CurrentPlayerAttempt = CurrentPlayerAttempt + 1
        
        print("Name your number -> ")
        local result = GameLoopIteration()

        if result then
            GameOver(true)
            return
        end
    end

    GameOver(false)
end

function GameLoopIteration()
    local playerNumber = tonumber(io.read())

    -- Player input is not a number
    if playerNumber == nil then
        print("Wrong input. Enter a number")
        return GameLoopIteration()
    end

    if playerNumber == HiddenNumber then
        -- Player guessed the number
        return true
    else
        -- Player failed attempt
        local msgTip = ""
        if (HiddenNumber > playerNumber) then
            msgTip = "Greater"
        else
            msgTip = "Less"
        end
        print(msgTip)
        return false
    end
end

function GameOver(playerWon)
    -- Print game over message
    if playerWon then
        local msgSuffix = " attempt"
        if CurrentPlayerAttempt > 1 then
            msgSuffix = msgSuffix .. "s"
        end
        print("Correct! You have won in ", CurrentPlayerAttempt, msgSuffix)
    else
        print("Oops, you have failed :(")
    end

    -- Ask to try again or exit
    while true do
        print("Do you want to try again? (y/n)")
        local answer = io.read()
        if answer == "y" then
            Game()
            return
        elseif answer == "n" then
            return
        end
    end
end

-- Start game
Game()