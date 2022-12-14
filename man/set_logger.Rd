% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/logger_utils.R
\name{set_logger}
\alias{set_logger}
\title{Set Logger Settings}
\usage{
set_logger(logger_file_path = "CRE.log", logger_level = "INFO")
}
\arguments{
\item{logger_file_path}{A path (including file name) to log the messages.
(Default: CRE.log)}

\item{logger_level}{The log level. Available levels include:
\itemize{
\item TRACE
\item DEBUG
\item INFO (Default)
\item SUCCESS
\item WARN
\item ERROR
\item FATAL
}}
}
\value{
No return value. This function is called for side effects.
}
\description{
Updates logger settings, including log level and location of the file.
}
\examples{

set_logger("Debug")

}
