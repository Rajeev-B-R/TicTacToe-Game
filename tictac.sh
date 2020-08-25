#!/bin/bash -x
echo "***************TicTacToe Program***************"

declare -A tictac

count=1
rows=3
columns=3

function reset()
{
	for (( i=1; i<=$rows; i++ ))
	do
		for (( j=1; j<=$columns; j++ ))
		do
			tictac[$i,$j]="-"
		done
	done
}

reset

function letter()
{
	letterCheck=$((RANDOM%2))
	if [[ $letterCheck -eq 0 ]]
	then
		move="O"
	else
		move="X"
	fi
	echo $move
}
letter

function toss()
{
	tossCheck=$((RANDOM%2))
	if [[ $tossCheck -eq 0 ]]
	then
		echo "Player1 wins toss!"
    	player1=$(letter)
	else
		echo "Player2 wins toss!"
    	player2=$(letter)    
	fi
}

toss

function boardSee()
{
	echo -e "----------------"
	for (( i=1; i<=rows; i++ ))
	do
		for (( j=1; j<=columns+1; j++ ))
		do
			echo -e "|| ${tictac[$i,$j]} \c"
		done
   	echo -e "\n----------------"
	done
}

function chngePlayer()
{
	if [[ $1 == "X" ]]
	then
		currPlayer="O"
	else
		currPlayer="X"
	fi
}

function winCheck()
{
	match3=0
	match4=0
	for (( i=1; i<=3; i++ ))
	do
		match1=0
		match2=0

		for (( j=1; j<=3; j++ ))
		do
			if [[ ${board[$i,$j]} == $1 ]]
			then
				match1=$((match1+1))
			fi
		done

		for (( k=1; k<=3; k++ ))
		do
			if [[ ${board[$k,$i]} == $1 ]]
			then
				match2=$((match2+1))
			fi
		done

		if [[ ${board[$i,$i]} == $1 ]]
		then
			match3=$((match3+1))
		fi

		for (( y=1; y<=3; y++ ))
		do
			add=$((i+y))
			if [[ $add == 4 && ${board[$i,$y]} == $1 ]]
			then
				match4=$((match4+1))
			fi
		done
	
  if [[ $match1 == 3 || $match2 == 3 || $match3 == 3 || $match4 == 3 ]]
	then
		echo "$1 wins!"
		exit
	elif [[ $count == 9 ]]
	then
		echo "A Tie!"
	fi
	done
	count=$((count+1))
}

function game()
{
	row1=$1
	column1=$2
	if [[ ${tictac[$row1,$column1]} == "-" ]]
	then
		tictac[$row1,$column1]=$currPlayer
		boardSee
		winCheck $currPlayer
		chngePlayer $currPlayer
	else
		echo "No such place"
	fi
}

function computerPlay()
{
        block=0
        for (( m=1; m<=$rows; m++ ))
        do
                for (( n=1; n<=$columns; n++ ))
                do
                        if [[ ${tictac[$m,$n]} == "-" ]]
                        then
                                tictac[$m,$n]=$1
                                winCheck $1
                                if [[ $win == 0 ]]
                                then
                                        tictac[$m,$n]="-"
                                elif [[ $win == 1 && ${tictac[$m,$n]} == $currPlayer ]]
                                then
                                        boardSee
                                        echo "$currPlayer wins!"
				        exit
                                elif [[ $win == 1 ]]
                                then
                                        tictac[$m,$n]=$currPlayer
                                        boardSee
                                        win=0
                                        block=1
                                        count=$((count+1))
                                        break
                                fi
                        fi
                done
                if [[ $block == 1 ]]
                then
                        break
                fi
        done
}

reset
toss
boardSee
while [[ $count -le 9 ]]
do
	if [[ $currPlayer == "X" ]]
	then
		read -p "Enter row index: " rowPos
		read -p "Enter column index: " columnPos
		game $rowPos $columnPos
	else
		read -p "Enter row index: " rowPos
		read -p "Enter column index: " columnPos
		game $rowPos $columnPos
    		computerPlay $nextPlayer
    		if [[ $block == 0 ]]
    		then
      			rowPos=$((RANDOM % 3 + 1))
      			columnPos=$((RANDOM % 3 + 1))
      			game $rowPos $columnPos
		else
      			chngePlayer $currPlayer
    		fi
	fi
done
if [[ $win == 0 ]]
then
        echo "A tie!"
fi
