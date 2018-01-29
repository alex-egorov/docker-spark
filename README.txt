
curl http://www.gutenberg.org/cache/epub/20916/pg20916.txt | hdfs dfs -put - /wordcount/arabian_nights.txt
curl http://www.gutenberg.org/cache/epub/31547/pg31547.txt | hdfs dfs -put - /wordcount/youth.txt
curl http://www.gutenberg.org/files/2554/2554-0.txt | hdfs dfs -put - /wordcount/crime_and_punishment.txt
