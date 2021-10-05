#!/bin/bash

Dash="------------------------------------------------------------------------------------"
echo "                         -------------------------------"

function CE
{
    clear; echo
}

function Pause
{
	echo; read -p "Paused... Press ENTER."
}

function PrintVar
{
	echo; echo "Var1="$Var1" Var2="$Var2
}

function Dec2Bin
{
	Binary=
        local x=$1; local i

        for ((i=0; i<32; i++))
        do
                if ((x&1))
                then
                        Binary=" 1 "$Binary
                else
                        Binary=" 0 "$Binary
                fi
                ((x>>=1))
        done
}

function ArthLines
{
    CE; echo "We're performing $1 on two variables and then assigning the result"
    echo "to the variable that is on the left side of the equation. For example:"; echo
    echo "Variable1 = "$2" and Variable2 = "$3". When we "$4", we get "$5"."
    echo "We then assign "$5" to Variable1."
    echo; echo $Dash
}

function PrintNumberLine
{
	echo
	echo " *********************** 2 1"
	echo " * This number line    * 1 0 5 2 1"
	echo " * represents a 32-bit * 4 7 3 6 3 6 3 1" 
	echo " * number. The decimal * 7 3 6 8 4 7 3 6 8 4 2 1"
	echo " * value of a binary   * 4 7 8 4 2 1 5 7 3 1 0 0 5 2 1"
	echo " * number is derived   * 8 4 7 3 1 0 5 7 8 9 9 4 2 6 3 6 3 1"
	echo " * by adding the       * 3 1 0 5 7 8 4 7 8 4 7 8 4 2 1 5 2 6 8 4 2 1"
	echo " * column values where * 6 8 9 4 7 8 4 2 6 3 1 5 2 1 0 5 7 3 1 0 0 0 5 2 1"
	echo " * the 1s appear in    * 4 2 1 5 2 6 3 1 0 0 5 7 8 4 7 3 6 8 9 9 4 2 1 5 2 6 3 1"
	echo " * the binary number.  * 8 4 2 6 8 4 2 6 8 4 2 6 8 4 2 6 8 4 2 6 8 4 2 6 8 4 2 6 8 4 2 1"
	echo " *********************** ---------------------------------------------------------------"
}

function TryIt
{
	local V1=; local bin1=; local V2=; local bin2=; local i=1; local bin3=
	
	while :
	do
		clear; echo; echo "Try it for yourself ("$1")! Please enter two numbers."
		echo; echo "Use [ENTER] for either number to quit."; echo
		read -p " First number, placed into V1: " V1
		read -p "Second number, placed into V2: " V2
		
		if [[ $V1 && $V2 ]]
		then
			echo
			case $1 in
				addition) echo "Performing (("$V1"+="$V2"))"; ((V1+=V2)) ;;
				subtraction) echo "Performing (("$V1"-="$V2"))"; ((V1-=V2)) ;;
				multiplication) echo "Performing (("$V1"*="$V2"))"; ((V1*=V2)) ;;
				division) echo "Performing (("$V1"/="$V2"))"; ((V1/=V2)) ;;
				modulus) echo "Performing (("$V1"%="$V2"))"; ((V1%=V2)) ;;
				Rshift)					
					i=0; Dec2Bin $V1; bin1=$Binary
					echo "Shifting right by "$V2" (("$V1">>="$V2"))"
					((V1>>=V2))
				;;
				Lshift)
					i=0; Dec2Bin $V1; bin1=$Binary
                                        echo "Shifting left by "$V2" (("$V1"<<="$V2"))"
                                        ((V1<<=V2))
				;;
				ANDing | ORing | XORing)
					i=2; Dec2Bin $V1; bin1=$Binary; Dec2Bin $V2; bin2=$Binary
					case $1 in
						ANDing)
							echo "Operation: "$V1" AND "$V2
							((V1&=V2))
						;;
						ORing)
							echo "Operation: "$V1" OR "$V2
                                                        ((V1|=V2))
						;;
						XORing)
							echo "Operation: "$V1" XOR "$V2
                                                        ((V1^=V2))
						;;
					esac
			esac
			if [[ $i -eq 1 ]]
			then
				echo; printf "V1 now equals: %'d" $V1; echo
			elif [[ $i -eq 2 ]]
			then
				Dec2Bin $V1; bin3=$Binary
				PrintNumberLine
				echo "First number (binary) : "$bin1
				echo "Result number (binary): "$bin2
				echo "                         ---------------------------------------------------------------"
				echo "Result (binary)       : "$bin3
			        echo; printf "                        V1, in decimal, is: %'d" $V1
			else
				Dec2Bin $V1; bin2=$Binary
				PrintNumberLine
                                echo "Original binary value : "$bin1
                                echo "New binary value      : "$bin2
			        echo; printf "                        V1, in decimal, is: %'d" $V1
			fi
		else
			break
		fi

		Pause
	done
}

function Inc
{
	Var1=7; Var2=2

	ArthLines addition 2 3 add 5
	PrintVar
	echo "Incrementing (add) Var1 by Var2. ((Var1+=Var2)) : Var1 now equals "$((Var1+=Var2))
	Pause
	TryIt addition
}

function Dec
{
	Var1=7; Var2=2

	ArthLines subtraction 3 2 subtract 1
	PrintVar
	echo "Decrementing (subtract) Var1 by Var2. ((Var1-=Var2)) : Var1 now equals "$((Var1-=Var2))
	Pause
	TryIt subtraction
}

function Mul
{
	Var1=12; Var2=3

	ArthLines multiplication 3 2 multiply 6
	PrintVar
	echo "Multiplying Var1 and Var2. ((Var1*=Var2)) : Var1 now equals "$((Var1*=Var2))
	Pause
	TryIt multiplication
}

function Div
{
	Var1=12; Var2=3

	ArthLines division 100 25 divide 4
	PrintVar
	echo "Dividing Var1 by Var2. ((Var1/=Var2)) : Var1 now equals "$((Var1/=Var2))
	Pause
	TryIt division
}

function Mod
{
	Var1=12; Var2=5
    
	ArthLines 'a modular function' 3 2 'divide and take the remainder' 1
	PrintVar
	echo "Divide Var1 by Var2, put the remainder in Var1. ((Var1%=Var2)) : Var1 now equals "$((Var1%=Var2))
	Pause
	TryIt modulus
}

function BitLines
{
    CE; echo "Bit shifting: We will shift "$Var1" ("$Var2") bit(s) to the "$1" using the "$2" operator."
    echo; echo "When we bit shift, the computer is working with the binary equivalent of the"
    echo "numbers we have given it. There is also an assignment variant, "$3", that will place"
    echo "the the result of operation into the variable on the left side of the equation."; echo; echo $Dash
}

function BitResult
{
    echo; echo "What happened? To determine this, we need a number line and we need to convert the"
    echo "numbers "$Var1" to binary, and then shift the bits "$Var2" position(s) to the "$4"."; echo
    echo "                                 2 1"
    echo "                                 5 2 6 3 1"
    echo "Using a binary number line of  : 6 8 4 2 6 8 2 1"
    echo "                                 ---------------"
    echo $Var1" looks like this, in binary : "$1
    echo "Shifting 1 bit to the right    : "$2
    echo; echo "For the result, take the value of each 1 bit and add them together. This gives "$3"."
    echo; echo "In essence, for every bit we shift the to "$4", we are "$5" by a power of 2."
}

function BitFinal
{
    echo "Using the "$1" operator "$2" places "$Var1" into Var1."
}

function Rbit
{
    Var1=192; Var2=1

    BitLines right '>>' '>>='
    PrintVar; echo "Shift "$Var1" to the right by "$Var2" bit(s). ((Var1>>Var2)) : "$((Var1>>Var2))
    BitResult '0 1 1 0 0 0 0 0' '0 0 1 1 0 0 0 0' 96 right dividing
  
    Var2=3
    echo; echo "If we shift right by three bits, it would be (in math terms) 192/(2^3), which is 24."
    echo "Proof: (("$Var1">>"$Var2")) is: "$((Var1>>Var2)); echo
    echo "Using a binary number line of  : 256 128  64  32  16   8   4   2   1"
    echo "                                 -----------------------------------"
    echo "192 looks like this, in binary :   0   1   1   0   0   0   0   0   0"
    echo "Shifting 3 bit to the right    :   0   0   0   0   1   1   0   0   0"

    PrintVar; ((Var1>>=Var2)); BitFinal '>>=' '((192>>=3))'
    Pause
    TryIt Rshift
}

function Lbit
{
    Var1=109; Var2=1
    
    BitLines left '<<' '<<='
    PrintVar; echo "Shift "$Var1" to the left by "$Var2" bit(s). ((Var1<<Var2)) : "$((Var1<<Var2))
    BitResult '0 1 1 0 1 1 0 1' '1 1 0 1 1 0 1 0' 218 left multiplying
   
    Var2=4
    echo; echo "If we shift left by four bits, it would be (in math terms) 109*(2^4), which is 1744."
    echo "Proof: (("$Var1"<<"$Var2")) is: "$((Var1<<Var2)); echo
    echo "Using a binary number line of  : 1024 512 256 128  64  32  16   8   4   2   1"
    echo "                                 --------------------------------------------"
    echo "109 looks like this, in binary :    0   0   0   0   1   1   0   1   1   0   1"
    echo "Shifting 4 bit to the left     :    1   1   0   1   1   0   1   0   0   0   0"

    PrintVar; ((Var1<<=Var2)); BitFinal '<<=' '((109<<=4))'
    Pause
    TryIt Lshift
}

function BoolLines
{
    CE; echo; echo "Let's examine the "$1" Boolean operation. It is important to keep in mind"
    echo "that the computer converts the decimal number into binary and then performs the"
    echo "operation. The result is displayed in decimal. The "$1" operation uses the "$2" symbol."
    if [[ $3 != "Unused" ]]
    then
        echo $3" is used to assign the result to the variable on the left side of the equation."
    fi
    echo; echo $Dash
}

function BoolResult
{
    echo; echo "What happened? First, we must convert the numbers to binary."; echo
    echo "         1"
    echo "         2 6 3 1"
    echo "         8 4 2 6 8 4 2 1"
    echo "         ---------------"
    echo $1" is  :" $2
    echo $3" is  :" $4
    echo; echo "Because we are "$5"ing, we look for columns that have "$6"."
    echo "When we find any, we carry the 1 down. Any that don't match this rule"
    echo "gets a 0. The result is:"; echo
    echo "        128  64  32  16   8   4   2   1"
    echo "        -------------------------------"

}

function BoolFinal
{
    echo; echo "Now, add the values of the 1s to get the final answer: "$1
    echo; echo "Let's look at "$2" now:"
}


function AND
{
    Var1=33; Var2=52

    BoolLines AND '&' '&='
    PrintVar; echo "Performing ((Var1&Var2)): "$((Var1&Var2))
    BoolResult 33 '0 0 1 0 0 0 0 1' 52 '0 0 1 1 0 1 0 0' AND 'all 1s'
    echo "          0   0   1   0   0   0   0   0"
    BoolFinal 32 '&='
    PrintVar; echo "Performing ((Var1&=Var2)): "$((Var1&=Var2))" - Var1 now equals: "$Var1
    Pause
    TryIt ANDing
}

function OR
{
    Var1=17; Var2=66

    BoolLines OR '|' '|='
    PrintVar; echo "Performing ((Var1|Var2)): "$((Var1|Var2))
    BoolResult 17 '0 0 0 1 0 0 0 1' 66 '0 1 0 0 0 0 1 0' OR 'any 1s'
    echo "          0   1   0   1   0   0   1   1"
    BoolFinal 83 '|='
    PrintVar; echo "Performing ((Var1|=Var2)): "$((Var1|=Var2))" - Var1 now equals: "$Var1
    Pause
    TryIt ORing
}

function NOT
{
	Var1=7; Var2="Not Used"

	BoolLines NOT '~' Unused
	PrintVar; echo "Performing ((~Var1)): "$((~Var1))

	echo; echo "What happened? In this case the operation is taking the 'one's complement' of"
	echo "the number given with the output being represented as a 'two's complement'."
	echo; echo "It basically involves taking the binary representation of the decimal number given,"
	echo "flipping all the 1s to 0s and 0s to 1s. For more information, visit:"
	echo "https://en.wikipedia.org/wiki/Two%27s_complement"; echo
	echo "The effect is (for non zero):"
	echo "for a positive number, add one and multiply by -1"
	echo "for a negative number, subtract one and multiply by -1"
    
	Var1=
	while :
	do
        	echo; read -p "Try a few for yourself, enter a number (Enter to quit): " Var1
	        if [[ ! $Var1 ]]
	        then
	            break
	        else
	            echo; echo "The result of ((~"$Var1")) is: "$((~Var1))
		fi
	done

	Pause
}

function XOR
{
    Var1=27; Var2=20

    BoolLines XOR '^' '^='
    PrintVar; echo "Performing ((Var1^Var2)): "$((Var1^Var2))
    BoolResult 27 '0 0 0 1 1 0 1 1' 20 '0 0 0 1 0 1 0 0' XOR 'any, but not all, 1s'
    echo "          0   0   0   0   1   1   1   1"
    BoolFinal 15 '^='
    PrintVar; echo "Performing ((Var1^=Var2)): "$((Var1^=Var2))" - Var1 now equals: "$Var1
    Pause
    TryIt XORing
}

## Start main script
while :
do
    CE; echo "This script show how to use some advanced bash mathematical operations."; echo
    echo; echo "A) (arithmetic) Incrementing and assignment using +="
    echo; echo "B) (arithmetic) Decrementing and assignment using -="
    echo; echo "C) (arithmetic) Multiplication and assignment using *="
    echo; echo "D) (arithmetic) Division and assignment using /="
    echo; echo "E) (arithmetic) Modular function and assignment using %="
    echo; echo "F) (bit shifting) Shifting bits right and assignment using >> and >>="
    echo; echo "G) (bit shifting) Shifting bits left and assignment using << and <<="
    echo; echo "H) (booleans) Logical ANDing and assignment using & and &="
    echo; echo "I) (booleans) Logical ORing and assignment using | and |="
    echo; echo "J) (booleans) Logical NOTing [two's compliment] using ~"
    echo; echo "K) (booleans) Logical XORing [eXclusive OR] and assignment using ^ and ^="
    echo; echo; echo "Z) Quit"
    echo; read -p "Please choose from one of the options: " Choice; Choice=${Choice^^}

    case $Choice in
        A) Inc ;; B) Dec ;; C) Mul ;; D) Div ;; E) Mod ;; F) Rbit ;; G) Lbit ;;
        H) AND ;; I) OR ;;  J) NOT ;; K) XOR ;; Z) break ;;
        *) echo; echo "Invalid choice, please try again!"; Pause 0
    esac
done

echo; echo "Thanks for using my script!"; echo
