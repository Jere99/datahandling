## ---- echo=FALSE, results='asis', warning=FALSE---------------------------------------------------
# conditional on the output format of the whole document,
# generate and render a HTML or a LaTeX table.
if (knitr::is_latex_output()) {
  
  cat('
  \\begin{center}
  \\href{http://creativecommons.org/licenses/by-nc-sa/4.0/}{\\includegraphics[width = .1\\textwidth]{../img/cc.png}}
  
  \\smallskip
  
  This work is licensed under a \\href{http://creativecommons.org/licenses/by-nc-sa/4.0/}{Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License}
  \\end{center}
  '
  )
  
} else {
     cat('
     
   <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.
   
')
}


## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
library(tidyverse)


## -------------------------------------------------------------------------------------------------
messy_df <- data.frame(last_name = c("Wayne", "Trump", "Karl Marx"),
                       first_name = c("John", "Melania", ""),
                       gender = c("male", "female", "Man"),
                       date = c("2018-11-15", "2018.11.01", "2018/11/02"),
                       income = c("150,000", "250000", "10000"),
                       stringsAsFactors = FALSE)


## -------------------------------------------------------------------------------------------------
messy_df$gender <- as.factor(messy_df$gender)
messy_df$gender


## -------------------------------------------------------------------------------------------------
messy_df$gender[messy_df$gender == "Man"] <- "male"
messy_df$gender


## -------------------------------------------------------------------------------------------------
messy_df$gender <- fct_recode(messy_df$gender, "male" = "Man")
messy_df$gender


## -------------------------------------------------------------------------------------------------
as.integer(messy_df$income)


## -------------------------------------------------------------------------------------------------
messy_df$income <- str_replace(messy_df$income, pattern = ",", replacement = "")


## -------------------------------------------------------------------------------------------------
messy_df$income <- as.integer(messy_df$income)


## -------------------------------------------------------------------------------------------------
splitnames <- str_split(messy_df$last_name, pattern = " ", simplify = TRUE)
splitnames


## -------------------------------------------------------------------------------------------------
problem_cases <- messy_df$first_name == ""
messy_df$first_name[problem_cases] <- splitnames[problem_cases, 1]


## -------------------------------------------------------------------------------------------------
messy_df$last_name[problem_cases] <- splitnames[problem_cases, 2]
messy_df


## ----message=FALSE--------------------------------------------------------------------------------
library(lubridate)


## -------------------------------------------------------------------------------------------------
messy_df$date <- ymd(messy_df$date)


## -------------------------------------------------------------------------------------------------
messy_df


## -------------------------------------------------------------------------------------------------
str(messy_df)






## ----echo=FALSE, warning=FALSE, message=FALSE-----------------------------------------------------
tidydata <- gather(data = rawdata, treatmenta, treatmentb, key = "treatment", value = "result" )
tidydata$treatment <- gsub("treatment", "", tidydata$treatment)




## -------------------------------------------------------------------------------------------------
wide_df <- data.frame(last_name = c("Wayne", "Trump", "Marx"),
                       first_name = c("John", "Melania", "Karl"),
                       gender = c("male", "female", "male"),
                       income.2018 = c("150000", "250000", "10000"),
                      income.2017 = c( "140000", "230000", "15000"),
                      stringsAsFactors = FALSE)
wide_df


## -------------------------------------------------------------------------------------------------
long_df <- gather(wide_df, income.2018, income.2017, key = "year", value = "income")
long_df


## -------------------------------------------------------------------------------------------------
long_df$year <- str_replace(long_df$year, "income.", "")
long_df


## -------------------------------------------------------------------------------------------------
weird_df <- data.frame(last_name = c("Wayne", "Trump", "Marx",
                                     "Wayne", "Trump", "Marx",
                                     "Wayne", "Trump", "Marx"),
                       first_name = c("John", "Melania", "Karl",
                                      "John", "Melania", "Karl",
                                      "John", "Melania", "Karl"),
                       gender = c("male", "female", "male",
                                  "male", "female", "male",
                                  "male", "female", "male"),
                       value = c("150000", "250000", "10000",
                                 "2000000", "5000000", "NA",
                                 "50", "25", "NA"),
                       variable = c("income", "income", "income",
                                    "assets", "assets", "assets",
                                    "age", "age", "age"),
                       stringsAsFactors = FALSE)
weird_df


## -------------------------------------------------------------------------------------------------
tidy_df <- spread(weird_df, key = "variable", value = "value")
tidy_df

