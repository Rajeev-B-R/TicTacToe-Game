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
