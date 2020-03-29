local playerFile = require('player')

-- Random configuration
math.randomseed(os.time())
math.random() -- Make a first random because it always the same number

function Game()
    -- Create players
    Player1 = CreatePlayer("1")
    Player2 = CreatePlayer("2")
    local balancer = true

    -- Game loop
    while Player1.hp > 0 and Player2.hp > 0 do
        print()
        print("Next round!")

        -- Make a turn
        if balancer then
            PlayerTurn(Player1)
            PlayerTurn(Player2)
        else
            PlayerTurn(Player2)
            PlayerTurn(Player1)
        end
        balancer = not balancer

        print()
        -- Make a hide action
        if Player1.action == "hide" then
            print(Player1.name.." is hidding...")
        end
        if Player2.action == "hide" then
            print(Player2.name.." is hidding...")
        end

        -- Make an attack action
        if Player1.action == "attack" then
            print()
            PerformAttackAction(Player1, Player2)
        end
        if Player2.action == "attack" then
            print()
            PerformAttackAction(Player2, Player1)
        end

        print()
        print("Round result:")
        print(Player1.name..": "..Player1.hp.." hp")
        print(Player2.name..": "..Player2.hp.." hp")
    end

    print()
    print("Game over")
    if Player1.hp > 0 then
        print(Player1.name.." has won!")
    elseif Player2.hp > 0 then
        print(Player2.name.." has won!")
    else
        print("Dead heat!")
    end
end

function CreatePlayer(playerNumber)
    print("Player"..playerNumber..", give your cowboy a name ->")
    local playerName = io.read()
    return Player:new(playerName)
end

function PlayerTurn(player)
    print(player.name..", your turn!")
    print("What are you going to do? (1: attack / 2: hide)")
    
    while true do
        local playerAction = io.read()
        if playerAction == "1" or playerAction == "attack" then
            player.action = "attack"
            break
        elseif playerAction == "2" or playerAction == "hide" then
            player.action = "hide"
            break
        else
            print("Wrong action. Type again ->")
        end
    end
end

function PerformAttackAction(player, targetPlayer)
    print(player.name.." makes a shot...")

    -- Calculate damage probability
    local damageProbability = 0.8
    if targetPlayer.action == "hide" then
        damageProbability = 0.25
    end

    -- Check damage
    local rand = math.random()
    --print(rand)
    if rand < damageProbability then
        print(targetPlayer.name.." was shooted!")
        targetPlayer.hp = targetPlayer.hp - 25
    else
        print("Miss.")
    end
end

-- Start Game
Game()