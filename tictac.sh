#!/bin/bash -x
echo "***************TicTacToe Program***************"

declare -A tictac

rows=3
columns=3

function reset()
{
	for (( i=1; i<=$rows; i++ ))
	do
		for (( j=1; j<=$columns; j++ ))
		do
			tictac[$i,$j]="*"
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

boardSee
