\name{brickhouse.extension}
\alias{brickhouse.extension}
\title{
Extend a source with capabilites that are needed by tidyr.big
}
\description{
Call on a hive or spark SQL source before using tidyr functions on tables from that source
}
\usage{
brickhouse.extension(src)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{src}{ A Hive or SparkSQL source}
}
\details{
Currently needed only for spread and gather. Can be called anytime between source creation and the first use of these functions.
}
\value{
NULL, acts by side effect.
}
\references{
\url{https://github.com/klout/brickhouse}}
