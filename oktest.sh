#!/bin/bash

# Stupidly simple test script.
# Invoke with oktest.sh <script.py> <test>

# This code is trivial and therefore I release it into thes public domain.
# See LICENSE

# Owain Kenway, 2015

if [ "$#" -ne 2 ]; then
   echo "Please read code."
   echo "Invoke with:"
   echo "  oktest.sh <script.py> <test>"
   echo "Where <script.py> is your python program, and <test> maps to two files, <test>.in (sets up environment for the test) and <test>.good (expected output)."
   echo "A file <test>.out will be written with your test's output."

else
   code=$1
   testname=$2

   testin=$2.in
   testout=$2.out
   testgood=$2.good

   date=`date +%s`

# Create a temporary file name that's probably unique.
   temppy=.oktest.${1}.${2}.${date}.py

   cat $testin > $temppy
   cat $code >> $temppy

   python -u $temppy > $testout

   diff $testgood $testout

   success=$?

   if [ "$success" -eq 0 ]; then
      echo "Test passed."
   else
      echo "Test failed."
   fi

# Delete temporary script.
   rm $temppy
fi

exit $success
