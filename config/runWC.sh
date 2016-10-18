#!/bin/bash

# test the hadoop cluster by running wordcount

# create input files 
mkdir input
echo "Macquarie MRes COMP777 S22016" >input/file1.txt
echo "Macquarie MRes S22016" >input/file2.txt
echo "COMP777 Young" >input/file3.txt
echo "Macquarie Young Choon Lee" >input/file4.txt
echo "S22016 Young Choon" >input/file5.txt


# create input directory on HDFS
hadoop fs -mkdir -p input

# put input files to HDFS
hdfs dfs -put ./input/* input

# run wordcount 
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/sources/hadoop-mapreduce-examples-$HADOOP_VERSION-sources.jar org.apache.hadoop.examples.WordCount input output

# print the input files
echo -e "\ninput file1.txt:"
hdfs dfs -cat input/file1.txt

echo -e "\ninput file2.txt:"
hdfs dfs -cat input/file2.txt

echo -e "\ninput file3.txt:"
hdfs dfs -cat input/file3.txt

echo -e "\ninput file4.txt:"
hdfs dfs -cat input/file4.txt

echo -e "\ninput file5.txt:"
hdfs dfs -cat input/file5.txt

# print the output of wordcount
echo -e "\nwordcount output:"
hdfs dfs -cat output/part-r-00000
