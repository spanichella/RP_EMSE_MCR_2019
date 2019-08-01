#!/bin/bash

# make sure we get proper decimals
LANG=en_us_8859_1

FILES=/home/mbeller/TestSummarizationWorkspaces/results/Participant*
OUTPUT=results.csv

if [ -f $OUTPUT ] 
then
	rm $OUTPUT
fi

echo "file, diffTests, diffAsserts, editDist" >> $OUTPUT
for f in $FILES
do
	  echo "Processing file $f ..."
	  RESULT=$(ruby analyze_submission.rb $f/workspace/Task1/src/org/magee/math/TestRational.java)
	  echo "$RESULT" >> $OUTPUT
	  RESULT=$(ruby analyze_submission.rb $f/workspace/Task2/src/org/apache/commons/collections/primitives/TestArrayIntList.java)
	  echo "$RESULT" >> $OUTPUT
done
