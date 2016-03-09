

# Tidyr.big

## Introduction

`Tidyr` and `dplyr` are the cornerstones of data manipulation according to @hadley, and they've taken the R world by storm. But the two cornerstones are not equally strong. While `dplyr` has a system of swappable backends, `tidyr` doesn't. `tidyr` works only on data stored in the memory of a single machine, and runs in a single thread. There isn't any particular reason why big data may not need tidying as much as small data. The only problem is that it's hard to implement. [Quoting](https://github.com/hadley/tidyr/issues/138) @hadley "I always assumed `gather`/`spread` in SQL would be prohibitively difficult". This package starts to fill that void by providing two backends for tidyr, based on Hive and Spark SQL respectively.
While pure SQL implementations of `spread` and `gather` are possible (you will find them still hidden in the source code, in case they become useful later on), I have to agree efficient implementations seem to be harder. A `gather` is equivalent to the union of a number of simple select statements and a `spread` requires multiple self joins, which query optimizers are unable to simplify. To achieve better efficiency, we use some SQL extensions in the form of user-defined functions from the brickhouse project. These allow one- and two-pass implementations respectively for `gather` and `spread`. This package also provides implementations for `separate`, `unite` and `expand`. Unfortunately, the last is very slow in Spark SQL most likely due to a bug in cross joins. 


## Installation and configuration

Make sure that you have installed and configured [`dplyr.spark.hive`](https://github.com/rzilla/dplyr.spark.hive) on which this package depends. That implies having access to spark or hive. Then you need the brickhouse extension. You can compile from [source](https://github.com/klout/brickhouse) or grab the [latest jar](https://github.com/klout/brickhouse/wiki/Downloads). 
You need to make the jar available, say by copying it to hdfs for a cluster or a local file in standalone mode. Set the env variable BRICKHOUSE_JAR to the corresponding URL, say hdfs:///user/me/lib/brickhouse-0.6.0.jar. After creating a source with dplyr, you can enable `tidyr` primitves on that source calling `brickhouse.extension`. Finally, you can install "tidyr.big"  with 

```
install.packages("dplyr.spark.hive", repos = c("http://archive.rzilla.org", getOption("repos")))
```

Finally you are ready to start using it. You normally want to load also `dplyr` and `dplyr.spark.hive` for full data manipilation powers,  but you don't have to.

```
library(dplyr)
library(dplyr.spark.hive)
library(tidyr)
library(tidyr.big)
src = src_SparkSQL(myhost, myport)
brickhouse.extension(src)
```

Now you can use `gather` and `spread` and other `tidyr` functions on tables from that source.



The current version is 0.1.0 .

## Feedback

Please report problem and suggest features by submitting an [issue](https://github.com/rzilla/tidyr.big/issues). You may also want to check current issues for known problems. More general open ended discussion can take place on the [rzilla forum](https://groups.google.com/forum/#!forum/rzilla)


