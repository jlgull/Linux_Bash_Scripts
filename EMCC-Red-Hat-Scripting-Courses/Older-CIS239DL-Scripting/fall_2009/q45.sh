#! /bin/bash
# Jonathan Heard for CIS239DL Fall 2014
# Fri Oct 10 22:26:34 MST 2014
# practice for quiz question 45
# Question about Case

case $(pwd) in
  /) echo "You are in the / directory"
  ;;
  $HOME) echo "Your are in your home directory."
  ;;
  *) echo "You are in neither root nor your home directory."
  ;;
esac

